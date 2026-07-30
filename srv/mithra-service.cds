using {mithra.db} from '../db/datamodel';
service mithraservice{
    entity businesspartner as projection on db.businesspartner;
    entity prodtext as projection on db.prodtext;
    entity product as projection on db.product;
    entity purchaseorder as projection on db.purchaseorder;
    entity poitems as projection on db.poitems;
    entity Address as projection on db.Address;
}