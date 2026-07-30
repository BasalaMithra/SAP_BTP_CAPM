using {mithra.db.CDSViews} from '../db/CDSViews';

service CDSService @(path:'/CDSService') {
    entity POWorklist as projection on CDSViews.POWorklist;


}