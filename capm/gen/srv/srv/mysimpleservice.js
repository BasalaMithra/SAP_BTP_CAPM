const cds = require("@sap/cds");
const { SELECT, DELETE } = require("@sap/cds/lib/ql/cds-ql");
const  { Employee } = cds.entities("mithra.db");
const mysrvdemo = function(srv){
    srv.on('somesrv', (req,res) => {
        return "hello " + req.data.msg;
    });

    srv.on("READ", "ReadEmployeeSrv", async(req, res) => {

        var results = [];

    //     results.push({
    //         "NODE_KEY":"11111111-1111-1111-1111-111111111111",
    //         "nameFirst": "mithra",
    //         "nameLast":"basala"
    // });

//CDS Query Language , SELECT * FROM dbtables
    results = await cds.tx(req).run(SELECT.from(Employee).limit(3));

//CDS Query to read single record with where
    //results = await cds.tx(req).run(SELECT.from(Employee).where({"nameFirst":"Anita"}));

//CDS Query if user pass key like/Entity/key
    var whereCondition = req.data;
    console.log(whereCondition);
    if(whereCondition.hasOwnProperty("NODE_KEY")){
        results = await cds.tx(req).run(SELECT.from(Employee).where(whereCondition));;
    }else{
        results = await cds.tx(req).run(SELECT.from(Employee).limit(1));
    }
    return results;
    });

    function randomString(length, chars) {
        var result = '';
        for (var i = length; i > 0; --i) result += chars[Math.floor(Math.random() * chars.length)];
        return result;
    }

    srv.on("CREATE", "InsertEmployeeSrv", async(req,res) =>{
        console.log(req.data);
        var dataSet = [];
        for (let i = 0; i <req.data.length; i++){
            const element = req.data[i];
            var rString= randomString(32, '086hrbjjt47ih64fthmg369gc67khfd0');
            element.NODE_KEY = rString.toUpperCase();
            dataSet.push(element);
        }
        console.log(dataSet);
        let returnData = await cds.transaction(req).run([
            INSERT.into(Employee).entries([dataSet])
        ]).then( (resolve, reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in insert");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
        });
        return returnData;
    });
    

    srv.on("UPDATE", "UpdateEmployeeSrv", async(req, res) => {
        let returnData = await cds.transaction(req).run([
            UPDATE(Employee).set({
                nameFirst: req.data.nameFirst
            }).where({NODE_KEY: req.data.NODE_KEY}),

            UPDATE(Employee).set({
                nameLast: req.data.nameLast
            }).where({NODE_KEY: req.data.NODE_KEY})
        ]).then( (resolve,reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in insert");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
    });
    return returnData;
});


    srv.on("DELETE", "UpdateEmployeeSrv", async(req, res) => {
        let returnData = await cds.transaction(req).run([
            DELETE.from(Employee).where(req.data)
        ]).then( (resolve,reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in insert");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
    });
    return returnData;
});
} 
module.exports = mysrvdemo;