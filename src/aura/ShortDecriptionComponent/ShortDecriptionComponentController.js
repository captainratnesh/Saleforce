({
     
    closeModalBox : function(component, event, helper) {
    	component.destroy();
    },
    
    doInit : function(component, event, helper) {
    },
    editDescription : function(component, event, helper) {
          var productWrapper = component.get("v.proWrap");
          var Description = productWrapper.oLineItem.Description;
          if(Description == undefined){
             component.set("v.message", 'Please enter the Description.');
             document.getElementById("showErrorDescription").style.display = "block";
         }else{
             var count =  component.get("v.count");
             var proWrap = component.get("v.proWrap");
             var appEvent = $A.get("e.c:EditShortDescriptionReturnEvent");
             appEvent.setParams({"productWrapper": proWrap});
             appEvent.fire();
             component.destroy();
         } 
         
    }
})