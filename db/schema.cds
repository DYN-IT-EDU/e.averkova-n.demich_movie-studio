using {
  cuid,
  managed,
  Country,
  sap.common.CodeList,
} from '@sap/cds/common';
namespace sap.capire.moviestudio;

entity Persons : cuid, managed {
  firstName   : String @mandatory;                                         // Имя
  lastName    : String @mandatory;                                         // Фамилия
  name        : String = firstName ||' '|| lastName;
  dateOfBirth : Date;                                                      // Дата рождения
  directors   : Association to many Films on directors.director = $self;
  roles       : Association to many Roles on roles.person = $self;
  crew        : Association to many Crew on crew.person = $self;
  contracts   : Composition of many Contracts on contracts.person = $self;
}

entity Genres : cuid, managed{
  name : String @mandatory;
  films : Association to many Films on films.genre = $self;
}

entity Films : cuid, managed {
  title       : String @mandatory;                                    // Название фильма
  description : String;                                               // Описание сюжета
  releaseDate : Date;                                                 // Дата выхода
  genre       : Association to Genres @mandatory @assert.tsarget;     // Жанр фильма
  director    : Association to Persons;                               // Режиссёр фильма
  budget      : Money;                                                // Бюджет
  boxOffice   : Money;                                                // Сборы в кассе
  duration    : Integer;                                              // Длительность (в минутах)
  roles       : Composition of many Roles on roles.film = $self;
  crew        : Composition of many Crew on crew.film = $self;
  schedules   : Composition of many Schedules on schedules.film = $self;
  contracts   : Composition of many Contracts on contracts.film = $self;
  expenses    : Composition of many Expenses on expenses.film = $self;
}

entity FilmsDirectors as projection on Films {
  ID,
  title,
  director
}

entity FilmsTotalExpenses as select from Films LEFT JOIN Expenses on Films.ID = Expenses.film.ID {
  Films.ID,
  title,
  sum(amount) as amount
}

entity Roles : cuid, managed {
  film          : Association to Films;   // Связь с фильмом
  person        : Association to Persons; // Связь с актёром
  characterName : String;                 // Имя персонажа
}

entity Departments : cuid, managed {
  departmentName : String @mandatory; // Название департамента
  positions      : Composition of many Positions on positions.department = $self;
}

entity Positions : cuid, managed {
  positionName : String(100) @mandatory;     // Должность (например, Оператор, Художник)
  department   : Association to Departments; // Связь с департаментом
  crew         : Association to many Crew on crew.position = $self;
}

entity Crew : cuid, managed {
  film     : Association to Films;     // Связь с фильмом
  person   : Association to Persons;   // Связь с персоной
  position : Association to Positions; // Связь с позицией
}

entity Locations : cuid, managed {
  locationName : String @mandatory; // Название локации
  country      : Country;
  address      : String;            // Адрес
  schedules    : Association to many Schedules on schedules.location = $self;
}

entity Schedules : cuid, managed {
  film          : Association to Films;     // Связь с фильмом
  location      : Association to Locations; // Связь с локацией
  shoots        : many {
    startDate   : Date;                     // Дата начала съёмок
    endDate     : Date;                     // Дата окончания 
    description : String;
  };
}

entity Contracts : cuid, managed {
  person    : Association to Persons; // Связь с персоной (актером, сотрудником)
  film      : Association to Films;   // Связь с фильмом, если контракт относится к конкретному проекту
  startDate : Date;                   // Дата начала контракта
  endDate   : Date;                   // Дата окончания контракта
  terms     : String;                 // Условия контракта
}

entity ExpenseTypes : CodeList {
  key code : String enum {
    budget     = 'Budget';
    marketing  = 'Marketing';
  };
}

entity Expenses : cuid, managed {
  film        : Association to Films;                                       // Связь с фильмом
  expenseType : Association to ExpenseTypes; @mandatory @assert.range: true // Тип расхода (бюджет, маркетинг и т.д.)
  amount      : Money;                                                      // Сумма
  date        : Date;                                                       // Дата транзакции
  description : String;                                                     // Описание
}

type Money : Decimal(15, 2);