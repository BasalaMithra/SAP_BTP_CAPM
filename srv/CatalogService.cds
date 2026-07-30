using {mithra.db} from '../db/datamodel';

service CatalogService @(path:'/CatalogService'){
    @Capabilities : { Insertable,Updatable,Deletable, }
    entity businesspartnerSet as projection on db.businesspartner;
    entity productSet as projection on db.product;
    entity prodtextSet as projection on db.prodtext;
    entity AddressSet as projection on db.Address;

    entity POs @(
        title: '{i18n>poHeader}',
        odata.draft.enabled:true
    ) as projection on db.purchaseorder{
        *,
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
    }
    entity POItems @( title:'{i18n>poItems}')
    as projection on db.poitems{
        *,
        PARENT_KEY:redirected to POs,
        PRODUCT_GUID:redirected to productSet
    }
}

