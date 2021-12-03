({
    removeMarketPlace:function(component, event, helper) {
        var action = component.get("c.deleteThisMarketPlace");        
        action.setParams({
            marketPlaceId : component.get("v.thisWrapper.mplaceId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                if(res == 'NoError'){
                 var appEvent = $A.get("e.c:ReloadMarketPlace");
                 appEvent.fire();
                 component.destroy();
                }
                else{
                    component.set("v.message",res);
                    document.getElementById("showErrorDeleteMarketplace").style.display = "block";
                }
            }
            else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorDeleteMarketplace").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorDeleteMarketplace").style.display = "block";
                }
            }      
        });  
        $A.enqueueAction(action);
    }
})