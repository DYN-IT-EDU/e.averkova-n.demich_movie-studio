using {sap.capire.moviestudio as my} from '../db/schema';

service MovieStudio {
    entity Genres             as projection on my.Genres;
    entity Films              as projection on my.Films;
    entity Finances           as projection on my.Finances;
    entity Persons            as projection on my.Persons;
    entity Locations          as projection on my.Locations;
    entity Roles              as projection on my.Roles;
    entity Crew               as projection on my.Crew;
    entity Schedules          as projection on my.Schedules;
    entity Contracts          as projection on my.Contracts;
    entity Positions          as projection on my.Positions;
    entity Departments        as projection on my.Departments;
    entity Expenses           as projection on my.Expenses;

    @readonly
    entity FilmsFinances      as
        projection on Films {
            ID,
            title,
            budget,
            boxOffice
        }

    @readonly
    entity FilmsTotalExpenses as
        select from Films
        left join Expenses
            on Films.ID = Expenses.film.ID
        {
            Films.ID,
            title,
            sum(amount) as amount
        }
        group by
            Films.ID;

    // entity FilmTitle(filmID : String) as
    //     select from my.Films
    //     where Films.ID = :filmID;

    function ShowHighBudgetFilms() returns array of Films;

    action ChangeFilmDirector(filmID: my.Films:ID, directorID: my.Persons:ID) returns String;
}
