using { cuid, managed } from '@sap/cds/common';

entity Genres : cuid {
    name : String not null;

    film : Association to many Films on film.genre = $self;
}

entity Films : cuid, managed {
    title : String not null;
    description : String;
    realeaseDate : Date;
    budget : Decimal;
    boxOffice : Decimal;
    duration : DateTime;

    genre : Association to Genres;
    finance : Composition of many Finances on finance.film = $self;
    schedule : Composition of many Schedules on schedule.film = $self;
    crew : Composition of many Crew on crew.film = $self;
    role : Composition of many Roles on role.film = $self;
    director : Association to Persons;
    contract : Composition of many Contracts on contract.film = $self;
}

entity Finances : cuid, managed {
    expensiveType : String;
    amount : Decimal;
    date : Date;
    description : String;

    film : Association to Films;
}

entity Persons : cuid {
    firstName : String;
    lastName : String;
    dateOfBirth : Date;
    contact : many {
        type : String;
        description : String;
    };

    crew : Association to many Crew on crew.person = $self;
    role : Composition of many Roles on role.person = $self;
    contract : Composition of many Contracts on contract.person = $self;
}

entity Locations : cuid {
    name : String;
    address : Address;

    schedule : Composition of many Schedules on schedule.location = $self;
}

type Address {
    Street  : String;
    City    : String;
    State   : String;
    Country : String;
}

entity Roles : cuid, managed {
    name : String not null;

    person : Association to Persons;
    film : Association to Films;
}

entity Crew : cuid {
    schedule : Composition of Schedules on schedule.crew = $self;
    position : Association to Positions;
    film : Association to Films;
    person : Association to Persons;
}

entity Schedules : cuid, managed {
    startDate : Date;
    endDate : Date;

    location : Association to Locations;
    crew : Association to Crew;
    film : Association to Films;
}

entity Contracts : cuid, managed {
    startDate : Date;
    endDate : Date;
    terms : String;

    film : Association to Films;
    person : Association to Persons;
}

entity Positions : cuid {
    name : String not null;

    department : Association to Departments;
    crew : Composition of Crew on crew.position = $self;
}

entity Departments : cuid {
    name : String not null;

    position : Composition of many Positions on position.department = $self;
}

entity FilmOverview as
    select 
        f.ID, 
        f.title, 
        f.description, 
        r.name,
        p.firstName, 
        p.lastName 
    from Roles as r
    left join Persons as p on r.ID = p.role.ID
    left join Films as f on r.ID = f.role.ID;

entity FilmFinancials as projection on Films {
    ID,
    title,
    budget,
    boxOffice,
    (boxOffice - budget) as profit
}
