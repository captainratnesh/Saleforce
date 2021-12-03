({
    doinit : function(component, event, helper) {
        var action = component.get("c.changeOrderIndicator");
        action.setParams({
            opportunityId : component.get("v.opportunityId")
        });    
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){              
                var res =  response.getReturnValue();
                console.log('res:::'+res);
                if(res == true){
                    component.set("v.ChangeOrderService",true);
                    component.set("v.ShowHideOrderService",true);
                    helper.getActiveService(component, event, helper);
                }
                else if(res == false){
                    component.set("v.ChangeOrderService",false);
                    helper.getAPiVersion(component, event, helper);
                    helper.getAllProducts(component, event, helper);
                    helper.getExistingOliProducts(component, event, helper);

                }
            }
        });
       
        $A.enqueueAction(action);
       
    },
    searchKeyChange : function(component, event, helper) {
        var searchArray = [];
        var searchedValue = component.get("v.searchedProduct");
        console.log('searchedValue::::'+searchedValue);
        var allProductList = component.get("v.productListWrapper").productList;
        console.log('allProductList::::'+allProductList);
        for(var i in allProductList){
            if(allProductList[i].Name.toLowerCase().startsWith(searchedValue.toLowerCase())){
                searchArray.push(allProductList[i]);
            }
        }
        console.log('searchArray::::'+searchArray);
        component.set("v.searchedProductList", searchArray);
        component.set("v.currentPage", 1);
        component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        if(searchArray.length !=0){
                helper.startProducts(component, event, helper);
        }
    },
    nextProduct : function(component, event, helper) {
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var oppProList = component.get("v.searchedProductList");        
        var productListMap = component.get("v.productListMap");       
        productListMap[currentPage] = oppProList;
        currentPage++;
        component.set("v.searchedProductList", productListMap[currentPage]);
        component.set("v.currentPage", currentPage);
        if(currentPage == totelPage){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
        component.set("v.disablePrev", false); 
        component.set("v.disableFirst", false); 
        
    },  
	prevProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
        var oppProList = component.get("v.searchedProductList");
        var productListMap = component.get("v.productListMap");        
        productListMap[currentPage] = oppProList;
        currentPage--; 
        component.set("v.searchedProductList", productListMap[currentPage]);
        component.set("v.currentPage", currentPage);
	    if(currentPage == 1){
	        component.set("v.disablePrev", true); 
	        component.set("v.disableFirst", true); 
	    }
	    component.set("v.disableNext", false);
	    component.set("v.disableLast", false);
	},   
	lastProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var lastPage = component.get("v.totelPage");
	    var oppProList = component.get("v.searchedProductList");
	    var productListMap = component.get("v.productListMap");	    
	    productListMap[currentPage] = oppProList;
	    component.set("v.searchedProductList", productListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);
	},   
	firstProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var oppProList = component.get("v.searchedProductList");
	    var productListMap = component.get("v.productListMap");	    
	    productListMap[currentPage] = oppProList;
	    component.set("v.searchedProductList", productListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);
    },
    openthisProduct:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:AddToCartConfigurationModal", {
                "selectedProduct": component.get("v.searchedProductList[" + count + "]"),
                "opportunityId":component.get("v.opportunityId")
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
    addProductToCart:function(component, event, helper) {
        var thisProduct = event.getParam("addedProductWrapper");
        console.log('thisProduct:::::'+JSON.stringify(thisProduct));
        var existingProductList = component.get("v.existingProductWrapperList");
        if(existingProductList.length == 0){
            existingProductList.push(thisProduct);
            component.set("v.existingProductWrapperList",existingProductList);
        }
        else{
            component.set("v.ShowCartProducts", true);
            if(thisProduct.prod.TRACT3__Serialized__c == true){
                helper.uniqueProductProcessing(component,thisProduct,existingProductList);
            }
            else{
                helper.nonUniqueProductProcessing(component,thisProduct,existingProductList);

            }
        }
        document.getElementById("showErrorproductListWrap").style.display = "none";
    },
    removeProductFromCart:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        console.log('count::::::'+count);
        var productToRemove = component.get("v.existingProductWrapperList[" + count + "]");
        var existingProductList = component.get("v.existingProductWrapperList");
        for(var i in existingProductList){
            if(existingProductList[i].service == productToRemove.prod.Id){
                existingProductList[i].service = undefined;
                existingProductList[i].serviceName = null;
            }
        }
        console.log('productToRemove::::::'+JSON.stringify(productToRemove));
        if(productToRemove.prod.TRACT3__Serialized__c == true && productToRemove.priceOverridden == false){
            var existingProductList = component.get("v.existingProductWrapperList");
            existingProductList.splice(count,1);
            var existingCount = 0;
            for(var i in existingProductList){
                if((existingProductList[i].prod.Name == productToRemove.prod.Name) && (existingProductList[i].recurrencPerValue == productToRemove.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                    existingCount +=1;
                 }
            }
            console.log('existingCount::::::'+existingCount);
            if(existingCount >0){
                helper.processTearing(component,existingCount,productToRemove);
                for(var i in existingProductList){
                    if((existingProductList[i].prod.Name == productToRemove.prod.Name) && (existingProductList[i].recurrencPerValue == productToRemove.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                        existingProductList[i].recurringprice = productToRemove.recurringprice;
                        existingProductList[i].totelPrice = productToRemove.totelPrice;
                        existingProductList[i].unitPrice = productToRemove.unitPrice;
                    }
                }
            }
            component.set("v.existingProductWrapperList",existingProductList);
        }
        else{
            var existingProductList = component.get("v.existingProductWrapperList");
            existingProductList.splice(count,1);
            component.set("v.existingProductWrapperList",existingProductList);
        }

    },
    overrideThisQty:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:OverrideQuantityInCartComponent", {
                "AddedProductWrapper": component.get("v.existingProductWrapperList[" + count + "]")
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
    overrideQtyReturn:function(component, event, helper) {
        var thisProduct = event.getParam("addedProductWrapper");
        helper.processTearing(component,thisProduct.quantity,thisProduct);
        var existingProductList = component.get("v.existingProductWrapperList");
        for(var i in existingProductList){
            if((existingProductList[i].prod.Name == thisProduct.prod.Name) && (existingProductList[i].recurrencPerValue == thisProduct.recurrencPerValue)){
                existingProductList[i] = thisProduct;
                break;
            }
        }
        component.set("v.existingProductWrapperList",existingProductList);
    },
    SaveAndClose:function(component, event, helper) {
        var existingProductList = component.get("v.existingProductWrapperList");
        if(existingProductList.length == 0){
            component.set("v.message", 'Cart is empty. Please add items to the cart.');
            document.getElementById("showErrorproductListWrap").style.display = "block";
        } 
        else{
            document.getElementById("showErrorproductListWrap").style.display = "none";
            component.set("v.isConfiguration", true);
        }
    },
    AddMoreProducts:function(component, event, helper) {
        component.set("v.isConfiguration", false);
        document.getElementById("showErrorproductListWrap").style.display = "none";
    },
    addParent:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        $A.createComponent(
            "c:ParentServiceComponent", 
            {
                "productWrapper": component.get("v.existingProductWrapperList["+count+"]"),
                "productWrapperList": component.get("v.existingProductWrapperList"),
                "oppId": component.get("v.opportunityId")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    editdescription : function(component, event, helper) {
        var selectedItem = event.currentTarget; 
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var productWrapObj = component.get("v.existingProductWrapperList["+count+"]");
        $A.createComponent(
            "c:ShortDecriptionComponent", 
            {
                "proWrap": productWrapObj
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                    
                }
                
            }
        );
    },
    selectAgreement : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var productWrapObj = component.get("v.existingProductWrapperList["+count+"]");
        $A.createComponent(
            "c:AddAgreementComponent", 
            {
                "productWrapper": productWrapObj
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    overridetrail : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        $A.createComponent(
            "c:OverrideTrialLength", {
                "wrappers": component.get("v.existingProductWrapperList[" + count + "]")
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
    addServiceResource : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var productWrapObj = component.get("v.existingProductWrapperList["+count+"]");
        $A.createComponent(
            "c:AddServiceResourceComponent", 
            {
                "productWrapper": productWrapObj
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                    
                }
                
            }
        ); 
    },
    addDiscountCode : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        console.log('count::::'+count);
        component.set("v.ProdCount", count);
        $A.createComponent(
            "c:DiscountCodeComponent", {
                "productWrapper": component.get("v.existingProductWrapperList[" + count + "]")
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
        /*var appEvent = $A.get("e.c:ProductDiscountCodeEvent");
        appEvent.setParams({"productWrapper": component.get("v.existingProductWrapperList["+count+"]")});
        appEvent.fire();
        
        document.getElementById("discountCode").style.display = "block";
        document.getElementById("discountCodeBackground").style.display = "block"; */
    },
    configCustomField : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var appEvent = $A.get("e.c:ConfigCustomFieldEvent");
        appEvent.setParams({
            "productWrapper": component.get("v.existingProductWrapperList["+count+"]")
        });
        appEvent.fire();
        
        document.getElementById("customField").style.display = "block";
        document.getElementById("customFieldBackground").style.display = "block"; 
    },
    scheduleCharge : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        $A.createComponent(
            "c:ScheduleChargesComponent", 
            {
                "productWrapper": component.get("v.existingProductWrapperList["+count+"]"),
                "oppId"			: component.get("v.opportunityId")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    cofigureChargeRule : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var appEvent = $A.get("e.c:ConfigureChargeRuleAction");
        appEvent.setParams({
            "productWrapper": component.get("v.existingProductWrapperList["+count+"]"),
            "oppId"			: component.get("v.opportunityId")
        });
        appEvent.fire();
        document.getElementById("prodActivityChargeModal").style.display = "block";
        document.getElementById("prodBackGroundActivityCharge").style.display = "block"; 
    },
    addOrderCustomField : function(component, event, helper) {
        $A.createComponent(
            "c:OrderCustomFieldComponent", 
            {
                "oppId": component.get("v.opportunityId")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                    
                }
                
            }
        );
        /* var evt = $A.get("e.c:OrderCustomFieldEvent");
        evt.setParams({ "oppId": component.get("v.oppId")});
        evt.fire();
        document.getElementById("orderCustomField").style.display = "block";
        document.getElementById("orderCustomFieldBackground").style.display = "block"; */
    },
    createOrder : function(component, event, helper) {
        var addedProduct = component.get("v.existingProductWrapperList");
        var oppId = component.get("v.opportunityId");
        helper.createSalesOrder(component, event, helper, addedProduct, oppId);
    },
    closeModalBox:function(component, event, helper) {
        window.location.href = '/'+component.get("v.opportunityId");
    },
    handleServiceResourceReturnAction : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
     handleReturnOverrideTrialLength : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleProductDiscountCodeReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        console.log('count::::'+count);
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleSelectedAgreementReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleSetParentEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleOpportunityProductErrorEvent : function(component, event, helper) {
        var errorMessage = event.getParam("errorMessage");
        component.set("v.message", errorMessage);
        document.getElementById("showErrorProductCart").style.display = "block";
    },
    handleScheduleChargeReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleEditShortDescriptionReturnEvent : function(component, event, helper) {
        console.log('Event Handle');
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    handleConfigServiceCustomFieldReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);
    },
    waiting : function(component, event, helper) {
        document.getElementById("showspinner").style.display = "block";
    },
    doneWaiting : function(component, event, helper) {
        document.getElementById("showspinner").style.display = "none";
    },
    overridePrices:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.ProdCount", count);
        var recurringPriceRanges;
        var oneTimePriceRanges;
        var addedProductWrapper = component.get("v.existingProductWrapperList[" + count + "]");
        var mapOfProductPriceEidVsPriceRangeList = addedProductWrapper.priceVsPriceRanges;
        if(addedProductWrapper.recurringprice != null){
            recurringPriceRanges = mapOfProductPriceEidVsPriceRangeList[addedProductWrapper.recurrencPerValue];
        }
        if(addedProductWrapper.oneTimePrice != null){
            oneTimePriceRanges = mapOfProductPriceEidVsPriceRangeList[addedProductWrapper.oneTimePerValue];
        }
        $A.createComponent(
            "c:OverridePriceInCartComponent", {
                "AddedProductWrapper": addedProductWrapper,
                "OldRecurringPriceRanges": recurringPriceRanges,
                "OldOneTimePriceRanges": oneTimePriceRanges
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

    handleoverridePriceReturn:function(component, event, helper){
        var productWrapper = event.getParam("addedProductWrapper");
        var count = component.get("v.ProdCount");
        component.set("v.existingProductWrapperList["+count+"]", productWrapper);

        if(productWrapper.prod.TRACT3__Serialized__c == true){
            var referenceProduct;
            var existingProductList = component.get("v.existingProductWrapperList");
            var existingCount = 0;
            for(var i in existingProductList){
                if((existingProductList[i].prod.Name == productWrapper.prod.Name) && (existingProductList[i].recurrencPerValue == productWrapper.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                    existingCount +=1;
                    referenceProduct = existingProductList[i];
                }
            }
            console.log('existingCount:::::'+existingCount);
            if(existingCount >0){
                helper.processTearing(component,existingCount,referenceProduct);

                for(var i in existingProductList){
                    if((existingProductList[i].prod.Name == referenceProduct.prod.Name) && (existingProductList[i].recurrencPerValue == referenceProduct.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                        existingProductList[i].recurringprice = referenceProduct.recurringprice;
                        existingProductList[i].totelPrice = referenceProduct.totelPrice;
                        existingProductList[i].unitPrice = referenceProduct.unitPrice;
                    }
                }
            }
            component.set("v.existingProductWrapperList",existingProductList);
        }
    },

    searchService:function(component, event, helper){
        var searchServiceList =[];
        var searchedValue = component.get("v.searchedService");
        console.log('searchedValue::::'+searchedValue);
        var allServiceList = component.get("v.gtvServiceList").serviceList;
        for(var i in allServiceList){
            if(allServiceList[i].serviceName.toLowerCase().startsWith(searchedValue.toLowerCase())){
                searchServiceList.push(allServiceList[i]);
            }
        }
        component.set("v.searchedServiceList",searchServiceList);
        component.set("v.currentPage", 1);
        component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true);
        if(searchServiceList.length !=0){
            helper.getSearchedServiceList(component, event, helper);
        }

    },
    firstService:function(component, event, helper){
        var currentPage = component.get("v.currentPage");
	    var oppServiceList = component.get("v.searchedServiceList");
	    var serviceListMap = component.get("v.serviceListMap");	    
	    serviceListMap[currentPage] = oppServiceList;
	    component.set("v.searchedServiceList", serviceListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);

    },
    previousService:function(component, event, helper){
        var currentPage = component.get("v.currentPage");
        var oppServiceList = component.get("v.searchedServiceList");
        var serviceListMap = component.get("v.serviceListMap");        
        serviceListMap[currentPage] = oppServiceList;
        currentPage--; 
        component.set("v.searchedServiceList", serviceListMap[currentPage]);
        component.set("v.currentPage", currentPage);
	    if(currentPage == 1){
	        component.set("v.disablePrev", true); 
	        component.set("v.disableFirst", true); 
	    }
	    component.set("v.disableNext", false);
	    component.set("v.disableLast", false);

    },
    nextService:function(component, event, helper){
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var oppServiceList = component.get("v.searchedServiceList");        
        var serviceListMap = component.get("v.serviceListMap");       
        serviceListMap[currentPage] = oppServiceList;
        currentPage++;
        component.set("v.searchedServiceList", serviceListMap[currentPage]);
        component.set("v.currentPage", currentPage);
        if(currentPage == totelPage){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
        component.set("v.disablePrev", false); 
        component.set("v.disableFirst", false);

    },
    lastService:function(component, event, helper){
        var currentPage = component.get("v.currentPage");
	    var lastPage = component.get("v.totelPage");
	    var oppServiceList = component.get("v.searchedServiceList");
	    var serviceListMap = component.get("v.serviceListMap");	    
	    serviceListMap[currentPage] = oppServiceList;
	    component.set("v.searchedServiceList", serviceListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);

    },
  
    changeOrderModal:function(component, event, helper){
        var selectedItem = event.currentTarget;
        var countchangeCreateOrderValue = selectedItem.dataset.count;
        var wrapp = component.get("v.searchedServiceList["+ countchangeCreateOrderValue +"]");
        component.set("v.ShowHideOrderService",false);
        console.log('wrapp::::::'+JSON.stringify(wrapp));
        console.log('Currency::::::'+component.get("v.currencyCode"));
        $A.createComponent(
            "c:createChangeOrderOpportunityComp", {
                "onsubmitsuccess": component.getReference("c.doinit"),
                "currentServiceId":wrapp.serviceId,
                "currencyType": component.get("v.currencyCode"),
                "oppRecordId" : component.get("v.opportunityId")
            },
            function(lwcCmp, status, errorMessage) {               
                console.log('status:::::::'+status);
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
        )

    },
     /* changeOrderModal : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var countchangeCreateOrderValue = selectedItem.dataset.count;
        var wrapp = component.get("v.searchedServiceList["+ countchangeCreateOrderValue +"]");
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:createChangeOrderOpportunityComp",
            componentAttributes: {
                "currentServiceId":wrapp.serviceId,
                "currencyType": component.get("v.currencyCode"),
                "oppRecordId" : component.get("v.opportunityId")
            }
        });
        evt.fire();
    },*/
})