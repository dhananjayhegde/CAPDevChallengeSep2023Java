sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'test.center.testcenter',
            componentId: 'QuestionsObjectPage',
            entitySet: 'Questions'
        },
        CustomPageDefinitions
    );
});