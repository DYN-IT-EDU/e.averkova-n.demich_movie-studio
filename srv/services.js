const cds = require("@sap/cds");

class MovieStudioService extends cds.ApplicationService {
  init() {
    const { Films } = this.entities;
    this.before("UPDATE", Films, this.beforeUpdateFilm);
    this.after("READ", Films, this.afterReadFilms);
    this.on("ShowHighBudgetFilms", this.ShowHighBudgetFilms);
    this.on("ChangeFilmDirector", this.ChangeFilmDirector);
    return super.init();
  }

  async afterReadFilms(res) {
    for (let r of res) {
      if (r.budget >= 100000000) { r.title += ' -- High budget!'; }
    }
  }

  async beforeUpdateFilm(req) {
    const { director_ID } = req.data;
    if (director_ID == "PERSON_UUID_3") {
      req.reject("Banned director!");
    }
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