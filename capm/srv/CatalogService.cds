using {mithra.db} from '../db/datamodel';

service CatalogService @(path:'/CatalogService')
        @(requires: 'authenticated-user'){
    @Capabilities : { Insertable,Updatable,Deletable, }
    entity BPSet as projection on db.businesspartner;
    entity productSet as projection on db.product;
    entity AddressSet as projection on db.Address;
    entity EmployeeSet @(restrict: [
        {
            grant: ['READ'],
            to: 'Viewer',
            where: 'bankName = $user.BankName'
        },
        {
            grant: ['WRITE','READ'],
            to: 'Admin'
        }
    ])
    as projection on db.Employee;

    entity POs @(
        title: '{i18n>poHeader}',
        odata.draft.enabled:true
    ) as projection on db.purchaseorder{
        *,
        round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15,2),
        case LIFECYCLE_STATUS
            when 'N' then 'New'
            when 'D' then 'Deliverd'
            when 'B' then 'Blocked'
            end as LIFECYCLE_STATUS:String(20),
        case LIFECYCLE_STATUS
            when 'N' then 2
            when 'B' then 1
            when 'D' then 3
            end as Criticality:Integer,
        Items:redirected to POItems
    }actions{
        function largestOrder() returns array of POs;
        action boost();
    }
    annotate POs with {
        GROSS_AMOUNT @title : '{i18n>GROSS_AMOUNT}';
    }
    
    entity POItems @( title:'{i18n>poItems}')
    as projection on db.poitems{
        *,
        PARENT_KEY:redirected to POs,
        PRODUCT_GUID:redirected to productSet
    }
}

