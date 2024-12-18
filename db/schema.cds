using {
  cuid,
  managed,
  Country,
  sap.common.CodeList,
} from '@sap/cds/common';

namespace sap.capire.moviestudio;

entity Genres : cuid {
    name : String @mandatory;

    films : Association to many Films on films.genre = $self;
}

entity Films : cuid, managed {
    title : String @mandatory;
    description : String;
    realeaseDate : Date;
    budget      : Money;                                                
    boxOffice   : Money;                                              
    duration    : Integer;

    genre : Association to Genres @mandatory @assert.tsarget;
    finances : Composition of many Finances on finances.film = $self;
    schedules : Composition of many Schedules on schedules.film = $self;
    crew : Composition of many Crew on crew.film = $self;
    roles : Composition of many Roles;
    director : Association to Persons;
    contracts : Composition of many Contracts on contracts.film = $self;
    expenses    : Composition of many Expenses on expenses.film = $self;
}

entity Finances : cuid, managed {
    expensiveType : String;
    amount : Decimal;
    date : Date;
    description : String;

    film : Association to Films;
}

entity Persons : cuid {
    firstName : String @mandatory;
    lastName : String @mandatory;
    name        : String = firstName ||' '|| lastName;
    dateOfBirth : Date;
    contact : many {
        type : String;
        description : String;
    };

    directors   : Association to many Films on directors.director = $self;
    crew : Association to many Crew on crew.person = $self;
    roles : Composition of many Roles;
    contracts : Composition of many Contracts on contracts.person = $self;
}

entity Locations : cuid {
    locationName : String @mandatory;
    address : Address;

    schedules : Composition of many Schedules on schedules.location = $self;
}

type Address {
    street  : String;
    city    : String;
    state   : String;
    country : Country;
}

entity Roles : cuid, managed {
    characterName : String not null;

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
    shoots        : many {
    startDate   : Date;                     
    endDate     : Date;                     
    description : String;
    };

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
    positionName : String @mandatory;

    department : Association to Departments;
    crew : Composition of many Crew on crew.position = $self;
}

entity Departments : cuid {
    departmentName : String @mandatory;

    positions : Composition of many Positions on positions.department = $self;
}

entity FilmOverview as
    select 
        f.ID, 
        f.title, 
        f.description, 
        r.person.name,
        p.firstName, 
        p.lastName 
    from Roles as r
    left join Persons as p on r.ID = p.roles.ID
    left join Films as f on r.ID = f.roles.ID;

entity FilmFinancials as projection on Films {
    ID,
    title,
    budget,
    boxOffice,
    (boxOffice - budget) as profit
}

entity FilmsTotalExpenses as select from Films LEFT JOIN Expenses on Films.ID = Expenses.film.ID {
  Films.ID,
  title,
  sum(amount) as amount
}

entity ExpenseTypes : CodeList {
  key code : String enum {
    budget     = 'Budget';
    marketing  = 'Marketing';
  };
}

entity Expenses : cuid, managed {
  film        : Association to Films;                                       
  expenseType : Association to ExpenseTypes; @mandatory @assert.range: true 
  amount      : Money;                                                      
  date        : Date;                                                       
  description : String;                                                    
}

type Money : Decimal(15, 2);
