using { cuid, managed } from '@sap/cds/common'; 

namespace fullstack_dev_challenge; 

entity Tests: cuid, managed { 
    title : String(30);
    description: String(111);
    questions: Composition of many Questions on questions.test = $self;
} 

entity Questions: cuid{ 
    text: String(111);
    test: Association to one Tests;
    answers: Composition of one Answers; // on answers.question = $self;
} 

aspect Answers: cuid { 
    text: String;
    // question: Association to one Questions;
} 