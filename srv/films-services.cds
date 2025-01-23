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

    @requires: 'Admin'
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

    entity FilmsByTitleView(title : String) as
        select from Films
        where Films.title = :title;

    function GetFilmsByDuration(duration : Integer) returns array of Films;

    function sleep() returns Boolean;
}
