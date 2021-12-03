({
    deleteService: function(component, event, helper) {
        helper.removeAgreementRelation(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {

        component.destroy();
    }
})