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
                Label : '{i18n>Genrename}',
                Value : genreName,
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
                Value : genreName,
                Label : '{i18n>Genrename}',
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
                Value : genreName,
                Label : '{i18n>Genrename}',
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
        ],
    },
    UI.SelectionFields : [
        realeaseDate,
        genreName,
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
    genreName @(
        Common.Label : '{i18n>Genrename}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Films',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : genreName,
                    ValueListProperty : 'genreName',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    );
    realeaseDate @(
        Common.Label : '{i18n>Realeasedate}',
    );
};

annotate service.Films with @odata.draft.enabled;
