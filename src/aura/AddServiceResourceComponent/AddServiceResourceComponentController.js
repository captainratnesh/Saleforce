({
    closeModalBox : function(component, event, helper) {
        component.destroy();
    },
    selectedNewResource : function(component, event, helper) {
		component.find("checkbox2").set("v.value",false);
		document.getElementById("newServiceResource").style.display = "table-row";
		document.getElementById("existingServiceResource").style.display = "none";
		document.getElementById("showErrorResource").style.display = "None";
    },
    selectedExistingResource : function(component, event, helper) {
		component.find("checkbox1").set("v.value",false);
		document.getElementById("existingServiceResource").style.display = "table-row";
		document.getElementById("newServiceResource").style.display = "none";
		document.getElementById("showErrorResource").style.display = "None";
    },
    doInit : function(component, event, helper) {
       var productWrapper = component.get("v.productWrapper");
       if((productWrapper.serviceResourceName != null && productWrapper.serviceResourceName != undefined && productWrapper.serviceResourceName != '') || (productWrapper.newServiceResource != null && productWrapper.newServiceResource != undefined && productWrapper.newServiceResource != null && productWrapper.newServiceResource != '')){
    		//call helper method
    		helper.configuredServiceResource(component, event, productWrapper);
    	}        
    },
    saveServiceResource : function(component, event, helper) {
    	var srIdList = component.get("v.srIdList");
    	var addedSrIdList = component.get("v.addedServiceResources");
    	var sridListSize = component.get("v.size");
    	if(srIdList.length != 0 || sridListSize != addedSrIdList.length){
	    		helper.applyServiceResourceToProduct(component, event);
    	}else{
    		var appEvent = $A.get("e.c:ServiceResourceReturnAction");
    		appEvent.setParams({"productWrapper": component.get("v.productWrapper")});
			appEvent.fire();
			component.destroy();
    	}
    },
    addServiceResource : function(component, event, helper) {
    var productWrap = component.get("v.productWrapper");
    var addedServiceResources = component.get("v.addedServiceResources");
    if(productWrap.maxServiceResource == addedServiceResources.length){
		component.set("v.message", 'Maximum number of service resources has already been applied on this order item.');
		document.getElementById("showErrorResource").style.display = "block";
		document.getElementById("newServiceResource").style.display = "None";
		document.getElementById("existingServiceResource").style.display = "None";
    }
    else{
    	var srId = component.get("v.srId");
    	if(srId == '' || srId == undefined || srId == null){
    		component.set("v.message", 'Please enter value in Service Resource field.');
    		document.getElementById("showErrorResource").style.display = "block";
    	}else{    
    		var srIdList = component.get("v.srIdList");
			if(srIdList.indexOf(srId) == -1){
				document.getElementById("showErrorResource").style.display = "None";
				document.getElementById("addedSrIdRow").style.display = "table-row";
				if(component.find("checkbox2").get("v.value")){
					 helper.getResourceEid(component, event, helper,srId);
				}else if(component.find("checkbox1").get("v.value")){
					/*var srWrapper = component.get("v.addedServiceResources");
					srWrapper.push({'sobjectType':'ServiceResourceWrapper','eid':'','identifier': srId});
					component.set("v.addedServiceResources",srWrapper);
					srIdList.push(srId);
					component.set("v.srIdList",srIdList);
					srId = '';
					component.set("v.srId",srId);*/
					helper.checkForExistingResource(component, event, helper,srId);
				}
			}else{
				component.set("v.message", 'The service resource '+srId +' has already been applied on this order item.');
				document.getElementById("showErrorResource").style.display = "block";
			}
		}
    }
    	
	},
	removeServiceResource : function(component, event, helper){
		var selectedItem = event.currentTarget;
		var count = selectedItem.dataset.indexsrtoremove;
		var srWrapper = component.get("v.addedServiceResources");
		var srIdlist = component.get("v.srIdList");
		srWrapper.splice(count, 1);
		component.set("v.addedServiceResources", srWrapper);
		srIdlist.splice(count,1);
		component.set("v.srIdList", srIdlist);
		if(srWrapper.length === 0){
			document.getElementById("addedSrIdRow").style.display = "none";
		}
		document.getElementById("showErrorResource").style.display = "None";
		if(component.find("checkbox1").get("v.value")== true){
			document.getElementById("newServiceResource").style.display = "table-row";
			document.getElementById("existingServiceResource").style.display = "none";
		}
		else{
			document.getElementById("existingServiceResource").style.display = "table-row";
			document.getElementById("newServiceResource").style.display = "none";
		}
	}
})