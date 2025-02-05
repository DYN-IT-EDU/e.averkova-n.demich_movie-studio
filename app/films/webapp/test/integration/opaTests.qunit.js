sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sap/capire/moviestudio/films/test/integration/FirstJourney',
		'sap/capire/moviestudio/films/test/integration/pages/FilmsList',
		'sap/capire/moviestudio/films/test/integration/pages/FilmsObjectPage'
    ],
    function(JourneyRunner, opaJourney, FilmsList, FilmsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sap/capire/moviestudio/films') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheFilmsList: FilmsList,
					onTheFilmsObjectPage: FilmsObjectPage
                }
            },
            opaJourney.run
        );
    }
);