using {RiskService} from './catalog-service';

annotate RiskService.Risks with {
    title  @title : 'Title';
    prio   @title : 'Priority';
    descr  @title : 'Description';
    miti   @title : 'Mitigation';
    impact @title : 'Impact';
};


annotate RiskService.Risks with @(UI : {
    HeaderInfo       : {
        TypeName       : 'Risk',
        TypeNamePlural : 'Risks',
        Description    : {
            $Type : 'UI.DataField',
            Value : descr,
            Label : 'Description'
        },
        Title          : {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Title'
        }
    },
    SelectionFields  : [prio],
    LineItem         : [
        {Value : title},
        {Value : miti_ID},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
    ],

    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#Main',
        Label  : 'Main'
    }, ],

    FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',

        Data  : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : miti_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : prio,
            },
            {
                $Type : 'UI.DataField',
                Value : impact,
            },
        ],

    },
}

);

annotate RiskService.Risks with {
    miti @(Common : {
        Text            : 'miti.description',
        TextArrangement : #TextOnly,
        ValueList       : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Mitigations',
            Label          : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
        },
    },

    )
};


annotate RiskService.Mitigations with {
    ID          @(
        UI     : {Hidden},
        Common : {Text : 'description', }
    );
    description @title : 'Description';
    owner       @title : 'Owner';
    timeline    @title : 'Timeline';
    risks       @title : 'Risks';

};
