({
    closeModalBox: function(component, event, helper) {

        component.destroy();
    },
    selectAgreement: function(component, event, helper) {
        var proWrap = component.get("v.productWrapper");
        var agreementAvailable = component.get("v.agreement");
        var selectedAgreement = component.get("v.selectedAgreementId");
        console.log('selectedAgreement::::::'+selectedAgreement);
        var agreementWrapList = component.get("v.agreementWrapper").agreementList;
        var endAction = proWrap.agreementEndAction;
        var period = proWrap.agreementPeriod;
        var periodType = component.get("v.agrementPer");
        var nextAgreement = proWrap.nextAgreementId;
        var nextAgreementAction = proWrap.nextAgreementEndAction;
        if(selectedAgreement != undefined && selectedAgreement.trim() != ''){
            for(var item in agreementWrapList){
                console.log('item::::::'+item);
                if(agreementWrapList[item].value == selectedAgreement){
                    proWrap.agreementName = agreementWrapList[item].label;  
                    proWrap.agreementPeriodType = periodType;
                }  
                if(nextAgreement != undefined && nextAgreement.trim() != '' && agreementWrapList[item].value == nextAgreement){
                    proWrap.nextAgreementName = agreementWrapList[item].label;  
                }           
            }
        }
        else{
             proWrap.agreementName = '';  
             proWrap.agreementPeriodType = '';
             proWrap.overrideAgreementEndDate = '';
            
        }
        if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && (endAction === undefined || endAction == null || endAction.trim() === '')){
        	component.set("v.message", 'Error : Please select renew action for the agreement.');
            document.getElementById("showErrorAddAgreement").style.display = "block";
        }
        else if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && (period === undefined || period == null || period === '')){
        	component.set("v.message", 'Error : Please enter the value for period.');
            document.getElementById("showErrorAddAgreement").style.display = "block";
        }
        else if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && (period != undefined && period != null && period != '') && (isNaN(period) || period.toString().indexOf(".") != -1)){
			component.set("v.message", 'Error : Please enter a valid number for agreement period.');
			document.getElementById("showErrorAddAgreement").style.display = "block";
        }
        else if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && (period != undefined && period != null && period != '') && (period == 0 || period < 0)){
        	component.set("v.message", 'Error : Agreement period must be greater than zero.');
    		document.getElementById("showErrorAddAgreement").style.display = "block";
        }
        else if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && endAction =='CHANGE_AGREEMENT' && (nextAgreement === undefined || nextAgreement == null || nextAgreement.trim() === '')){
        	component.set("v.message", 'Error : Please select next agreement for this agreement.');
            document.getElementById("showErrorAddAgreement").style.display = "block";
        }

        else if(agreementAvailable && selectedAgreement != undefined && selectedAgreement.trim() != '' && endAction =='CHANGE_AGREEMENT' && (nextAgreementAction === undefined || nextAgreementAction == null || nextAgreementAction.trim() === '')){
        	component.set("v.message", 'Error : Please select next agreement renewal action.');
            document.getElementById("showErrorAddAgreement").style.display = "block";
        }
        
        else{
        	var appEvent = $A.get("e.c:SelectedAgreementReturnEvent");
	        appEvent.setParams({
	            "productWrapper": proWrap
	        });
	        appEvent.fire();
	        component.destroy();
        }
    },
    doInit: function(component, event, helper) {
        var productWrapper = component.get("v.productWrapper");
        component.set("v.productWrapper", productWrapper);
        if (productWrapper.agreementId != '') {
            var selectedAgreementId = productWrapper.agreementId;
            component.set("v.selectedAgreementId", selectedAgreementId);
            var selectedAgreementEndAction = productWrapper.agreementEndAction;
            component.set("v.selectedAgreementEndAction", selectedAgreementEndAction);
            component.set("v.nextAgreementId", productWrapper.nextAgreementId);
            component.set("v.nextAgreementEndAction", productWrapper.nextAgreementEndAction);
            var deactivationDate = productWrapper.overrideAgreementEndDate;
            if (deactivationDate == '' || deactivationDate == undefined) {
                component.set("v.deactivationDateChecked", false);
            } else {
                component.set("v.deactivationDateChecked", true);
            }
        }
        helper.addAgreement(component, event, helper, productWrapper.prod.Id, productWrapper.pricebookNames[1]);
    },
    
    handleChanged: function(cmp, evt, helper) {
    	document.getElementById("showErrorAddAgreement").style.display = "none";
        var checkbox = evt.getSource();
        if (checkbox.get("v.value")) {
            document.getElementById("DeactivationDateId").style.display = "table-row";
        } else {
            document.getElementById("DeactivationDateId").style.display = "none";
            var proWrap = cmp.get("v.productWrapper");
            proWrap.overrideAgreementEndDate = undefined;
            cmp.set("v.productWrapper", proWrap);
            cmp.set("v.deactivationDateChecked", false);
        }

    },
    handleChangeInAgreementRenewAction: function(cmp, evt, helper) {
    	document.getElementById("showErrorAddAgreement").style.display = "none";
        var changedAgreementEndAction = evt.getSource().get("v.value");
        var proWrap = cmp.get("v.productWrapper");
        if(changedAgreementEndAction != 'CHANGE_AGREEMENT' || changedAgreementEndAction != 'RENEW_AGREEMENT'){
            proWrap.renewalPrice = 'Service Price';
        }
        else{
            proWrap.renewalPrice = '';
        }
        if(changedAgreementEndAction != 'CHANGE_AGREEMENT'){
            cmp.set("v.nextAgreementEndAction", '');
            cmp.set("v.nextAgreementId", '');
            proWrap.nextAgreementId = '';
            proWrap.nextAgreementEndAction = '';
            cmp.set("v.productWrapper", proWrap);
        }
        cmp.set("v.selectedAgreementEndAction", changedAgreementEndAction);
    },
    onAgreementSelect: function(component, event, helper) {
    	document.getElementById("showErrorAddAgreement").style.display = "none";
        var agreementValue = event.getSource().get("v.value");
        component.set("v.selectedAgreementId", agreementValue);
        var proWrapper = component.get("v.agreementWrapper");
        var proWrap = component.get("v.productWrapper");
        if (agreementValue != ' ') {
            var recPer = proWrapper.mapOfAgreementPeriod[agreementValue];
            proWrap.agreementPeriod = recPer;
            var periodType = proWrapper.mapOfAgreementPeriodType[agreementValue];
            component.set("v.productWrapper",proWrap);
            component.set("v.agrementPer", periodType);
            var divsToHide = document.getElementsByClassName("showAgreement"); //divsToHide is an array
            for (var i = 0; i < divsToHide.length; i++) {
                divsToHide[i].style.display = "table-row"; // depending on what you're doing
            }
        } else {
            var divsToHide = document.getElementsByClassName("showAgreement");
            for (var i = 0; i < divsToHide.length; i++) {
                divsToHide[i].style.display = "none";
            }
            document.getElementById("DeactivationDateId").style.display = "none";
            component.set("v.deactivationDateChecked", false);
            component.set("v.selectedAgreementEndAction", '');
            component.set("v.nextAgreementEndAction", '');
            component.set("v.nextAgreementId", '');
            // Reset the Agreement wrapper values
            proWrap.agreementId = '';
            proWrap.agreementEndAction = '';
            proWrap.agreementPeriod = '';
            proWrap.nextAgreementId = '';
            proWrap.nextAgreementEndAction = '';
            component.set("v.productWrapper", proWrap);
        }
    },
    onInputChange: function(component, event, helper) {
        var period = component.get("v.productWrapper.agreementPeriod");
        var periodType = component.get("v.agrementPer");
        if(period == 1){
            if(periodType === 'Days' || periodType === 'Months' || periodType === 'Years'){
                component.set("v.agrementPer", periodType.replace('s',''));
            }
        }
        else{
            if(periodType === 'Day' || periodType === 'Month' || periodType === 'Year'){
                component.set("v.agrementPer", periodType.concat('s'));
            }
        }
    },
    handleChangeInNextAgreementRenewAction: function(cmp, evt, helper) {
    	document.getElementById("showErrorAddAgreement").style.display = "none";
        var nextAgreementEndAction = evt.getSource().get("v.value");
        cmp.set("v.nextAgreementEndAction", nextAgreementEndAction);
        var proWrap = cmp.get("v.productWrapper");
        if(nextAgreementEndAction == 'RENEW_AGREEMENT'){
            proWrap.nextRenewalPrice = 'Service Price';
        }
        else{
            proWrap.nextRenewalPrice = '';
        }
        cmp.set("v.productWrapper",proWrap);
    },
    handleChangeInNextAgreement: function(cmp, evt, helper) {
        document.getElementById("showErrorAddAgreement").style.display = "none";
        var nextAgreementId = evt.getSource().get("v.value");
        cmp.set("v.nextAgreementId", nextAgreementId);
    }
})