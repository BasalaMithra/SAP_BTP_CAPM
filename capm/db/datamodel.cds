namespace mithra.db;
using { cuid, managed} from '@sap/cds/common';
using {mithra.common} from './common';


type Guid :String(33);

entity businesspartner {
    key NODE_KEY  : Guid;
    BP_ROLE       : String(2);
    EMAIL_ADDRESS : String(105);
    PHONE_NUMBER  : String(32);
    FAX_NUMBER    : String(32);
    WEB_ADDRESS   : String(44);
    ADDRESS_GUID  : Association to Address;
    BP_ID         : String(32);
    COMPANY_NAME  : String(25);
}
entity Address {
    key NODE_KEY       : Guid;
    CITY               : String(44);
    POSTAL_CODE        : String(8);
    STREET             : String(44);
    BUILDING           : String(128);
    COUNTRY            : String(9);
    ADDRESS_TYPE       : String(44);
    VAL_START_DATE     : Date;
    VAL_END_DATE       : Date;
    LATITUDE           : Decimal;
    LONGITUDE          : Decimal;
    businesspartner    : Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
}
annotate businesspartner with {
    NODE_KEY @title  : '{i18n>bp key}';
    BP_ROLE  @title  : '{i18n>bp role}';
}
// entity prodtext {
//     key NODE_KEY : Guid;
//     PARENT_KEY   : Guid;
//     LANGUAGE     : String(2);
//     TEXT         : String(256);
// }
entity product {
    key NODE_KEY   : Guid;
    PRODUCT_ID     : String(8);
    TYPE_CODE      : String(2);
    CATEGORY       : String(32);
    DESCRIPTION    : localized String(255);
    NAME           : localized String(65);
    SUPPLIER_GUID  : Association to db.businesspartner;
    TAX_TARIF_CODE : Integer;
    MEASURE_UNIT   : String(2);
    WEIGHT_MEASURE : Decimal;
    WEIGHT_UNIT    : String(2);
    CURRENCY_CODE  : String(4);
    PRICE          : Decimal;
    WIDTH          : Decimal;
    DEPTH          : Decimal;
    HEIGHT         : Decimal;
    DIM_UNIT       : String(2);
}
entity purchaseorder:common.Amount {
    key NODE_KEY     :Guid;
    PO_ID            : String(9);
    PARTNER_GUID     : association to db.businesspartner;
    LIFECYCLE_STATUS : String(1);
    OVERALL_STATUS   : String(1);
    Items: association to many poitems on Items.PARENT_KEY = $self;
    NOTE:String(256);
}
entity poitems: common.Amount {
    key NODE_KEY   : Guid;
    PARENT_KEY     : association to purchaseorder;
    PO_ITEM_POS    : Integer;
    PRODUCT_GUID   : association to db.product;
    CURRENCY_CODE  : String(4);
    GROSS_AMOUNT   : Decimal;
    NET_AMOUNT     : Decimal;
    TAX_AMOUNT     : Decimal;
}
entity Employee : cuid, managed{
    nameFirst         : String(40);
    nameMiddle        : String(40);
    nameLast          : String(40);
    nameInitials      : String(40);
    sex               : common.Gender;
    language          : String(1);
    phoneNumber       : Integer;
    email             : String(20);
    loginName         : String(12);
    currency_code     : String(6);
    salaryAmount      : Integer;
    accountNumber     : String(16);
    bankId            : String(8);
    bankName          : String(40);
}

