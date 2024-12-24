const cds = require('@sap/cds');

module.exports = class SchedulesServise extends cds.ApplicationService {
    init() {
        const { Schedules } = this.entities;
        
        this.on('AddSchedule', async (req) => {
            const { filmID, crewID, locationID, shoots } = req.data;

            const newSchedule = {
                film: { ID: filmID },
                crew: { ID: crewID },
                location: { ID: locationID },
                shoots: shoots.map((shoot) => ({
                    startDate: shoot.startDate,
                    endDate: shoot.endDate,
                    description: shoot.description
                }))
            };

            const createdSchedule = await cds.run(INSERT.into(Schedules).entries(newSchedule));
            return createdSchedule;
        });

        this.on('GetSchedules', async (req) => {
            return SELECT.from(Schedules, s => ({
                shoots: s.shoots,
                locationName: s.location.locationName
            }));
        });

        return super.init();
    }
}
