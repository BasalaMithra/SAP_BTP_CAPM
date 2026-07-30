namespace mithra.db;
using {mithra.db} from './datamodel';

context CDSViews {

    define view![POWorklist] as
    select from db.purchaseorder{
        key PO_ID as![PurchaseOrderId],
        PARTNER_GUID.BP_ID as![PartnerId],
        PARTNER_GUID.COMPANY_NAME as![CompanyName],
        GROSS_AMOUNT as![POGrossAmount],
        CURRENCY_CODE as![POCurrencyCode],
        LIFECYCLE_STATUS as![POStatus],
        key Items.PO_ITEM_POS as![ItemPosition],
        Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
        Items.PRODUCT_GUID.PRICE as![ProductName],
        PARTNER_GUID.ADDRESS_GUID.CITY as![City],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        Items.GROSS_AMOUNT as![GrossAmount],
        Items.NET_AMOUNT as![NetAmount],
        Items.TAX_AMOUNT as![TaxAmount],
        Items.CURRENCY_CODE as![CurrencyCode],

    }
}

