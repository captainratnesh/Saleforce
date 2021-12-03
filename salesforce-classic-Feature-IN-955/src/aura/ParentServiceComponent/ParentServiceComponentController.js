({
    closeModalBox : function(component, event, helper) {
        
        component.destroy();
        /*document.getElementById("parentService").style.display = "none";
        document.getElementById("parentServiceBackground").style.display = "none";*/ 
    },
    doinit : function(component, event, helper) {
        
    	component.set("v.showapplicableServices",true );
        component.set("v.relatedProductList",[] );
      /*document.getElementById("showErrorService").style.display = "none";*/
        /*var productWrapper = event.getParam("productWrapper");
        var productWrapperList = event.getParam("productWrapperList");
        component.set("v.productWrapper", productWrapper);
        component.set("v.productWrapperList",productWrapperList );*/
        component.set("v.parentProductWrapper",[] );
        var productWrapperList = component.get("v.productWrapperList");
        var productWrapper = component.get("v.productWrapper");
        var product = productWrapper.prod;
       // if(productWrapper.service == undefined && productWrapper.parentServiceEId == ' '){
        	helper.getProductList(component, event, helper, product,productWrapperList,productWrapper);
      //  }
       /* else{
        }*/
    },
    onRadio : function(component, event, helper) {
        var src = event.getSource();
        var getWhichBtn = src.get("v.label");
        var text = src.get("v.text");
        var value=src.get("v.value");
        component.set("v.selectedProductIndex" , text);
    },
    saveService : function(component, event, helper) {
         var index = component.get("v.selectedProductIndex");
         if(index == undefined){
            /* document.getElementById("parentService").style.display = "none";
             document.getElementById("parentServiceBackground").style.display = "none";*/
             component.destroy();
         }else{
            
            var selectedParent = component.get("v.parentProductWrapper["+index+"]");
            var childProduct  = component.get("v.productWrapper");
            childProduct.service = selectedParent.prod.Id;
            childProduct.serviceName = selectedParent.prod.Name;
            if(childProduct.service == undefined && selectedParent.parentServiceEId != ' '){
                childProduct.parentServiceEId = selectedParent.parentServiceEId;
            }
            else {
                childProduct.parentServiceEId = ' ';
            }
             /*if(null != selectedParent.OLineItem.description && '' != selectedParent.OLineItem.description){
                 childProduct.serviceName = selectedParent.OLineItem.description;
             }
            else if(null != selectedParent.prod.Short_Desc__c && '' != selectedParent.prod.Short_Desc__c){
                 childProduct.serviceName = selectedParent.prod.Short_Desc__c;
             }
            else{
                childProduct.serviceName = selectedParent.prod.Short_Desc__c;
            }*/
            var appEvent = $A.get("e.c:SetParentEvent");
            appEvent.setParams({"productWrapper": childProduct});
            appEvent.fire();
            component.destroy();
            /*document.getElementById("parentService").style.display = "none";
            document.getElementById("parentServiceBackground").style.display = "none";*/
         }
    }
})