({
    getProductWrapper : function(component, event, helper) {
        var action = component.get("c.getCreateProductWrapper"); 
         action.setParams({
            productId : component.get("v.productId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                console.log('res::::::::::'+JSON.stringify(res));       
                if(res.eid != null){
                    var message = '\''+res.productName+'\' has already been moved to GTV.'
                    component.set("v.showMessage",true);
                    component.set("v.message",message);
                }
                else{
                    component.set("v.CreateProductWrapper",res);
                }
            }
        });
        $A.enqueueAction(action);
    },

    createProductInGTV : function(component, event, helper){
        var createProductWrapper = component.get("v.CreateProductWrapper");
        var action = component.get("c.createProduct"); 
        console.log('Wrapper::::::::::'+JSON.stringify(createProductWrapper));       
        action.setParams({
            createProductWrapperString : JSON.stringify(createProductWrapper)
        });
        action.setCallback(this, function(response){     
            var state = response.getState();
            if(state === "SUCCESS"){
                var message = response.getReturnValue();
                console.log('message::::::::::'+message);
                if(message == "NoError"){
                    console.log('Product is successfully Created');    
                    window.location.href='/'+  component.get("v.productId");
                    /*var Get_getUITheme = component.get("v.getUITheme");
                    if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                        sforce.one.navigateToSObject(oppId);
                    }else{
                        window.location.href='/'+ oppId;
                    }
                    window.location.href='/'+ oppId;*/
                    
                }else{
                    component.set("v.message",message);
                    document.getElementById("showErrorProductCreation").style.display = "block";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCreation").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCreation").style.display = "block";
                }
            }           
        });  
        $A.enqueueAction(action);
    }
})