({
    checkBillingAccount: function(component, event, helper) {
        component.set("v.HideSpinner", true);
        var action = component.get("c.getBillingAccount");
        action.setParams({
            accountId: component.get("v.accountId")
        }); 

        action.setCallback(this, function(response) {
            var statecheckBillingAccount = response.getState();
            var billingAccount = response.getReturnValue();
            component.set("v.thisAccount", billingAccount);
            var accountNumber = billingAccount.TRACT3__Tract_Billing_Account__c;
            if (accountNumber != undefined) {
                component.set("v.canEdit", true);
                component.set("v.enableAddCreditDebit", true);
                helper.getBillingAccount(component, event, helper);
            } else {
                component.set("v.HideSpinner", false);
                component.set("v.checkallService", false);
                component.set("v.showall", false);
                component.set("v.checkallPayment", false);
                component.set("v.checkalldebit", false);
                component.set("v.checkallcredit", false);
                component.set("v.checkallInvoice", false);
                component.set("v.checkall", false);
                component.set("v.checkAllPaymentMethod", false);
                component.set("v.checkAllNote", false);
                component.set("v.checkAllContact", false);
                component.set("v.enableAddCreditDebit", false);
                helper.getConfigDetails(component, event, helper);
            }
        });
        $A.enqueueAction(action);
    },

    getBillingAccount: function(component, event, helper) {
        var action = component.get("c.getBillingAccountdetail");
        action.setParams({
            accountId: component.get("v.accountId")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var billingAccountWrapper = response.getReturnValue();
                component.set("v.tractBillingAccount", billingAccountWrapper);
                
                helper.salesOrderMethod(component, event, helper);
                helper.getPaymentMethod(component, event, helper);
                helper.getDebitAdjustmentMethod(component, event, helper);
                helper.getCreditAdjustmentMethod(component, event, helper);
                helper.getInvoiceMethod(component, event, helper);
                helper.getactivityevents(component, event, helper);
                helper.getPaymentMethodRecord(component, event, helper);
                helper.servicesMethod(component, event, helper);
                helper.getNotes(component, event, helper);
                helper.getContacts(component, event, helper);
                helper.getAccountCustomField(component, event, helper);
                helper.getOneTimeOrderItems(component, event, helper);
               /* var billingAccWrapArr;
                if(billingAccountWrapper.APIVersion == 'API Version 1.0'){
                    billingAccWrapArr =[helper.getAccountCustomField,helper.getPaymentMethod,helper.getInvoiceMethod,helper.salesOrderMethod,helper.servicesMethod,helper.getOneTimeOrderItems,helper.getDebitAdjustmentMethod,helper.getCreditAdjustmentMethod,helper.getPaymentMethodRecord,helper.getContacts,helper.getNotes,helper.getactivityevents];//helper.getNotes
                }
                else{
                    billingAccWrapArr =[helper.servicesMethod,helper.getInvoiceMethod,helper.getOneTimeOrderItems,helper.getactivityevents];//helper.getNotes
                    //billingAccWrapArr =[helper.getAccountCustomField,helper.getPaymentMethod,helper.getInvoiceMethod,helper.salesOrderMethod,helper.servicesMethod,helper.getOneTimeOrderItems,helper.getDebitAdjustmentMethod,helper.getCreditAdjustmentMethod,helper.getPaymentMethodRecord,helper.getContacts,helper.getactivityevents];//helper.getNotes
                }*/
                /*var num = component.get("v.outerHeight");
                console.log('num::::'+num);
                billingAccWrapArr[num](component, event, helper);*/
            }
        });
        $A.enqueueAction(action);
    },

    getConfigDetails: function(component, event, helper) {
        var action = component.get("c.getConfigDetails");
        action.setParams({
            accountId: component.get("v.accountId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var billingAccountWrapper = response.getReturnValue();
                component.set("v.tractBillingAccount", billingAccountWrapper);    
            }
        });
        $A.enqueueAction(action);
    },

    changeAccountStatus: function(component, event, statusAction) {
        // create a modal to show the status change reason pick-list
        $A.createComponent(
            "c:ChangeBillingAccountStatus", {
                "statusString": statusAction,
                "billingAccount": component.get("v.tractBillingAccount")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    servicesMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberService");
        var action = component.get("c.setUpServices");
        action.setParams({
            accountWrapper: JSON.stringify(tractAccount),
            pagenumber: number
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var wrapperList = response.getReturnValue();
                component.set("v.wrappers", wrapperList.productServiceWrap);
                component.set("v.maxPageNumberService", wrapperList.totalPage);
                var max = component.get("v.maxPageNumberService");
                if ((max == 1) || wrapperList.totalPage == undefined || max == 0) {
                    component.set("v.checkallService", false);
                } else if (number == max) {
                    component.set("v.checkallService", true);
                    component.set("v.checkpage2Service", true);
                    component.set("v.checkpageService", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkallService", true);
                    component.set("v.checkpageService", true);
                    component.set("v.checkpage2Service", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkallService", true);
                    component.set("v.checkpage2Service", false);
                    component.set("v.checkpageService", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getUserPermission: function(component, event, helper) {
        var action = component.get("c.getpermissions");
        action.setCallback(this, function(response) {
            component.set("v.myMap", response.getReturnValue());
            var newval = component.get("v.myMap");
            for (var key in newval) {
                console.log('key:::::::'+key);
                if (key == 'Show Account Configurations Section' && newval[key] == true)
                    component.set("v.listval", true);
                if (key == 'Show Billing Address Section' && newval[key] == true)
                    component.set("v.listval2", true);
                if (key == 'Show Shipping Address Section' && newval[key] == true)
                    component.set("v.listval3", true);
                if (key == 'Show Payments Section' && newval[key] == true){
                    component.set("v.listval4", true);
                }  
                if (key == 'Show Invoices Section' && newval[key] == true){
                    component.set("v.listval5", true);
                }
                if (key == 'Show Sales Orders Section' && newval[key] == true){
                    component.set("v.listval6", true);
                }
                if (key == 'Show Services Section' && newval[key] == true){
                    component.set("v.listval7", true);
                }
                if (key == 'Show Debit Adjustments Section' && newval[key] == true){
                    component.set("v.listval8", true);
                }
                if (key == 'Show Credit Adjustments Section' && newval[key] == true){
                    component.set("v.listval9", true);
                }
                if (key == 'Show Activity Events Section' && newval[key] == true){
                    component.set("v.listval10", true);
                }
                if (key == 'Allow Credit Adjustments Add' && newval[key] == true)
                    component.set("v.listval11", true);
                if (key == 'Allow Debit Adjustments Add' && newval[key] == true)
                    component.set("v.listval12", true);
                if (key == 'Allow Invoice Download' && newval[key] == true)
                    component.set("v.listval13", true);
                if (key == 'Allow Services Add Address' && newval[key] == true)
                    component.set("v.listval14", true);
                /*if (key == 'Allow Services Change Service' && newval[key] == true)
                for (var key1 in newval){
                    if(key1 == 'API Version 1.0'){
                        component.set("v.listval15", true);
                    }
                    else{
                        component.set("v.listval15", true);
                    }
                }*/
                    
                if (key == 'Allow Services Deactivate' && newval[key] == true)
                    component.set("v.listval16", true);
                if (key == 'Allow Services Suspend' && newval[key] == true)
                    component.set("v.listval17", true);
                if (key == 'Allow Services Update Quantity' && newval[key] == true)
                    component.set("v.listval18", true);
                if (key == 'Show Payment Methods Section' && newval[key] == true){
                    component.set("v.listval19", true);
                }
                if (key == 'Show Contacts Section' && newval[key] == true){
                    component.set("v.listval20", true);
                }
                if (key == 'Show Notes Section' && newval[key] == true)
                    for (var key1 in newval){
                        if(key1 == 'API Version 1.0'){
                            component.set("v.listval21", true);
                        }
                        else{
                            component.set("v.listval21", false);
                        }
                    }
                if (key == 'Show Account Custom Fields' && newval[key] == true){
                    component.set("v.listval22", true);
                }
                if (key == 'Show One Time Purchase Section' && newval[key] == true){
                    component.set("v.showOneTimePurchase", true);
                }
                if(key == 'API Version 1.0'){
                    component.set("v.hideButton", false);
                }
            }
            this.checkBillingAccount(component, event, helper);
        });
        $A.enqueueAction(action);
    },

    getactivityevents: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumber");
        var action = component.get("c.setUpUsagesEvents");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumber")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var setEventList = response.getReturnValue();
                component.set("v.getEventList", setEventList.getevents);
                component.set("v.maxPageNumber", setEventList.size);
                var max = component.get("v.maxPageNumber");
                if ((max == 1) || setEventList.size == undefined || max == 0) {
                    component.set("v.checkall", false);
                } else if (number == max) {
                    component.set("v.checkall", true);
                    component.set("v.checkpage2", true);
                    component.set("v.checkpage", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkall", true);
                    component.set("v.checkpage", true);
                    component.set("v.checkpage2", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkall", true);
                    component.set("v.checkpage2", false);
                    component.set("v.checkpage", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    salesOrderMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberOrder");
        var action = component.get("c.getSalesOrder");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumberOrder")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var orderList = response.getReturnValue();
                component.set("v.salesOrdersWrap", orderList);
                component.set("v.maxPageNumberOrder", orderList.totalPage);
                var max = component.get("v.maxPageNumberOrder");
                if ((max == 1) || orderList.totalPage == undefined || max == 0) {
                    component.set("v.showall", false);
                } else if (number == max) {
                    component.set("v.showall", true);
                    component.set("v.showpage2", true);
                    component.set("v.showpage", false);
                } else if (number > 1 && number < max) {
                    component.set("v.showall", true);
                    component.set("v.showpage", true);
                    component.set("v.showpage2", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.showall", true);
                    component.set("v.showpage2", false);
                    component.set("v.showpage", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getPaymentMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberPayment");
        var action = component.get("c.setUpPayments");
        action.setParams({
            accountWrapper: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumberPayment")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var paymentwrap = response.getReturnValue();
                component.set("v.getPayments", paymentwrap.paymentListWrapper);
                component.set("v.maxPageNumberPayment", paymentwrap.totalPage);
                var max = component.get("v.maxPageNumberPayment");
                console.log('max For payment'+max);
                if ((max == 1) || paymentwrap.totalPage == undefined || max == 0) {
                    component.set("v.checkallPayment", false);
                } else if (number == max) {
                    component.set("v.checkallPayment", true);
                    component.set("v.checkpage2Payment", true);
                    component.set("v.checkpagePayment", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkallPayment", true);
                    component.set("v.checkpagePayment", true);
                    component.set("v.checkpage2Payment", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkallPayment", true);
                    component.set("v.checkpage2Payment", false);
                    component.set("v.checkpagePayment", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getDebitAdjustmentMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberdebit");
        var action = component.get("c.setUpDebitAdjustment");
        action.setParams({
            accountWrapper: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumberdebit")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var adjustmentwrap = response.getReturnValue();
                component.set("v.getDebitList", adjustmentwrap.adjustmentListWrapper);
                component.set("v.maxPageNumberdebit", adjustmentwrap.totalPage);
                var max = component.get("v.maxPageNumberdebit");
                if ((max == 1) || adjustmentwrap.totalPage == undefined || max == 0) {
                    component.set("v.checkalldebit", false);
                } else if (number == max) {
                    component.set("v.checkalldebit", true);
                    component.set("v.checkpage2debit", true);
                    component.set("v.checkpagedebit", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkalldebit", true);
                    component.set("v.checkpagedebit", true);
                    component.set("v.checkpage2debit", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkalldebit", true);
                    component.set("v.checkpage2debit", false);
                    component.set("v.checkpagedebit", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getCreditAdjustmentMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumbercredit");
        var action = component.get("c.setUpCreditAdjustment");
        action.setParams({
            accountWrapper: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumbercredit")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var adjustmentwrap = response.getReturnValue();
                component.set("v.getCreditList", adjustmentwrap.adjustmentListWrapper);
                component.set("v.maxPageNumbercredit", adjustmentwrap.totalPage);
                var max = component.get("v.maxPageNumbercredit");
                if ((max == 1) || adjustmentwrap.totalPage == undefined || max == 0) {
                    component.set("v.checkallcredit", false);
                } else if (number == max) {
                    component.set("v.checkallcredit", true);
                    component.set("v.checkpage2credit", true);
                    component.set("v.checkpagecredit", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkallcredit", true);
                    component.set("v.checkpagecredit", true);
                    component.set("v.checkpage2credit", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkallcredit", true);
                    component.set("v.checkpage2credit", false);
                    component.set("v.checkpagecredit", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getInvoiceMethod: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberInvoice");
        var action = component.get("c.setUpInvoices");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pagenumber: component.get("v.currentPageNumberInvoice")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var invoiceWrap = response.getReturnValue();
                component.set("v.getInvoiceList", invoiceWrap.invoiceListWrapper);
                component.set("v.currentPageNumberInvoice", invoiceWrap.totalPage);
                var max = component.get("v.currentPageNumberInvoice");
                if ((max == 1) || invoiceWrap.totalPage == undefined || max == 0) {
                    component.set("v.checkallInvoice", false);
                } else if (number == max) {
                    component.set("v.checkallInvoice", true);
                    component.set("v.checkpage2Invoice", true);
                    component.set("v.checkpageInvoice", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkallInvoice", true);
                    component.set("v.checkpageInvoice", true);
                    component.set("v.checkpage2Invoice", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkallInvoice", true);
                    component.set("v.checkpage2Invoice", false);
                    component.set("v.checkpageInvoice", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },
    getInvoicePdf: function(component, pdfUrl) {

        var action = component.get("c.pdfDownload");
        action.setParams({
            accountId: component.get("v.accountId"),
            downloadURL: pdfUrl
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            var invoicePdfUrl = response.getReturnValue();
            if (state === "SUCCESS") {
                window.open(invoicePdfUrl);
            }
        });
        $A.enqueueAction(action);
    },

    getPaymentMethodRecord: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var action = component.get("c.paymentRecords");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pageNumber: component.get("v.currentPageNumberPaymentMethod")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {   
                var payementMethodWrap = response.getReturnValue();
                console.log('payementMethodWrap.paymentMethodList::::'+ JSON.stringify(payementMethodWrap.paymentMethodList));
                component.set("v.RecordsOfPaymentMethod", payementMethodWrap.paymentMethodList);
                component.set("v.maxPageNumberPaymentMethod", payementMethodWrap.totalPage);
                var max = component.get("v.maxPageNumberPaymentMethod");
                if ((max == 1) || payementMethodWrap.totalPage == undefined || max == 0) {
                    component.set("v.checkAllPaymentMethod", false);
                } else if (number == max) {
                    component.set("v.checkAllPaymentMethod", true);
                    component.set("v.checkPage2PaymentMethod", true);
                    component.set("v.checkpagePaymentMethod", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkAllPaymentMethod", true);
                    component.set("v.checkPagePaymentMethod", true);    
                    component.set("v.checkPage2PaymentMethod", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkAllPaymentMethod", true);    
                    component.set("v.checkPage2PaymentMethod", false);
                    component.set("v.checkPagePaymentMethod", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });

        $A.enqueueAction(action);
    },

    getNotes: function(component, event, helper) {
        var number = component.get("v.currentPageNumberNote");
        var tractAccount = component.get("v.tractBillingAccount");
        var action = component.get("c.Notes");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pageNumber: component.get("v.currentPageNumberNote")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var notesWrap = response.getReturnValue();
                component.set("v.ListOfNotes", notesWrap.noteWrapperList);
                component.set("v.maxPageNumberNote", notesWrap.totalPage);
                var max = component.get("v.maxPageNumberNote");
                if ((max == 1) || notesWrap.totalPage == undefined || max == 0) {
                    component.set("v.checkAllNote", false);
                } else if (number == max) {
                    component.set("v.checkAllNote", true);
                    component.set("v.checkPage2Note", true);
                    component.set("v.checkpagecredit", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkAllNote", true);
                    component.set("v.checkPageNote", true);
                    component.set("v.checkPage2Note", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkAllNote", true);
                    component.set("v.checkPage2Note", false);
                    component.set("v.checkPageNote", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getContacts: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var number = component.get("v.currentPageNumberContact");
        var action = component.get("c.contacts");
        action.setParams({
            accountString: JSON.stringify(tractAccount),
            pageNumber: component.get("v.currentPageNumberContact")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var contactWrap = response.getReturnValue();
                component.set("v.ListOfContacts", contactWrap.contactWrapperList);
                component.set("v.maxPageNumberContact", contactWrap.totalPage);
                var max = component.get("v.maxPageNumberContact");
                if ((max == 1) || contactWrap.totalPage == undefined || max == 0) {
                    component.set("v.checkAllContact", false);
                } else if (number == max) {
                    component.set("v.checkAllContact", true);
                    component.set("v.checkPage2Contact", true);
                    component.set("v.checkPageContact", false);
                } else if (number > 1 && number < max) {
                    component.set("v.checkAllContact", true);
                    component.set("v.checkPageContact", true);
                    component.set("v.checkPage2Contact", true);
                } else if (number == 1 && max > 1) {
                    component.set("v.checkAllContact", true);
                    component.set("v.checkPage2Contact", false);
                    component.set("v.checkPageContact", true);
                }
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getAccountCustomField: function(component, event, helper) {
        var action = component.get("c.getAccountCustomFieldValueList");
        action.setParams({
            accountId: component.get("v.accountId"),
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var customFieldList = response.getReturnValue();
                component.set("v.accountCustomFieldList", customFieldList);
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    },

    getOneTimeOrderItems: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var action = component.get("c.getOneTimeOrderItemList");
        action.setParams({
            accountString: JSON.stringify(tractAccount)
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var oneTimeOrderItemList = response.getReturnValue();
                component.set("v.OneTimeOrderItemList", oneTimeOrderItemList);
            }
            component.set("v.HideSpinner", false);
            var myExternalEvent;
            myExternalEvent = $A.get("e.c:handleScroll");
            myExternalEvent.setParams({
            "testVar": true,
            });
            myExternalEvent.fire();
        });
        $A.enqueueAction(action);
    }
})