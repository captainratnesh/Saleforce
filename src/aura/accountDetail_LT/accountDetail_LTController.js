({
    firstPage: function(component, event, helper) {
        component.set("v.currentPageNumber", 1);
        component.set("v.HideSpinner", true); 
        helper.getUserPermission(component, event, helper);
    },
    prevPage: function(component, event, helper) {
        component.set("v.currentPageNumber", Math.max(component.get("v.currentPageNumber") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getactivityevents(component, event, helper);
    },
    nextPage: function(component, event, helper) {
        component.set("v.currentPageNumber", Math.min(component.get("v.currentPageNumber") + 1, component.get("v.maxPageNumber")));
        component.set("v.HideSpinner", true);
        helper.getactivityevents(component, event, helper);
    },
    lastPage: function(component, event, helper) {
        component.set("v.currentPageNumber", component.get("v.maxPageNumber"));
        component.set("v.HideSpinner", true);
        helper.getactivityevents(component, event, helper);
    },

    expend: function(component, event, helper) {

        if (event.getSource().get("v.iconName") == 'utility:dash') {
            event.getSource().set("v.iconName", 'utility:add');
        } else if (event.getSource().get("v.iconName") == 'utility:add') {
            event.getSource().set("v.iconName", 'utility:dash');
        }
        $('.collapse').on('shown.bs.collapse', function() {});
    },

    doInit: function(component, event, helper) {
      // console.log('ssjnksjn::'+ component.get("v.outerHeight"));
    },

    jsLoaded: function(component, event, helper) {
        $('.account-table').wrap('<div class="account-wrap-table"></div>');
        /*$('html, body').animate({
            'scrollTop': $("#account-detail-scroll").position().top
        });
        $('.main-account-details .account-details').removeAttr('style');
        
        var myExternalEvent;
        myExternalEvent = $A.get("e.c:handleFnishReload");
        myExternalEvent.setParams({
        "Indicator": true
        });
        myExternalEvent.fire();*/
        component.set("v.HideSpinner", true);
        component.set("v.isModalOpen", false);
        component.set("v.isPaymentOpen", false);
        //var billingAccWrapArr= component.get("v.billingAccWrapArr");
        helper.checkBillingAccount(component, event, helper);
    },

    showModal: function(component, event, helper) {
        document.getElementById("backGroundSectionId").style.display = "block";
        document.getElementById("newAccountSectionId").style.display = "block";
        var appEvent = $A.get("e.c:CreateTractAccountEvent");
        appEvent.setParams({
            "AccountID": component.get("v.accountId")
        });
        appEvent.fire();
    },
    pdfDwnload: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var pdfUrl = selectedItem.dataset.pdfurl;
        helper.getInvoicePdf(component, pdfUrl);

    },
    showInvoice:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:InvoiceComponent", {
                "getInvoiceList": component.get("v.getInvoiceList[" + count + "]"),
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },
    showChildService:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:ServiceDetailComponent", {
                "getService": childWrapObj,
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },

    showService:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var url = selectedItem.dataset.url;
        $A.createComponent(
            "c:ServiceDetailComponent", {
                "getService": component.get("v.wrappers[" + count + "]"),
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },
    handleAccountConfiguration: function(component, event, helper) {
        var selectedAction = event.getParam("value");
        helper.changeAccountStatus(component, event, selectedAction);
    },

    RenewServices: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var appEvent = $A.get("e.c:ServicesActionEvent");
        appEvent.setParams({
            "ServiceWrapper": component.get("v.wrappers[" + count + "]")
        });
        appEvent.fire();
        document.getElementById("renewServicesModal").style.display = "block";
        document.getElementById("backGroundSectionRenew").style.display = "block";
    },

    AddServiceResource: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countaddserviceresource;
        var parentWrapObj = component.get("v.wrappers[" + count + "]");
        $A.createComponent(
            "c:AddServiceResourceToSevice", {
                "serviceEid": parentWrapObj.serviceEid
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
    AddServiceResourceToChild: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countaddserviceresource;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:AddServiceResourceToSevice", {
                "serviceEid": childWrapObj.serviceEid
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
    AddServiceResourceToGrandChild: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countaddserviceresource;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:AddServiceResourceToSevice", {
                "serviceEid": grandChildWrapperObj.serviceEid
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
    ChangeSubscription: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var selectedItem = event.currentTarget;
        var countchangesubscriptionValue = selectedItem.dataset.countchangesubscription;
        var wrapObj = component.get("v.wrappers[" + countchangesubscriptionValue + "]");
        $A.createComponent(
            "c:ChangeSubscription", {
                "wrappers": wrapObj,
                "accountCurrency": tractAccount.accountCurrency
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
    ChangeSubscriptionChild: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countchangesubscription;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:ChangeSubscription", {
                "wrappers": childWrapObj,
                "accountCurrency": tractAccount.accountCurrency
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
    ChangeGrandChildSubscription: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countchangesubscription;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:ChangeSubscription", {
                "wrappers": grandChildWrapperObj
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
    ChangeChildServiceResource: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countchangeserviceresource;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:ChangeServiceResource", {
                "productWrapper": childWrapObj,
                "serviceEid": parentWrapObj.serviceEid
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

    ChangeGrandChildServiceResource: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countchangeserviceresource;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:ChangeServiceResource", {
                "productWrapper": grandChildWrapperObj,
                "serviceEid": childWrapObj.serviceEid
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
    AddAddress: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var countaddaddressValue = selectedItem.dataset.countaddaddress;
        var wrappers = component.get("v.wrappers[" + countaddaddressValue + "]");
        $A.createComponent(
            "c:AddAddressCmp", {
                "wrappers": wrappers
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    AddChildAddress: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countaddaddress;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:AddAddressCmp", {
                "wrappers": childWrapObj
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    AddGrandChildAddress: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countaddaddress;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:AddAddressCmp", {
                "wrappers": grandChildWrapperObj
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    ConfigActivityCharge: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var appEvent = $A.get("e.c:ActivityChargeEvent");
        appEvent.setParams({
            "ServiceWrapper": component.get("v.wrappers[" + count + "]")
        });
        appEvent.fire();
        document.getElementById("activityChargeModal").style.display = "block";
        document.getElementById("backGroundActivityCharge").style.display = "block";
        document.documentElement.classList.add('body-hidden');
    },
    ConfigChildActivityCharge: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var appEvent = $A.get("e.c:ActivityChargeEvent");
        appEvent.setParams({
            "ServiceWrapper": childWrapObj
        });
        appEvent.fire();
        document.getElementById("activityChargeModal").style.display = "block";
        document.getElementById("backGroundActivityCharge").style.display = "block";
    },
    ConfigGrandChildActivityCharge: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        var appEvent = $A.get("e.c:ActivityChargeEvent");
        appEvent.setParams({
            "ServiceWrapper": grandChildWrapperObj
        });
        appEvent.fire();
        document.getElementById("activityChargeModal").style.display = "block";
        document.getElementById("backGroundActivityCharge").style.display = "block";
    },
    DeactivateService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var countDeactivateService = selectedItem.dataset.countdeactivateservice;
        $A.createComponent(
            "c:TractBillingAccount", {
                "wrappers": component.get("v.wrappers[" + countDeactivateService + "]")
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
    DeactivateChildService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countdeactivateservice;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:TractBillingAccount", {
                "wrappers": childWrapObj
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
    DeactivateGrandChildService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countdeactivateservice;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:TractBillingAccount", {
                "wrappers": grandChildWrapperObj
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
    SuspendServices: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var countServicesValue = selectedItem.dataset.countservice;
        var wrappers = component.get("v.wrappers[" + countServicesValue + "]");
        $A.createComponent(
            "c:SuspendServiceComponent", {
                "wrappers": wrappers
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    SuspendChildServices: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countservice;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        $A.createComponent(
            "c:SuspendServiceComponent", {
                "wrappers": childWrapObj
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    SuspendGrandChildServices: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countservice;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:SuspendServiceComponent", {
                "wrappers": grandChildWrapperObj
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    ResumeService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.resumesericecount;
        var appEvent = $A.get("e.c:ResumeServiceEvent");
        var serviceEidValue = component.get("v.wrappers[" + count + "]").serviceEid;
        var serviceNameValue = component.get("v.wrappers[" + count + "]").serviceName;
        appEvent.setParams({
            "ServiceEid": serviceEidValue
        });
        appEvent.setParams({
            "ServiceName": serviceNameValue
        });
        appEvent.fire();
        document.getElementById("ResumeServiceModal").style.display = "block";
        document.getElementById("backGroundSectionResume").style.display = "block";
    },
     ConvertTrialService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.convertsericecount;
        var appEvent = $A.get("e.c:ConvertServiceEvent");
        var serviceEidValue = component.get("v.wrappers[" + count + "]").serviceEid;
        var serviceNameValue = component.get("v.wrappers[" + count + "]").serviceName;
        appEvent.setParams({
            "ServiceEid": serviceEidValue
        });
        appEvent.setParams({
            "ServiceName": serviceNameValue
        });
        appEvent.fire();
        document.getElementById("ConvertServiceModal").style.display = "block";
        document.getElementById("backGroundSectionConvert").style.display = "block";
    },
    ResumeChildService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.resumesericecount;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];

        var appEvent = $A.get("e.c:ResumeServiceEvent");
        var serviceEidValue = childWrapObj.serviceEid;
        var serviceNameValue = childWrapObj.serviceName;
        appEvent.setParams({
            "ServiceEid": serviceEidValue
        });
        appEvent.setParams({
            "ServiceName": serviceNameValue
        });
        appEvent.fire();
        document.getElementById("ResumeServiceModal").style.display = "block";
        document.getElementById("backGroundSectionResume").style.display = "block";
    },
    ResumeGrandChildService: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.resumesericecount;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        var appEvent = $A.get("e.c:ResumeServiceEvent");
        var serviceEidValue = grandChildWrapperObj.serviceEid;
        var serviceNameValue = grandChildWrapperObj.serviceName;
        appEvent.setParams({
            "ServiceEid": serviceEidValue
        });
        appEvent.setParams({
            "ServiceName": serviceNameValue
        });
        appEvent.fire();
        document.getElementById("ResumeServiceModal").style.display = "block";
        document.getElementById("backGroundSectionResume").style.display = "block";
    },
    showTractAccount: function(component, event, helper) {

        var tractUrl = component.get("v.wrappers[0]").tractUrl;
        window.open(tractUrl);
    },
    UpdateQuantity: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countupdate;
        $A.createComponent(
            "c:UpdateQtyCmponent", {
                "wrappers": component.get("v.wrappers[" + count + "]")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    UpdateQuantityChild: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countupdate;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var parentService = component.get("v.wrappers[" + parent + "]");
        var childService = parentService.childElements[child];
        $A.createComponent(
            "c:UpdateQtyCmponent", {
                "wrappers": childService
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    UpdateGrandChildQuantity: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countupdate;
        var indexes = count.split(':');
        var parent = indexes[0];
        var child = indexes[1];
        var grandChild = indexes[2];
        var parentWrapObj = component.get("v.wrappers[" + parent + "]");
        var childWrapObj = parentWrapObj.childElements[child];
        var grandChildWrapperObj = childWrapObj.childElements[grandChild];
        $A.createComponent(
            "c:UpdateQtyCmponent", {
                "wrappers": grandChildWrapperObj
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    showModal1: function(component, event, helper) {
        document.getElementById("backGroundSectionId1").style.display = "block";
        document.getElementById("newAccountSectionId1").style.display = "block";
    },
    showModal2: function(component, event, helper) {
        document.getElementById("backGroundSectionId2").style.display = "block";
        document.getElementById("newAccountSectionId2").style.display = "block";
    },
    showDebitAdjustment: function(component, event, helper) {
        var accountId = component.get("v.accountId")
        $A.createComponent(
            "c:DebitAdjustmentComponent", {
                "accountId": accountId
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
    showCreditAdjustment: function(component, event, helper) {
        var accountId = component.get("v.accountId")
        $A.createComponent(
            "c:CreditAdjustmentComponent", {
                "accountId": accountId
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
    waiting: function(component, event, helper) {
        document.getElementById("showspinner").style.display = "block";
    },
    doneWaiting: function(component, event, helper) {
        document.getElementById("showspinner").style.display = "none";
    },
    /* Added to show pagination on sales order section */
    firstOrderPage: function(component, event, helper) {
        component.set("v.currentPageNumberOrder", 1);
        component.set("v.HideSpinner", true);
        helper.salesOrderMethod(component, event, helper);
    },
    prevOrderPage: function(component, event, helper) {
        component.set("v.currentPageNumberOrder", Math.max(component.get("v.currentPageNumberOrder") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.salesOrderMethod(component, event, helper);
    },
    nextOrderPage: function(component, event, helper) {
        component.set("v.currentPageNumberOrder", Math.min(component.get("v.currentPageNumberOrder") + 1, component.get("v.maxPageNumberOrder")));
        component.set("v.HideSpinner", true);
        helper.salesOrderMethod(component, event, helper);
    },
    lastOrderPage: function(component, event, helper) {
        component.set("v.currentPageNumberOrder", component.get("v.maxPageNumberOrder"));
        component.set("v.HideSpinner", true);
        helper.salesOrderMethod(component, event, helper);
    },
    /* Added to show pagination on sales order section */
    firstServicePage: function(component, event, helper) {
        component.set("v.currentPageNumberService", 1);
        component.set("v.HideSpinner", true);
        helper.servicesMethod(component, event, helper);
    },
    prevServicePage: function(component, event, helper) {
        component.set("v.currentPageNumberService", Math.max(component.get("v.currentPageNumberService") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.servicesMethod(component, event, helper);
    },
    nextServicePage: function(component, event, helper) {
        component.set("v.currentPageNumberService", Math.min(component.get("v.currentPageNumberService") + 1, component.get("v.maxPageNumberService")));
        component.set("v.HideSpinner", true);
        helper.servicesMethod(component, event, helper);
    },
    lastServicePage: function(component, event, helper) {
        component.set("v.currentPageNumberService", component.get("v.maxPageNumberService"));
        component.set("v.HideSpinner", true);
        helper.servicesMethod(component, event, helper);
    },
    /* Added to show pagination on Invoice section */
    firstInvoicePage: function(component, event, helper) {
        component.set("v.currentPageNumberInvoice", 1);
        component.set("v.HideSpinner", true);
        helper.getInvoiceMethod(component, event, helper);
    },
    prevInvoicePage: function(component, event, helper) {
        component.set("v.currentPageNumberInvoice", Math.max(component.get("v.currentPageNumberInvoice") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getInvoiceMethod(component, event, helper);
    },
    nextInvoicePage: function(component, event, helper) {
        component.set("v.currentPageNumberInvoice", Math.min(component.get("v.currentPageNumberInvoice") + 1, component.get("v.maxPageNumberInvoice")));
        component.set("v.HideSpinner", true);
        helper.getInvoiceMethod(component, event, helper);
    },
    lastInvoicePage: function(component, event, helper) {
        component.set("v.currentPageNumberInvoice", component.get("v.maxPageNumberInvoice"));
        component.set("v.HideSpinner", true);
        helper.getInvoiceMethod(component, event, helper);
    },
    /* Added to show pagination on Payment section */
    firstPaymentPage: function(component, event, helper) {
        component.set("v.currentPageNumberPayment", 1);
        component.set("v.HideSpinner", true);
        helper.getPaymentMethod(component, event, helper);
    },
    prevPaymentPage: function(component, event, helper) {
        component.set("v.currentPageNumberPayment", Math.max(component.get("v.currentPageNumberPayment") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethod(component, event, helper);
    },
    nextPaymentPage: function(component, event, helper) {
        component.set("v.currentPageNumberPayment", Math.min(component.get("v.currentPageNumberPayment") + 1, component.get("v.maxPageNumberPayment")));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethod(component, event, helper);
    },
    lastPaymentPage: function(component, event, helper) {
        component.set("v.currentPageNumberPayment", component.get("v.maxPageNumberPayment"));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethod(component, event, helper);
    },
    /* Added to show pagination on debit adjustment section */
    firstdebitPage: function(component, event, helper) {
        component.set("v.currentPageNumberdebit", 1);
        component.set("v.HideSpinner", true);
        helper.getDebitAdjustmentMethod(component, event, helper);
    },
    prevdebitPage: function(component, event, helper) {
        component.set("v.currentPageNumberdebit", Math.max(component.get("v.currentPageNumberdebit") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getDebitAdjustmentMethod(component, event, helper);
    },
    nextdebitPage: function(component, event, helper) {
        component.set("v.currentPageNumberdebit", Math.min(component.get("v.currentPageNumberdebit") + 1, component.get("v.maxPageNumberdebit")));
        component.set("v.HideSpinner", true);
        helper.getDebitAdjustmentMethod(component, event, helper);
    },
    lastdebitPage: function(component, event, helper) {
        component.set("v.currentPageNumberdebit", component.get("v.maxPageNumberdebit"));
        component.set("v.HideSpinner", true);
        helper.getDebitAdjustmentMethod(component, event, helper);
    },
    /* Added to show pagination on credit adjustment section */
    firstcreditPage: function(component, event, helper) {
        component.set("v.currentPageNumbercredit", 1);
        component.set("v.HideSpinner", true);
        helper.getCreditAdjustmentMethod(component, event, helper);
    },
    prevcreditPage: function(component, event, helper) {
        component.set("v.currentPageNumbercredit", Math.max(component.get("v.currentPageNumbercredit") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getCreditAdjustmentMethod(component, event, helper);
    },
    nextcreditPage: function(component, event, helper) {
        component.set("v.currentPageNumbercredit", Math.min(component.get("v.currentPageNumbercredit") + 1, component.get("v.maxPageNumbercredit")));
        component.set("v.HideSpinner", true);
        helper.getCreditAdjustmentMethod(component, event, helper);
    },
    lastcreditPage: function(component, event, helper) {
        component.set("v.currentPageNumbercredit", component.get("v.maxPageNumbercredit"));
        component.set("v.HideSpinner", true);
        helper.getCreditAdjustmentMethod(component, event, helper);
    },
    /* Added to show pagination on payment method section */
    firstPaymentMethodPage: function(component, event, helper) {
        component.set("v.currentPageNumberPaymentMethod", 1);
        component.set("v.HideSpinner", true);
        helper.getPaymentMethodRecord(component, event, helper);
    },
    prevPaymentMethodPage: function(component, event, helper) {
        component.set("v.currentPageNumberPaymentMethod", Math.max(component.get("v.currentPageNumberPaymentMethod") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethodRecord(component, event, helper);
    },
    nextPaymentMethodPage: function(component, event, helper) {
        component.set("v.currentPageNumberPaymentMethod", Math.min(component.get("v.currentPageNumberPaymentMethod") + 1, component.get("v.maxPageNumberPaymentMethod")));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethodRecord(component, event, helper);
    },
    lastPaymentMethodPage: function(component, event, helper) {
        component.set("v.currentPageNumberPaymentMethod", component.get("v.maxPageNumberPaymentMethod"));
        component.set("v.HideSpinner", true);
        helper.getPaymentMethodRecord(component, event, helper);
    },
    /* Added to show pagination on contact method section */
    firstContactPage: function(component, event, helper) {
        component.set("v.currentPageNumberContact", 1);
        component.set("v.HideSpinner", true);
        helper.getContacts(component, event, helper);
    },
    prevContactPage: function(component, event, helper) {
        component.set("v.currentPageNumberContact", Math.max(component.get("v.currentPageNumberContact") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getContacts(component, event, helper);
    },
    nextContactPage: function(component, event, helper) {
        component.set("v.currentPageNumberContact", Math.min(component.get("v.currentPageNumberContact") + 1, component.get("v.maxPageNumberContact")));
        component.set("v.HideSpinner", true);
        helper.getContacts(component, event, helper);
    },
    lastContactPage: function(component, event, helper) {
        component.set("v.currentPageNumberContact", component.get("v.maxPageNumberContact"));
        component.set("v.HideSpinner", true);
        helper.getContacts(component, event, helper);
    },
    /* Added to show pagination on Notes section */
    firstNotePage: function(component, event, helper) {
        component.set("v.currentPageNumberNote", 1);
        component.set("v.HideSpinner", true);
        helper.getNotes(component, event, helper);
    },
    prevNotePage: function(component, event, helper) {
        component.set("v.currentPageNumberNote", Math.max(component.get("v.currentPageNumberNote") - 1, 1));
        component.set("v.HideSpinner", true);
        helper.getNotes(component, event, helper);
    },
    nextNotePage: function(component, event, helper) {
        component.set("v.currentPageNumberNote", Math.min(component.get("v.currentPageNumberNote") + 1, component.get("v.maxPageNumberNote")));
        component.set("v.HideSpinner", true);
        helper.getNotes(component, event, helper);
    },
    lastNotePage: function(component, event, helper) {
        component.set("v.currentPageNumberNote", component.get("v.maxPageNumberNote"));
        component.set("v.HideSpinner", true);
        helper.getNotes(component, event, helper);
    },
    showAccountCustomField: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount")
        $A.createComponent(
            "c:ConfigAccountCustomFieldComponent", {
                "tractAccount": tractAccount
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

    showOneTimePurchaseDetail:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:OneTimePurchaseDetailComponent", {
                "OrderItemWrapper": component.get("v.OneTimeOrderItemList[" + count + "]"),
                "creditAdjustmentList": component.get("v.getCreditList")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },
    accountHierarchy:function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount")
        $A.createComponent(
            "c:AccountHierarchyComponent", {
                "tractBillingAccount": tractAccount
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },

    showBillingHierarchyModal:function(component, event, helper) {
        var responsibleAccount = component.get("v.tractBillingAccount")
        $A.createComponent(
            "c:BillingHierarchyComponent", {
                "responsibleAccountWrap": responsibleAccount
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );

    },
    scroll: function(component, event, helper) {
        component.set("v.pos", event.target.scrollTop);

    },
    reloadAccount: function(component, event, helper) {
        //component.set("v.outerHeight", event.getParam("ladyLoadingAtt"));
        //var billingAccWrapArr= component.get("v.billingAccWrapArr");
        helper.checkBillingAccount(component, event, helper);
    },
    editBasicAccountDetails: function(component, event, helper) {
        $A.createComponent(
            "c:EditBasicAccountDetails", {
                "accountId": component.get("v.accountId")
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
    showAccMapping:function(component, event, helper) {
        $A.createComponent(
            "c:ShowAccountMapping", {
                "AccountID": component.get("v.accountId")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }   
        );
    },
    showPaymentMethodModal:function(component, event, helper) {
        var buttonClicked = event. getSource(). get("v.label");
        if(buttonClicked === 'Execute Payment'){
            component.set("v.isPaymentOpen", true);
        }
        else{
            component.set("v.isPayment", false);
            component.set("v.isModalOpen", true);
        }
        
    },
    closePaymentMethod:function(component, event, helper) {
        console.log('Handle CLose');
        component.set("v.isModalOpen", false);
        component.set("v.isPaymentOpen", false);
    },

    showChangeCreateOrderModal: function(component, event, helper) {
        var tractAccount = component.get("v.tractBillingAccount");
        var selectedItem = event.currentTarget;
        var countchangeCreateOrderValue = selectedItem.dataset.countchangeorder;
        console.log('countchangeCreateOrderValue::::::'+countchangeCreateOrderValue);
        var wrapObj = component.get("v.wrappers[" + countchangeCreateOrderValue + "]");
        console.log('wrapObj::::::'+wrapObj);
        $A.createComponent(
            "c:createChangeOrderComp", {
                "objectApiName":'Account',
                "onsubmitsuccess": component.getReference("c.jsLoaded"),
                "currentServiceId": wrapObj.serviceEid,
                "currencyType": component.get("v.tractBillingAccount.accountCurrency")
            },
            function(lwcCmp, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(lwcCmp);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.");
                }
                else if (status === "ERROR") {
                    console.error("Error: " + errorMessage);
                }
            }
          );
    }

})