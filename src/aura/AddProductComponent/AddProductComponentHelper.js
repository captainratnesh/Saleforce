({
    getAPiVersion : function(component, event, helper) {
        var action = component.get("c.getApiVersion"); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.ApiVersion",res);
            }
        });
        $A.enqueueAction(action);
    },
    getAllProducts : function(component, event, helper){
        var action = component.get("c.getAllProductList");    
        action.setParams({
            opportunityId : component.get("v.opportunityId")
        });       
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var productListWrap = response.getReturnValue();
                if(productListWrap.errorMessage == "NoBillingAccount"){
                   component.set("v.disableProduct", true);
                   component.set("v.disablePrev", true); 
                   component.set("v.disableFirst", true); 
                   component.set("v.disableNext", true);
                   component.set("v.disableLast", true);
                   component.set("v.message", "No BillingAccount is  selected for this Opportunity. Please select a BillingAccount first.");
                   document.getElementById("showError").style.display = "block";
               }else if(productListWrap.errorMessage == "NoCurrencyType"){
                   component.set("v.disableProduct", true);
                   component.set("v.disablePrev", true); 
                   component.set("v.disableFirst", true); 
                   component.set("v.disableNext", true);
                   component.set("v.disableLast", true);
                   component.set("v.message", "The Billing Account associated with this Opportunity is not available in TRACT.");
                   document.getElementById("showError").style.display = "block";
               }else if(productListWrap.errorMessage == "NoPriceBook"){
                   component.set("v.disableProduct", true);
                   component.set("v.disablePrev", true); 
                   component.set("v.disableFirst", true); 
                   component.set("v.disableNext", true);
                   component.set("v.disableLast", true);
                   component.set("v.message", "No Price book is selected for this Opportunity. Please select a Price book first.");
                   document.getElementById("showError").style.display = "block";
               }else if(productListWrap.errorMessage == "OrderCreated"){
                   component.set("v.disableProduct", true);
                   component.set("v.disablePrev", true); 
                   component.set("v.disableFirst", true); 
                   component.set("v.disableNext", true);
                   component.set("v.disableLast", true);
                   component.set("v.message", "This opportunity has already been moved in GTV");
                   document.getElementById("showError").style.display = "block";
               }else{
                   component.set("v.productListWrapper", productListWrap);
                   component.set("v.searchedProductList", productListWrap.productList);
                   this.startProducts(component, event, helper); 
               }
           }
        });  
        $A.enqueueAction(action);
    },
    getExistingOliProducts: function(component, event, helper) {
        var action = component.get("c.getExistingOliProduct");    
        console.log('opportunityId:::::::::::::::::::::::;'+component.get("v.opportunityId"));
        action.setParams({
            opportunityId : component.get("v.opportunityId")
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('state:::::::::::::::::::::::;'+state);
            if(state === 'SUCCESS'){
                var existingProductList = response.getReturnValue();
                console.log('existingProductList:::::::::::::::::::::::;'+JSON.stringify(existingProductList));
                component.set("v.existingProductWrapperList",existingProductList);
            }
        });
        $A.enqueueAction(action);
    },
    startProducts : function(component, event, helper) {
        var oppProLists = component.get("v.searchedProductList");
        var totelProduct = oppProLists.length;
        var totelPage = Math.ceil(totelProduct / 10);
        var productListMap = component.get("v.productListMap");
        var currentLocation = 0;
        for(var i=1; i<=totelPage; i++){
        var proList = [];
        var count = 0;
        var displayLocation = (currentLocation + 10) >= totelProduct ?  totelProduct :  (currentLocation + 10) ;
        for(var j=currentLocation ; j<displayLocation; j++ ){
            proList[count++] = oppProLists[j];
        }
        currentLocation =  displayLocation;
        productListMap[i] = proList;
        }
        component.set("v.productListMap", productListMap);
        component.set("v.totelPage", totelPage);
        var currentPage = component.get("v.currentPage");
        component.set("v.searchedProductList", productListMap[currentPage]);
        if(totelPage == 1){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
        else if(totelPage > 1){
            component.set("v.disableNext", false); 
            component.set("v.disableLast", false); 
        }
    },
    uniqueProductProcessing:function(component, thisNewProduct, existingProductList){
        var count=1;
        var flag=0;
        for(var i in existingProductList){
            if((existingProductList[i].prod.Name == thisNewProduct.prod.Name) && (existingProductList[i].recurrencPerValue == thisNewProduct.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                count++;
                flag=1;
            }
        }
        if(flag==0){
        existingProductList.push(thisNewProduct);
        }
        if(count >1){
            this.processTearing(component,count,thisNewProduct);
            for(var i in existingProductList){
                if((existingProductList[i].prod.Name == thisNewProduct.prod.Name) && (existingProductList[i].recurrencPerValue == thisNewProduct.recurrencPerValue) && existingProductList[i].priceOverridden == false){
                    existingProductList[i].recurringprice = thisNewProduct.recurringprice;
                    existingProductList[i].totelPrice = thisNewProduct.totelPrice;
                    existingProductList[i].unitPrice = thisNewProduct.unitPrice;
                }
            }
            existingProductList.push(thisNewProduct);
        }
        component.set("v.existingProductWrapperList",existingProductList);
    
    },
    processTearing:function(component,count,proWrapper){
            var productPriceEid = proWrapper.recurrencPerValue;
            var mapOfProductPriceEidVsPriceRangeList = proWrapper.priceVsPriceRanges;
            var ProductPriceRangeWrapperList = mapOfProductPriceEidVsPriceRangeList[productPriceEid];
            for(var i in ProductPriceRangeWrapperList){
                if(ProductPriceRangeWrapperList[i].quantityEndRange != null){
                    if(ProductPriceRangeWrapperList[i].quantityBeginRange < count && ProductPriceRangeWrapperList[i].quantityEndRange >= count){
                        proWrapper.recurringprice = ProductPriceRangeWrapperList[i].price;
                        proWrapper.unitPrice = this.returnUnitPrice(proWrapper.recurringprice,proWrapper.oneTimePrice);
                        proWrapper.totelPrice = eval(proWrapper.unitPrice*proWrapper.quantity);
                    }
                }
                else{
                    if(ProductPriceRangeWrapperList[i].quantityBeginRange < count){
                        proWrapper.recurringprice = ProductPriceRangeWrapperList[i].price;
                        proWrapper.unitPrice = this.returnUnitPrice(proWrapper.recurringprice,proWrapper.oneTimePrice);
                        proWrapper.totelPrice = eval(proWrapper.unitPrice*proWrapper.quantity);
                    }
                }
            }
        },
        nonUniqueProductProcessing:function(component, thisNewProduct, existingProductList){
            var flag=0;
           
            for(var i in existingProductList){
                if((existingProductList[i].prod.Name == thisNewProduct.prod.Name) && (existingProductList[i].recurrencPerValue == thisNewProduct.recurrencPerValue)){
                    console.log('existingProductList[i].quantity::::'+existingProductList[i].quantity);
                    existingProductList[i].quantity=eval(existingProductList[i].quantity)+1;
                    console.log('existingProductList[i].quantity::::'+existingProductList[i].quantity);
                    this.processTearing(component,existingProductList[i].quantity,existingProductList[i]);
                    flag=1;
                    break;
                }
            }
            if(flag==0){
                existingProductList.push(thisNewProduct);
            }
            component.set("v.existingProductWrapperList",existingProductList);
        },
        createSalesOrder : function(component, event, helper, productList, oppId){
            var action = component.get("c.createSalesOrderApex");        
            action.setParams({
                productWrapperString : JSON.stringify(productList),
                opportunityId : oppId
            });
            
            action.setCallback(this, function(response){
                var state = response.getState();
                
                if(state === "SUCCESS"){
                    var proList = response.getReturnValue();
                    
                    if(proList == "NoError"){
                        
                        var Get_getUITheme = component.get("v.getUITheme");
                        /*if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                            sforce.one.navigateToSObject(oppId);
                        }else{
                            window.location.href='/'+ oppId;
                        }*/
                        window.location.href='/'+ oppId;
                        
                    }else{
                        component.set("v.message",proList);
                        document.getElementById("showErrorproductListWrap").style.display = "block";
                    }
                }else if(state === "ERROR" ){
                    var errors = response.getError();
                    if(errors[0] && errors[0].message){
                        component.set("v.message", errors[0].message);
                        document.getElementById("showErrorproductListWrap").style.display = "block";
                    }else if(errors[0] && errors[0].pageErrors){
                        component.set("v.message", errors[0].pageErrors[0].message);
                        document.getElementById("showErrorproductListWrap").style.display = "block";
                    }
                }           
            });  
            $A.enqueueAction(action);
        },
    
        returnUnitPrice: function(recurringPrice,oneTimePrice) {
            if(recurringPrice!=null && oneTimePrice!=null){
                return (eval(recurringPrice)+eval(oneTimePrice));
            }
            else if(recurringPrice == null && oneTimePrice != null){
                return eval(oneTimePrice);
            }else if(recurringPrice != null && oneTimePrice == null){
                return eval(recurringPrice);
            }   
        },
        getActiveService: function(component, event, helper){
            var action = component.get("c.getActiveServiceList");    
            action.setParams({
                opportunityId : component.get("v.opportunityId")
            }); 
            action.setCallback(this, function(response){
                var state = response.getState();                
                if(state === "SUCCESS"){
                    var serviceWrapper = response.getReturnValue();
                    if(serviceWrapper.errorMessage == 'No Error'){
                        console.log('serviceWrapper:::'+JSON.stringify(serviceWrapper));
                        component.set("v.gtvServiceList",serviceWrapper);
                        component.set("v.searchedServiceList",serviceWrapper.serviceList);
                        component.set("v.currencyCode",serviceWrapper.currencyCode);
                        this.getSearchedServiceList(component, event, helper);
                    }
                    else{
                        component.set("v.message", serviceWrapper.errorMessage);
                        document.getElementById("showError").style.display = "block";
                        component.set("v.ShowHideOrderService",false);
                    }
                }
            });

            $A.enqueueAction(action);
        },
        getSearchedServiceList:function(component, event, helper){
            var searchedServiceList = component.get("v.searchedServiceList");
            var totalServices = searchedServiceList.length;
            var totalPages = Math.ceil(totalServices / 10);
            var serviceMap = component.get("v.serviceListMap");
            var currentLocation = 0;
            for(var i =1; i<=totalPages; i++){
                var serviceList = [];
                var count = 0;
                var displayLocation = (currentLocation + 10)>= totalServices ? totalServices:currentLocation + 10;
                for( var j=currentLocation; j<displayLocation; j++){
                    serviceList[count++] = searchedServiceList[j];
                }
                currentLocation = displayLocation;
                serviceMap[i] = serviceList;
            }
            component.set("v.serviceListMap",serviceMap);
            component.set("v.totelPage",totalPages);
            var currentPage = component.get("v.currentPage");
            component.set("v.searchedServiceList",serviceMap[currentPage]);
            if(totalPages == 1){
                component.set("v.disableNext", true); 
                component.set("v.disableLast", true); 
             }
             else if(totalPages > 1){
                 component.set("v.disableNext", false); 
                 component.set("v.disableLast", false); 
             }

        }
    
    })