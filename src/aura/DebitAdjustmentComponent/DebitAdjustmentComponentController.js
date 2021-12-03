({
    doInit : function(component, event, helper) {
         var today = new Date(); 
         component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        helper.getDebitAdjustmentReson(component, event, helper); 
    },
	closeModalBox : function(component, event, helper) {
        component.destroy();
    }, 
    saveDabitAdjustmentCtr : function(component, event, helper) {
        console.log('SaveDebitAdjustment');
        document.getElementById("showErrorDebit").style.display = "none";        
        var reasonEid =  component.find("dabitReasonEid");
        var reasonEidValue =  reasonEid.get("v.value");        
        var ammount =  component.find("DebitAmmount");
        var ammountValue =  ammount.get("v.value");        
        var description =  component.find("DebitDescription");
        var descriptionValue =  description.get("v.value");        
        var effectiveDate =  component.find("effectiveDate");
        var effectiveDateValue =  effectiveDate.get("v.value");        
        
       var errorOccured = false;
        
        if (reasonEidValue == undefined || reasonEidValue == "undefined" || reasonEidValue == "" ){
            errorOccured = true;
            reasonEid.set("v.errors", [{message:"Reason is required."}]);
        }
        else{
            reasonEid.set("v.errors", [{message:null}]);
        }
        
        if(ammountValue == undefined || ammountValue == "undefined" || ammountValue == "" ){
            errorOccured = true;
            ammount.set("v.errors", [{message:"Amount should not be blank."}]);
        }
        else if (ammountValue == "0.0" || ammountValue == "0"){
                errorOccured = true;
                ammount.set("v.errors", [{message:"Amount must be greater than zero."}]);
        }
        else if(isNaN(ammountValue)){
            errorOccured = true;
            ammount.set("v.errors", [{message:"Please enter a valid amount."}]);
        }
            else{
                ammount.set("v.errors", [{message:null}]);
            }
        if (descriptionValue == undefined || descriptionValue == "undefined" || descriptionValue == "" ){
            errorOccured = true;
            description.set("v.errors", [{message:"Description is required."}]);
        }else{
            description.set("v.errors", [{message:null}]);
        }
        if (effectiveDateValue == undefined || effectiveDateValue == "undefined" || effectiveDateValue == "" ){
            errorOccured = true;
            effectiveDate.set("v.errors", [{message:"Effective Date is required."}]);
        }else{
            effectiveDate.set("v.errors", [{message:null}]);
        }
        if(!errorOccured){
            helper.saveDabitAdjustment(component,reasonEidValue,ammountValue,descriptionValue,effectiveDateValue);
        }
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})