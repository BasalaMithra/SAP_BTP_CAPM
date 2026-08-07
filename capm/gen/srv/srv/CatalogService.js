module.exports = cds.service.impl( async function(){
    const {
        EmployeeSet, POs
    } = this.entities;

    this.before('UPDATE', EmployeeSet, (req,res) => {
        console.log("high value", req.data.salaryAmount);
        if(parseFloat(req.data.salaryAmount) >= 100000){
            req.error(500, "salary must be below 1 million");
            //res.send("Dude, not allowed salary");
        }
    });

    this.on('boost', async req => {
        try {
            const NODE_KEY = req.params[0];
            console.log("your Purchase Order with ID-->" + NODE_KEY + "will be boosted");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 2000 }, NOTE:"Boosted!!"
            }).where(NODE_KEY);
            return {};
        } catch (error){
             return "Error " + error.toString();

        }
    });

    this.on('largestOrder', async req => {
        try {
            const NODE_KEY = req.params[0];
            console.log("your Purchase Order with ID-->" + NODE_KEY + "will be boosted");
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);
            return reply;
        } catch (error){
             return "Error " + error.toString();

        }
    });

});