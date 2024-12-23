const cds = require("@sap/cds");

class MovieStudioService extends cds.ApplicationService {
  init() {
    this.on("ShowHighBudgetFilms", this.ShowHighBudgetFilms);
    this.on("ChangeFilmDirector", this.ChangeFilmDirector);
    return super.init();
  }

  async ShowHighBudgetFilms() {
    const { Films } = this.entities;
    const expr = SELECT.from(Films).where({ budget: { ">=": 100000000 } });
    const res = await cds.run(expr);

    return res;
  }

  async ChangeFilmDirector(filmID, directorID) {
    const { Persons, Films } = this.entities;
    
    const director = await SELECT.one.from(Persons).where({ ID: directorID });
    if (!director) {
      return "FAILURE! Could not find director";
    }

    const film = await SELECT.one.from(Films).where({ ID: filmID });
    if (!director) {
      return "FAILURE! Could not find film";
    }

    await UPDATE(Films)
        .set({ director_ID: directorID })
        .where({ ID: filmID });

    return "SUCCESS";
  }
}

module.exports = MovieStudioService;