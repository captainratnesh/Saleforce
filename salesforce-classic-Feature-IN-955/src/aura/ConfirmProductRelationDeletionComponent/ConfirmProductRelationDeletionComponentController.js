({
    deleteproductRelation: function(component, event, helper) {
        helper.removeproductRelation(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    }
})