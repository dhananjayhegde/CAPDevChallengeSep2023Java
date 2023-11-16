sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'test/center/testcenter/test/integration/FirstJourney',
		'test/center/testcenter/test/integration/pages/TestsList',
		'test/center/testcenter/test/integration/pages/TestsObjectPage',
		'test/center/testcenter/test/integration/pages/QuestionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, TestsList, TestsObjectPage, QuestionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('test/center/testcenter') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTestsList: TestsList,
					onTheTestsObjectPage: TestsObjectPage,
					onTheQuestionsObjectPage: QuestionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);