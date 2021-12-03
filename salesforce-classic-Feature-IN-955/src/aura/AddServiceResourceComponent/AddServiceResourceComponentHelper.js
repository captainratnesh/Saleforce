({
    getResourceEid : function(component, event, helper, srId) {
        var action = component.get("c.getServiceResource");        
        action.setParams({
             srId : srId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var responseWrapper = response.getReturnValue();
                 if(responseWrapper.errorMessage == 'NoError'){
                     var srWrapper = component.get("v.addedServiceResources");
                     srWrapper.push(responseWrapper);
                     component.set("v.addedServiceResources",srWrapper);
					 var srIdList = component.get("v.srIdList");
					 srIdList.push(srId);
					 component.set("v.srIdList",srIdList);
					 component.set("v.srId",'');
                 }else{
                     component.set("v.message", responseWrapper.errorMessage);
                     document.getElementById("showErrorResource").style.display = "block";
                 }
             }else if(state === "ERROR" ){
            	var errors = response.getError();
            	if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }
              }
        });   
        
        $A.enqueueAction(action);
    },
    applyServiceResourceToProduct : function(component, event){
    	var action = component.get("c.applySrIdToProduct");
    	action.setParams({
    						srWrapper 		: JSON.stringify(component.get("v.addedServiceResources")),
    						productWrapper	: JSON.stringify(component.get("v.productWrapper"))
    					});
		action.setCallback(this, function(response){
			var state = response.getState();
			if(state === "SUCCESS"){
				var prodWrapper = response.getReturnValue();
				component.set("v.productWrapper",prodWrapper);
				var appEvent = $A.get("e.c:ServiceResourceReturnAction");
				appEvent.setParams({"productWrapper": component.get("v.productWrapper")});
				appEvent.fire();
				component.destroy();
			}else if(state === "ERROR"){
				var errors = response.getError();;
                if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
                	document.getElementById("showErrorResource").style.display = "block";
                }else if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }
			}
		});
		$A.enqueueAction(action);
    },
    configuredServiceResource : function (component, event, productWrapper){
    	var action = component.get("c.getAppliedServiceResources");    	
    	action.setParams({
    						prodWrapper : JSON.stringify(productWrapper)
    					});
		action.setCallback(this, function(response){
			var state = response.getState();
			if(state === "SUCCESS"){
				var srWrapperList = response.getReturnValue();
				component.set("v.addedServiceResources",srWrapperList);
				var sridListSize = component.get("v.size");
				sridListSize = srWrapperList.length;
				component.set("v.size",sridListSize);
				if(srWrapperList.length > 0){
					document.getElementById("addedSrIdRow").style.display = "table-row";
				}
			}else if(state === "ERROR"){
				var errors = response.getError();
                if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
                	document.getElementById("showErrorResource").style.display = "block";
                }else if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }
			}
		});
		$A.enqueueAction(action);
		
	},
	checkForExistingResource : function(component, event, helper, srId) {
		var action = component.get("c.checkExistingServiceResource");        
        action.setParams({
             srId : srId
		});
		action.setCallback(this, function(response){
			var state = response.getState();
            if(state === "SUCCESS"){
                var errorMessage = response.getReturnValue();
                 if(errorMessage == 'NoError'){
					var srWrapper = component.get("v.addedServiceResources");
					srWrapper.push({'sobjectType':'ServiceResourceWrapper','eid':'','identifier': srId});
					component.set("v.addedServiceResources",srWrapper);
					var srIdList = component.get("v.srIdList");
					srIdList.push(srId);
					component.set("v.srIdList",srIdList);
					component.set("v.srId",'');
                 }else{
                     component.set("v.message", errorMessage);
                     document.getElementById("showErrorResource").style.display = "block";
                 }
             }else if(state === "ERROR" ){
            	var errors = response.getError();
            	if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
	                document.getElementById("showErrorResource").style.display = "block";
                }
              }
		});
		$A.enqueueAction(action);
	}
})