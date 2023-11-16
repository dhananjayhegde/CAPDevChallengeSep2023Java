package com.sap.cap.testcenter.handlers;

import java.lang.Long;

import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import com.sap.cds.services.handler.EventHandler;
import org.springframework.stereotype.Component;

import org.springframework.beans.factory.annotation.Autowired;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;
import com.sap.cds.services.handler.annotations.On;

import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.ql.cqn.CqnUpdate;
import com.sap.cds.CdsLockTimeoutException;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.devchallengeservice.DevChallengeService_;
import cds.gen.devchallengeservice.Tests_;
import cds.gen.devchallengeservice.AssignQuestionsToTestContext;
import cds.gen.devchallengeservice.Questions_;
import cds.gen.devchallengeservice.Tests;
import cds.gen.devchallengeservice.Questions;

@Component
@ServiceName(DevChallengeService_.CDS_NAME)
public class DevChallengeServiceHandler implements EventHandler {
    @Autowired
    PersistenceService db;

    @On(event = AssignQuestionsToTestContext.CDS_NAME, entity = Tests_.CDS_NAME)
    public void assignQuestionsToTestAction(AssignQuestionsToTestContext context) {

        // Get the current Test instance to which questions need to be assigned to
        CqnSelect selectTest = context.getCqn();
        Tests test = db.run(selectTest).single(Tests.class); // .listOf(Tests.class);

        System.out.println(">>> Assign to test with ID:" + test.getId());

        // Input parameter questionsCount
        Integer questionsCount = context.getQuestionsCount();

        String result = "";
        System.out.println(">>> Reached here...");

        // Sanity checks
        if (questionsCount < 1) {
            result = "Questions Count should be at least 1";
            System.out.println(result);
            context.setResult(result);
            return;
        }

        Messages message = context.getMessages();

        // Pick questionsCount number of questions and assign them to Test 'selectTest'
        try {
            CqnSelect selQuestion = Select.from(Questions_.class).columns("ID", "test_ID")
                    .where(b -> b.test_ID().isNull()).limit(questionsCount).lock();

            List<Questions> questions = db.run(selQuestion).listOf(Questions.class);

            int avlblQCount = questions.size();

            System.out.println(">>> Available Questoins: " + avlblQCount);

            if (avlblQCount > 0) {
                questions.forEach(q -> q.setTestId(test.getId()));

                CqnUpdate updateQuestions = Update.entity(Questions_.CDS_NAME).entries(questions);
                long updateCount = db.run(updateQuestions).rowCount();

                System.out.println(">>> Updated Questoins: " + updateCount);

                if (avlblQCount < questionsCount) {
                    // message.warn("Only " + updateCount + " questions were assigned to Test, create more questions!");
                    result = "Only " + updateCount + " questions were assigned to Test, create more questions!";
                } else {
                    // message.success(updateCount + " questions were assigned to Test");
                    result = updateCount + " questions were assigned to Test";
                }
            } else {
                // message.error("No questions were assigned to Test, create more questions").code("NOQ");
                result = "No questions were assigned to Test, create more questions";
            }
        } catch (CdsLockTimeoutException lockTimeOut) {
            result = "Could not read the questions for update";
            // message.error("Could not read the questions for update");
        }

        context.setResult(result);
    }

}