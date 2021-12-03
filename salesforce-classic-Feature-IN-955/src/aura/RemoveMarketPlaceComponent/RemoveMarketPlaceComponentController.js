({
    deleteService: function(component, event, helper) {
        helper.removeMarketPlace(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {

        component.destroy();
    }
})