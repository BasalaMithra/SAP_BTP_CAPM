using {CatalogService} from '../../srv/CatalogService';

annotate CatalogService.POs with @(
    UI:{
        SelectionFields :[
           PO_ID,
           GROSS_AMOUNT,
           LIFECYCLE_STATUS,
           CURRENCY_CODE,
           TAX_AMOUNT,
           LIFECYCLE_STATUS,
        ],
        LineItem  : [
            {
                $Type :'UI.DataField',
                Value :  PO_ID,
            },
            {
                $Type :'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type:'UI.DataFieldForAction',
                Label:'Boost',
                Action:'CatalogService.boost',
                Inline:true
            },
            {
                $Type :'UI.DataField',
                Value : CURRENCY_CODE,
            },
            {
                $Type :'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type :'UI.DataField',
                Value :PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type :'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type :'UI.DataField',
                Value : LIFECYCLE_STATUS,
                Criticality:Criticality,
                CriticalityRepresentation:#WithIcon
            } ,
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '{i18n>PurchaseOrder}',
            TypeNamePlural : '{i18n>PurchaseOrders}',
            Title:{
                Label : '{i18n>POID}',
                Value : PO_ID
            },
            Description:{
                Label: '{i18n>DESC}',
                Value:PARTNER_GUID.COMPANY_NAME
            },
            ImageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW2zm4dlp9ZAbZrDz6su1LenUegc3KGLkg2hWaIy_QllwFdlnRibX5gTAr&s=10',
        },
        Facets  : [{
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>purchaseorderGeneralInformation}',
            Target : ![@UI.FieldGroup#HeaderGeneralInformation]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>POItemsDetails}',
            Target : 'Items/@UI.LineItem',
        },  
        ],
        FieldGroup#HeaderGeneralInformation : {
            $Type : 'UI.FieldGroupType',
            Data : [
              {
                $Type :'UI.DataField',
                Value :  PO_ID,
            },
            {
                $Type :'UI.DataField',
                Value : PARTNER_GUID.EMAIL_ADDRESS,
            },
            {
                $Type :'UI.DataField',
                Value :PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type :'UI.DataField',
                Value : PARTNER_GUID.BP_ID,
            },
            {
                $Type :'UI.DataField',
                Value :GROSS_AMOUNT,
            },
            {
                $Type :'UI.DataField',
                Value :TAX_AMOUNT,
            },
            {
                $Type :'UI.DataField',
                Value :NET_AMOUNT,
            },
            {
                $Type :'UI.DataField',
                Value :LIFECYCLE_STATUS,
            }  
            ]
            
        },
    }
);
annotate CatalogService.POItems with @(
    UI:{
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value :PO_ITEM_POS ,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value :TAX_AMOUNT ,
            },
            {
                $Type : 'UI.DataField',
                Value :CURRENCY_CODE ,
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title:{
                $Type : 'UI.DataField',
                Value : NODE_KEY
            },
            Description:{
                $Type: 'UI.DataField',
                Value:PO_ITEM_POS,
            },
        } 
    }
);


        


    
  