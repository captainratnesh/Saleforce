import { LightningElement,api,wire,track} from 'lwc';
import getPaymentMethodForPayment from '@salesforce/apex/AccountDetailController_LT.getPaymentMethodForPayment';
import executePayment from '@salesforce/apex/AccountDetailController_LT.executePayment';
export default class ExecutePaymentComponent extends LightningElement {

    @api accountId;
    @track noPaymentMethod= false;
    @track paymentMethodOptions;
    @track paymentMethodMap;
    @track payment = {
        paymentMethodValue: "",
        paymentMethodType: "",
        amount:'',
        description:''
    };
    @track errorMessage;
    @track showErrorMessage; 

    connectedCallback() {
      
        getPaymentMethodForPayment({
            accountId: this.accountId
            })
            .then(result => {
                if(result){
                    this.paymentMethodOptions = result.listOfPaymentMethods;
                    this.paymentMethodMap = result.mapOfPaymentMethodEidVsType;
                    this.errorMessage = undefined;
                    if(!result.listOfPaymentMethods){
                        this.errorMessage = 'Please add payment Methods before executing payment';
                        this.showErrorMessage = true; 
                        this.noPaymentMethod = true;
                    }
                    else{
                        this.showErrorMessage = false; 
                        this.noPaymentMethod = false;
                    }
                }     
                else{
                    this.errorMessage = error;
                    this.paymentMethodOptions = undefined;
                    this.showErrorMessage = true; 
                }
            })
            .catch(error => {
                this.errorMessage = error;
                this.showErrorMessage = true; 
                this.paymentMethodOptions = undefined;
            });
    };   
    renderedCallback(){
        const style = document.createElement('style');
        style.innerText = '.slds-listbox.slds-listbox_vertical{max-height: 130px;}';
        this.template.querySelector('.first-class').appendChild(style);
    }
    paymentMethodChange(event){
        this.payment.paymentMethodValue = event.detail.value;
        this.payment.paymentMethodType = this.paymentMethodMap[event.detail.value];
        console.log('paymentMethodType:::'+ this.payment.paymentMethodType);

    };
    executePayment(){
        if(!this.payment.paymentMethodValue){
            this.errorMessage = 'Please select a Payment Method to complete the payment';
            this.showErrorMessage = true; 
        }
        else if(!this.getFieldValue('Amount')){
            this.errorMessage = 'Please enter a valid value in Amount field';
            this.showErrorMessage = true;
        }
        else{
            this.payment.amount = this.getFieldValue('Amount');
            this.payment.description = this.getFieldValue('Description');
            console.log('this.payment::::'+JSON.stringify(this.payment));
            executePayment({
                paymentData: JSON.stringify(this.payment),
                accountId: this.accountId
                })
                .then(result => {
                    if(result === 'NoError'){
                        const addPaymentMethodEvent = new CustomEvent('addPaymentMethod');
                        this.dispatchEvent(addPaymentMethodEvent);
                        this.showErrorMessage = false;
                    }     
                    else{
                        console.log('result:::'+JSON.stringify(result));
                        this.errorMessage =result;
                        this.showErrorMessage = true;
                    }
                })
                .catch(error => {
                    this.errorMessage = error;
                    this.showErrorMessage = true;
                });
            }
    };

    closeModal() {
        // to close modal set isModalOpen tarck value as false
        //this.isModalOpen = false;
        const closePaymentMethodEvent = new CustomEvent('closePaymentMethod');
        this.dispatchEvent(closePaymentMethodEvent);
    }
    getFieldValue(fieldName) {
        let thisCurentValue = this.template.querySelector(`[data-id="${fieldName}"]`).value;
        return thisCurentValue;
    }

}