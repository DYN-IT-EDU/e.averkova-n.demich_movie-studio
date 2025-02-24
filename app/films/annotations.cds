using FilmsService as service from '../../srv/films-services';
annotate service.Films with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Title}',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description1}',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Realeasedate}',
                Value : realeaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Budget}',
                Value : budget
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Duration}',
                Value : duration,
            },
            {
                $Type : 'UI.DataField',
                Value : genre_ID,
                Label : '{i18n>Genrename}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        }
    ],
    UI.LineItem #GeneratedGroupSchedules : {
        $value : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Title}',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : duration,
                Label : '{i18n>Duration}',
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Realeasedate}',
                Value : realeaseDate,
            },
            {
                $Type : 'UI.DataField',
                Value : filmStatus_code,
                Criticality : filmStatus.criticality,
                Label : '{i18n>Statuscode}'
            }
        ],
    },
    UI.LineItem : {
        $value : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Title}',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : duration,
                Label : '{i18n>Duration}',
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Realeasedate}',
                Value : realeaseDate,
            },
            {
                $Type : 'UI.DataField',
                Value : filmStatus_code,
                Criticality : filmStatus.criticality,
                Label : '{i18n>Statuscode}'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'FilmsService.SchedulePremiere',
                Label : '{i18n>Schedulepremiere}'
            },
            {
                $Type : 'UI.DataField',
                Value : genre.name,
                Label : '{i18n>Genrename}'
            }
        ],
    },
    UI.SelectionFields : [
        realeaseDate,
        genre.name,
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Film}',
        TypeNamePlural : '{i18n>Films}',
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: description,
        }
    }
);

annotate service.FilmsAggregate with @(
  Aggregation.ApplySupported: {
    GroupableProperties: [
      genreName,
      title
    ]
  },
  Aggregation.CustomAggregate #budget: 'Edm.Int32',
  Aggregation.CustomAggregate #boxOffice: 'Edm.Int32',
  Aggregation.CustomAggregate #duration: 'Edm.Int32',
  UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'title',
        },
        {
            $Type : 'UI.DataField',
            Value : genreName,
            Label : 'genreName',
        },
        {
            $Type : 'UI.DataField',
            Value : budget,
            Label : 'budget',
        },
        {
            $Type : 'UI.DataField',
            Value : boxOffice,
            Label : 'boxOffice',
        },
        {
            $Type : 'UI.DataField',
            Value : duration,
            Label : 'duration',
        },
  ],
  UI.PresentationVariant : {
    GroupBy : [
        genreName
    ]
  },
  UI: {
          PresentationVariant: {
            Total: [
              budget,
              duration,
              boxOffice
            ],
            Visualizations: [
              '@UI.LineItem'
            ]
          }
  }
){
  budget @Analytics.Measure @Aggregation.default: #SUM;
  boxOffice @Analytics.Measure @Aggregation.default: #SUM;
  duration @Analytics.Measure @Aggregation.default: #SUM;
}

annotate service.Films with {
    realeaseDate @(
        Common.Label : '{i18n>Realeasedate}',
    );
};

annotate service.Films with @odata.draft.enabled;

annotate service.Genres with {
    name @(
        Common.Label : '{i18n>Genrename}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Genres',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                }
            ],
        },
        Common.ValueListWithFixedValues : true,
    );
};

annotate service.Films with {
    genre @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Genres',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : genre_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : genreName,
            ![@UI.TextArrangement] : #TextOnly
        }
)};

annotate service.Genres with {
    ID @Common.Text : name
};

annotate service.Genres with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
annotate service.FilmsAggregate with {
    genreName @Common.Label : 'genreName'
};

