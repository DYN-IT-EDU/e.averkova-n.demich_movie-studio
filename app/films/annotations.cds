using FilmsService as service from '../../srv/films-services';
annotate service.Films with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'genreName',
                Value : genreName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'realeaseDate',
                Value : realeaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'budget',
                Value : budget
            },
            {
                $Type : 'UI.DataField',
                Label : 'duration',
                Value : duration,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
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
                Label : '{i18n>Description1}',
                Value : description,
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
                Value: budget,
                Label : '{i18n>Budget}'
            },
            {
                $Type : 'UI.DataField',
                Value : filmStatus_code,
                Criticality : filmStatus.criticality,
                Label : '{i18n>Statuscode}'
            }
        ],
    },
    UI.SelectionFields : [
        realeaseDate,
        genreName,
    ],
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
        Common.Label : '{i18n>ReleaseDate}',
    );
};

annotate service.Films with @odata.draft.enabled;
