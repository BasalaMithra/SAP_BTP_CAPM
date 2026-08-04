using{mithra.db} from '../db/datamodel';
service mysrvdemo {

    function somesrv(msg: String) returns String;

    @readonly
    entity ReadEmployeeSrv as projection on db.Employee;
    @insertonly
    entity InsertEmployeeSrv as projection on db.Employee;
    @updateonly
    entity UpdateEmployeeSrv as projection on db.Employee;
    @deleteonly
    entity DeleteEmployeeSrv as projection on db.Employee;

}