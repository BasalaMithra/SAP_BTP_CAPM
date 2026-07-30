sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"mithra/app/purchaseorder/test/integration/pages/POsList.gen",
	"mithra/app/purchaseorder/test/integration/pages/POsObjectPage.gen",
	"mithra/app/purchaseorder/test/integration/pages/PurchaseOrderItemsObjectPage.gen"
], function (JourneyRunner, POsListGenerated, POsObjectPageGenerated, PurchaseOrderItemsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('mithra/app/purchaseorder') + '/test/flp.html#app-preview',
        pages: {
			onThePOsListGenerated: POsListGenerated,
			onThePOsObjectPageGenerated: POsObjectPageGenerated,
			onThePurchaseOrderItemsObjectPageGenerated: PurchaseOrderItemsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

