sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'sap.capire.moviestudio.films',
            componentId: 'FilmsObjectPage',
            contextPath: '/Films'
        },
        CustomPageDefinitions
    );
});