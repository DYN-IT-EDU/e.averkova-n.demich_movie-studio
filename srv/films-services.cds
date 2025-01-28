using {sap.capire.moviestudio as m} from '../db/schema';

service FilmsService @(path: '/films') {
    @requires           : 'authenticated-user'
    entity Films                            as
        projection on m.Films {
            key ID,
            title,
            genre.name        as genreName,
            description,
            realeaseDate,
            budget,
            boxOffice,
            duration,
            roles.person.name as actor
        }

    @requires: 'films-services.Admin'
    entity FilmsByDirector                  as
        select from m.Films {
            key ID,
            title,
            genre.name as genreName,
            description,
            director.name
        }
        group by
            ID,
            director.name,
            title,
            genre.name,
            description;

    @requires: 'films-services.Viewer'
    entity FilmsByTitleView(title : String) as
        select from Films
        where Films.title = :title;

    @requires: 'films-services.Viewer'
    function GetFilmsByDuration(duration : Integer) returns array of Films;

    @requires: 'films-services.Viewer'
    function sleep() returns Boolean;
}
