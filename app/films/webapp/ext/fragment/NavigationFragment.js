sap.ui.define([
    "sap/m/Popover",
    "sap/m/List",
    "sap/m/StandardListItem"
  ], function(Popover, List, StandardListItem) {
    "use strict";
    var _oPopover;

    return {
      onPress: function(oEvent) {
        var oButton = oEvent.getSource();
        var oContext = oButton.getBindingContext();

        if (!_oPopover) {
          _oPopover = new Popover({
            showHeader: false,
            placement: "Bottom",
            content: new List({
              items: [
                new StandardListItem({
                  title: "Film",
                  type: "Active",
                  press: function(oEvent) {
                    var oCtx = _oPopover.data("oContext");
                    _oPopover.close();
                    var sCurrentUrl = window.location.href;
                    var sEntityPath = oCtx.getPath();
                    var sTargetUrl = sCurrentUrl + "#" + sEntityPath;
                    window.location.href = sTargetUrl;
                  }
                }),
                new StandardListItem({
                  title: "Genre",
                  type: "Active",
                  press: function(oEvent) {
                    var oCtx = _oPopover.data("oContext");
                    _oPopover.close();
                    var oFilmData = oCtx.getObject();
                    var sGenreKey = oFilmData.genre.ID; 
                    var sCurrentUrl = window.location.href;
                    var sTargetUrl = sCurrentUrl + "#/Genres(ID=" + sGenreKey + ")";
                    window.location.href = sTargetUrl;
                  }
                })
              ]
            })
          });
        }
        _oPopover.data("oContext", oContext);
        _oPopover.openBy(oButton);
      }
    };
  });