using {sap.capire.moviestudio as m} from '../db/schema';

service GenresService @(path: '/genres') {
    @readonly
    entity Genres                   as projection on m.Genres;

    @readonly
    entity GenreWithFilmDescription as
        projection on m.Genres {
            name,
            films.title,
            films.description
        }

    @readonly
    entity GenreStatistics          as
        select from m.Genres as g
        left join m.Films as f
            on f.genre.ID = g.ID
        {
            g.name,
            count(
                f.ID
            ) as filmCount,
            sum(
                f.boxOffice
            ) as totalFinances
        }
        group by
            g.name;
}
