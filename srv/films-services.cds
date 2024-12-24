using {sap.capire.moviestudio as m} from '../db/schema';

service FilmsService @(path: '/films') {
    entity Films                            as
        projection on m.Films {
            title,
            genre.name        as genreName,
            description,
            realeaseDate,
            budget,
            boxOffice,
            duration,
            roles.person.name as actor
        }

    @readonly
    entity FilmsByDirector                  as
        select from m.Films {
            title,
            genre.name as genreName,
            description,
            director.name
        }
        group by
            director.name;

    entity FilmsByTitleView(title : String) as
        select from Films
        where Films.title = :title;

    function GetFilmsByDuration(duration : Integer) returns array of Films;

    function sleep() returns Boolean;
}
