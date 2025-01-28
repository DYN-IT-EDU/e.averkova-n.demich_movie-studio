using {sap.capire.moviestudio as m} from '../db/schema';

service SchedulesService @(path: '/schedules') {
    @requires           : 'authenticated-user'
    entity Schedules as projection on m.Schedules;

    @requires: 'schedules-services.Admin'
    action   AddSchedule(crewID : Integer,
                         locationID : Integer,
                         shoots : {
        startDate : Date;
        endDate : Date;
        description : String;
    })                      returns Schedules;

    @requires: 'schedules-services.Viewer'
    function GetSchedules() returns array of Schedules;
}
