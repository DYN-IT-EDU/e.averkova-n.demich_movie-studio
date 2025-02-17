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
                Value : genreName,
                Label : '{i18n>Genrename}',
            },
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
    },
);

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
        },
)};

annotate service.Genres with {
    ID @Common.Text : name
};

