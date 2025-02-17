using {sap.capire.moviestudio as m} from '../db/schema';

service FilmsService @(path: '/films') {
    entity Genres as projection on m.Genres;

    @requires           : 'authenticated-user'
    @cds.redirection.target
    entity Films                            as
        projection on m.Films {
            key ID,
            title,
            genre,
            genre.name as genreName,
            description,
            realeaseDate,
            budget,
            boxOffice,
            duration,
            filmStatus.name as filmStatusName,
            filmStatus,
            roles.person.name as actor,
        } actions {
            @(Common.SideEffects: {TargetProperties: ['in/realeaseDate', ]})
            action SchedulePremiere() returns Films;
        };

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
