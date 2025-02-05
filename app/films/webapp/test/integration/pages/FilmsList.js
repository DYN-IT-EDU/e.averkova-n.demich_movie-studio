sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'sap.capire.moviestudio.films',
            componentId: 'FilmsList',
            contextPath: '/Films'
        },
        CustomPageDefinitions
    );
});