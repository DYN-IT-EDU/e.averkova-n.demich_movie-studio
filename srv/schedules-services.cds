using {sap.capire.moviestudio as m} from '../db/schema';

service SchedulesService @(path: '/schedules') {
    @readonly
    entity Schedules as projection on m.Schedules;

    action   AddSchedule(crewID : Integer,
                         locationID : Integer,
                         shoots : {
        startDate : Date;
        endDate : Date;
        description : String;
    })                      returns Schedules;

    function GetSchedules() returns array of Schedules;
}
