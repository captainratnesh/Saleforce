({
    doInit : function(component, event, helper) {
        console.log('New COmponent');
        var currentAgrList = component.get("v.currentAgreementList");
        var m = new Map();
        for(var i in currentAgrList){  
            m.set(currentAgrList[i].eid,currentAgrList[i].name);
        }
        
        helper.ListOfAgreement(component, event, helper,m) ;
    },
    addAgreement : function(component, event, helper) {
        console.log('New COmponent');
        var agreeList = component.get("v.agreementList");
        var arrayList = [];
        for(var i = 0; i < agreeList.length;i++){
            if(agreeList[i].isSelected){
                arrayList.push(agreeList[i]);
            }
        }
        console.log('arrayList::::'+JSON.stringify(arrayList));
        helper.addSelectedAgreements(component, event, helper,arrayList) ;
    },
    nextProduct : function(component, event, helper) {
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var agreementList = component.get("v.agreementList");        
        var agreementListMap = component.get("v.agreementListMap");       
        agreementListMap[currentPage] = agreementList;
        currentPage++;
        component.set("v.agreementList", agreementListMap[currentPage]);
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
        var agreementList = component.get("v.agreementList");
        var agreementListMap = component.get("v.agreementListMap");        
        agreementListMap[currentPage] = agreementList;
        currentPage--; 
        component.set("v.agreementList", agreementListMap[currentPage]);
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
	    var agreementList = component.get("v.agreementList");
	    var agreementListMap = component.get("v.agreementListMap");	    
	    agreementListMap[currentPage] = agreementList;
	    component.set("v.agreementList", agreementListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);
	},   
	firstProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var agreementList = component.get("v.agreementList");
	    var agreementListMap = component.get("v.agreementListMap");	    
	    agreementListMap[currentPage] = agreementList;
	    component.set("v.agreementList", agreementListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);
	},

    closeModalBox: function(component, event, helper) {

        component.destroy();
    }
})