const cds = require('@sap/cds');

module.exports = class SchedulesServise extends cds.ApplicationService {
    init() {
        const { Films } = this.entities;

        this.before('GetFilmsByDuration', Films, async (req) => {
            const { duration } = req.data;
            if (duration < 0) req.error`${{ duration }} must be >= ${0}`;
        });

        this.after('each', Films, film => {
            film.boxOffice += 1000;
        });

        this.on('GetFilmsByDuration', async (req) => {
            const { duration } = req.data;
            return cds.run(SELECT.from(Films).where({ duration: { ">": duration } }));
        });

        this.on('sleep', async () => {
            try {
                let dbQuery = ' Call "sleep"( )'
                let result = await cds.run(dbQuery, {})
                cds.log().info(result)
                return true
            } catch (error) {
                cds.log().error(error)
                return false
            }
        });

        return super.init();
    }
}