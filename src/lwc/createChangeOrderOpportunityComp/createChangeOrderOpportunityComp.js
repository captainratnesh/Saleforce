import { LightningElement,api,wire,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import CreatecreateOrderWrapper from "@salesforce/apex/AccountDetailController_LT.getCreateChangeServiceWrapper";
import CreateChangeOrder from "@salesforce/apex/AccountDetailController_LT.createChangeOrderInGTV";
import getIdentifierList from "@salesforce/apex/AccountDetailController_LT.getIdentifierList";
import createOppLineItem from "@salesforce/apex/TractOppProduct_LT.createOppLineItem";
import { loadStyle } from "lightning/platformResourceLoader";
import globalStyles from "@salesforce/resourceUrl/global";


export default class CreateChangeOrderOpportunityComp extends NavigationMixin(LightningElement) {
    @track errorMessage = '';
    @track showErrorMessage = false;
    @api currencyType;
    @api currentServiceId;
    @api objectApiName;
    @api oppRecordId;
    @track createOrderWrapper={

    };
    recurrencePriceList;
    oneTimePriceList;
    agreementWrapper;
    @track isLoading = false;
    @track isModalOpen = true;
    @track showHideSections = true;
    @track nextSection = false;
    @track orderConfirmation = false;
    @track isConfigure = false;
    @track showAgreement = true;
    @track showAccount = false;
    @track showOpportunity = false;
    value = 'Agreement';
    showAgreementMessage = false;
    isPeriod = true;
    isRenewal = true;
    isOverRideDate= false;
    showAgreementDetails = false;
    showRenewalPricing = false;
    agreementConfigure= false;
    isConfigureDataTrue = false ;
    isAddAgreement = true;
    displayAgreement = false;
    configErrorMessage = false;
    isRendered= false;
    productDetails;
   
   
    agreementId;
    agreementName;
    agreementPeriod;
    agreementEndAction;
    agreementPeriodType;
    renewalPrice = '';
    overrideAgreementEndDate;
    preserveAgreementPrice;
    connectedCallback() {
        
        Promise.all([
            loadStyle(this, globalStyles)
        ])

        this.isLoading = true;
        CreatecreateOrderWrapper({
            currentServiceId: this.currentServiceId,
            currencyType: this.currencyType
        })
        .then(result=>{
            if(result){
                console.log('In Result');
                 this.createOrderWrapper = result;
                 console.log('createOrderWrapper'+JSON.stringify(this.createOrderWrapper));
                 this.recurrencePriceList = this.createOrderWrapper.mapOfProductIdVsRecurrencePriceList[this.createOrderWrapper.currentProductId];
                 console.log('In Result2');
                 this.oneTimePriceList = this.createOrderWrapper.mapOfProductIdVsOneTimePriceList[this.createOrderWrapper.currentProductId];
                 this.agreementWrapper = this.createOrderWrapper.mapOfProductIdVsAgreementWrapper[this.createOrderWrapper.currentProductId];
                 this.productDetails = this.createOrderWrapper.mapofProductIdVsProduct[this.createOrderWrapper.currentProductId];
             
                 if(this.agreementWrapper.agreementList.length > 0){
                    this.showAgreement = true;
                    this.showAgreementMessage= false;
                  
                    console.log('this.createOrderWrapper.agreementId::::::'+this.createOrderWrapper.agreementId);
                    if(this.createOrderWrapper.agreementId){
                        this.showAgreementDetails = true;
                        this.agreementId = this.createOrderWrapper.agreementId
                        this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.createOrderWrapper.agreementId];
                        this.agreementEndAction = this.createOrderWrapper.agreementEndAction;
                        this.overrideAgreementEndDate = this.createOrderWrapper.overrideAgreementEndDate;
                        this.agreementName = this.createOrderWrapper.agreementName;
                        this.agreementPeriod =  this.createOrderWrapper.agreementPeriod;
                        this.preserveAgreementPrice = this.createOrderWrapper.preserveAgreementPrice;
                        this.renewalPrice = this.createOrderWrapper.renewalPrice;
                        if(this.createOrderWrapper.agreementEndAction == 'RENEW_AGREEMENT'){
                            this.showRenewalPricing = true;
                        }
                        if(this.createOrderWrapper.overrideAgreementEndDate !=''){
                            this.isOverRideDate = true;
                        }
                    }
                }
                this.isLoading = false;
            }
        })
        .catch(error => {
            console.log('In Error');
            console.log('In Error2'+error);
            this.errorMessage = error;
            this.showErrorMessage = true; 
            this.isLoading = false;
        });
    };  

    handleProductChange(event){
        this.createOrderWrapper.currentProductId = event.detail.value;
        this.createOrderWrapper.agreementId = undefined;
        this.createOrderWrapper.agreementName = undefined;
        this.createOrderWrapper.agreementPeriod = undefined;
        this.createOrderWrapper.agreementEndAction = undefined;
        this.createOrderWrapper.preserveAgreementPrice = undefined;
        this.createOrderWrapper.renewalPrice = undefined;
        this.createOrderWrapper.overrideAgreementEndDate = undefined;
        this.createOrderWrapper.agreementPeriodType = undefined;
        this.agreementId = undefined;
        this.agreementName = undefined;
        this.agreementPeriod = undefined;
        this.agreementEndAction = undefined;
        this.preserveAgreementPrice = undefined;
        this.renewalPrice = undefined;
        this.overrideAgreementEndDate = undefined;
        this.agreementPeriodType = undefined;
        this.isAddAgreement = true;
        this.isConfigureDataTrue = false;
        this.displayAgreement = false;
        
        for( var key in this.createOrderWrapper.compatibleProductList){
            if(this.createOrderWrapper.compatibleProductList[key]["value"] == event.detail.value){
                this.createOrderWrapper.currentProductName = this.createOrderWrapper.compatibleProductList[key]["label"];
                break;
            }
        }        
        this.recurrencePriceList = this.createOrderWrapper.mapOfProductIdVsRecurrencePriceList[this.createOrderWrapper.currentProductId];
        this.oneTimePriceList = this.createOrderWrapper.mapOfProductIdVsOneTimePriceList[this.createOrderWrapper.currentProductId];
        this.agreementWrapper = this.createOrderWrapper.mapOfProductIdVsAgreementWrapper[this.createOrderWrapper.currentProductId];
        this.productDetails = this.createOrderWrapper.mapofProductIdVsProduct[this.createOrderWrapper.currentProductId];
        
        if(this.agreementWrapper.agreementList.length > 0){
            this.showAgreement = true;
            this.showAgreementMessage = false;
            this.agreementId = this.agreementWrapper.agreementList[0]["value"];
            this.agreementName = this.agreementWrapper.agreementList[0]["label"];
            if(this.agreementId != '' && this.agreementId != undefined  && this.agreementId.trim() != ''){
                this.agreementPeriod = this.agreementWrapper.mapOfAgreementPeriod[this.agreementId];
                this.agreementEndAction = this.agreementWrapper.mapOfAgreementIdVsAgreementEndAction[this.agreementId];
                this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.agreementId];
                if(this.agreementEndAction == 'RENEW_AGREEMENT'){
                    this.renewalPrice = 'Product Price';
                    this.showRenewalPricing = true;
                }
                else{
                    this.renewalPrice = '';
                    this.showRenewalPricing = false;
                }
                this.showAgreementDetails = true;
            }
            else{
                this.showAgreementDetails = false;
            }
            
        }
        else{
            this.showAgreement = false;
            this.showAgreementDetails = false;
        }
        console.log('We are here');
        if(this.recurrencePriceList){
            this.createOrderWrapper.recurringpriceId = this.recurrencePriceList[0]["value"];
            this.createOrderWrapper.recurringprice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[this.createOrderWrapper.recurringpriceId][0].price;
            this.createOrderWrapper.totalPrice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[this.createOrderWrapper.recurringpriceId][0].price;
        }
        if(this.oneTimePriceList){
            this.createOrderWrapper.oneTimePriceId = this.oneTimePriceList[0]["value"];
            this.createOrderWrapper.oneTimePrice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[this.createOrderWrapper.oneTimePriceId][0].price;
            this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
        }
        else{
            this.createOrderWrapper.oneTimePriceId = undefined;
            this.createOrderWrapper.oneTimePrice = undefined;
        }
        console.log('We are here 2');
    }

    handleAgreementChange(event){
        console.log('event.detail.value'+event.detail.value);
        this.agreementId = event.detail.value;
        if(this.agreementId && this.agreementId != undefined && this.agreementId.trim() != ''){
            console.log(' this.createOrderWrapper.agreementId1::;'+ this.createOrderWrapper.agreementId);
            for( var key in this.agreementWrapper.agreementList){
                if(this.agreementWrapper.agreementList[key]["value"] == event.detail.value){
                    this.agreementName = this.agreementWrapper.agreementList[key]["label"];
                    break;
                }
            }  
            this.agreementPeriod = this.agreementWrapper.mapOfAgreementPeriod[this.agreementId];
            this.agreementEndAction = this.agreementWrapper.mapOfAgreementIdVsAgreementEndAction[this.agreementId];
            this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.agreementId];
            if(this.agreementEndAction == 'RENEW_AGREEMENT'){
                this.renewalPrice = 'Product Price';
                this.showRenewalPricing = true;
            }
            else{
                this.renewalPrice = '';
                this.showRenewalPricing = false;
            }
            this.showAgreementDetails = true;
        }
        
        else{
            console.log(' this.createOrderWrapper.agreementId2::;'+ this.createOrderWrapper.agreementId);
            this.showAgreementDetails = false;
            this.agreementPeriod = undefined;
            this.renewalPrice = undefined;
            this.agreementEndAction = undefined;
            this.agreementName = undefined;
            this.overrideAgreementEndDate = undefined;
        }
        
    }

    handleRenewalAction(event){
        console.log('event.detail.value'+event.detail.value);
        if(event.detail.value == 'RENEW_AGREEMENT'){
            this.showRenewalPricing = true;
            this.agreementEndAction = event.detail.value;
            this.renewalPrice = 'Product Price';
            
        }
        else{
            this.showRenewalPricing = false;
            this.agreementEndAction = event.detail.value;
            this.renewalPrice = '';
        }
        
    }

    handleRecurringPriceChange(event){
        this.createOrderWrapper.recurringpriceId = event.detail.value;
        this.createOrderWrapper.recurringprice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[this.createOrderWrapper.recurringpriceId][0].price;
        if(this.createOrderWrapper.oneTimePrice){
            this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
        }
        else{
            this.createOrderWrapper.totalPrice = this.createOrderWrapper.recurringprice;
        }
    }

    handleOneTimePriceChange(event){
        this.createOrderWrapper.oneTimePriceId = event.detail.value;
        this.createOrderWrapper.oneTimePrice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[createOrderWrapper.oneTimePriceId][0].price;
        this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
    }

    handleRecurringPriceOverrirde(event){
        this.createOrderWrapper.recurringprice = event.target.value;
        if(this.createOrderWrapper.oneTimePrice){
            this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
        }
        else{
            this.createOrderWrapper.totalPrice = this.createOrderWrapper.recurringprice;
        }
    }

    handleOneTimePriceOverrirde(event){
        this.createOrderWrapper.oneTimePrice = event.target.value;
        this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
    }

    handleInputDate(event){
        this.createOrderWrapper.OrderDate = event.target.value;
    }

    handleInputEmail(event){
        this.createOrderWrapper.emailReciept = event.target.checked;
    }

    nextPage(){
        this.nextSection= false;
        this.showHideSections = false;
        this.orderConfirmation = false;
        this.configErrorMessage = false;
        this.isConfigureDataTrue = false;
        this.isServiceResourceDataTrue = false;
    }
    back(){
        this.nextSection = false;
        this.showHideSections = true;
        this.orderConfirmation = false;
        this.configErrorMessage = false;
        
    }
    CancelOrder(){
        this.orderConfirmation = true;
        this.showHideSections = false;
        this.nextSection = false;
    }
    backToPrevious(){
        this.nextSection = true;
        this.showHideSections = false;
        this.orderConfirmation = false;
        this.configErrorMessage = false;
    }
    CoonfirmCancel(){
        const closeCreateOrderEvent = new CustomEvent('submitsuccess');
        this.dispatchEvent(closeCreateOrderEvent);
        this.isModalOpen = false;
      
    }
    configureProduct(){
        this.isConfigure = true;
        this.orderConfirmation = false;
        this.showHideSections = false;
        this.nextSection = false;
        this.showAgreementMessage = false;
        if(this.agreementWrapper.agreementList.length == 0 || this.agreementWrapper.agreementList.length < 0){
            this.showAgreementMessage = true;
            this.showAgreement = false;
            this.agreementId = this.createOrderWrapper.agreementId
            this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.agreementId];
            this.agreementEndAction = this.createOrderWrapper.agreementEndAction;
            this.overrideAgreementEndDate = this.createOrderWrapper.overrideAgreementEndDate;
            this.agreementName = this.createOrderWrapper.agreementName;
            this.agreementPeriod =  this.createOrderWrapper.agreementPeriod;
            this.preserveAgreementPrice = this.createOrderWrapper.preserveAgreementPrice;
            this.renewalPrice = this.createOrderWrapper.renewalPrice;
            if(this.createOrderWrapper.agreementEndAction == 'RENEW_AGREEMENT'){
                this.showRenewalPricing = true;
            }
            else{
                this.showRenewalPricing = false; 
            }
            if(this.createOrderWrapper.overrideAgreementEndDate !=''){
                this.isOverRideDate = true;
            }
        }
        else{
            this.showAgreement = true;
            this.showAgreementMessage = false;
        }
    }
    get options() {
        return [
            { label: 'Agreement', value: 'Agreement' },
        ];
    }
    
    handleRadioConfigureChange(event){
        const selectedOtion = event.detail.value;
        if(selectedOtion==='Agreement'){
            if(this.agreementWrapper.agreementList.length > 0){
                this.showAgreement = true;
                 this.showServiceResource = false;
                 this.showAgreementMessage = false;
            }
            if(this.agreementWrapper.agreementList.length == 0 || this.agreementWrapper.agreementList.length < 0){
            this.showAgreement = false;
            }
        }
    }


    handleRenewalPricingChange(event){
        console.log('event.detail.value:::::'+event.detail.value);
        this.renewalPrice = event.detail.value;
    }
    
    CancelConfigure(){
        this.isConfigure = false;
        this.orderConfirmation = false;
        this.showHideSections = true;
        this.nextSection = false;
        this.isConfigureDataTrue = false;
        this.configErrorMessage = false;
        this.agreementId = this.createOrderWrapper.agreementId
        if(this.agreementId){
            this.isConfigureDataTrue = true;
            this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.agreementId];
            this.agreementEndAction = this.createOrderWrapper.agreementEndAction;
            this.overrideAgreementEndDate = this.createOrderWrapper.overrideAgreementEndDate;
            this.agreementName = this.createOrderWrapper.agreementName;
            this.agreementPeriod =  this.createOrderWrapper.agreementPeriod;
            this.preserveAgreementPrice = this.createOrderWrapper.preserveAgreementPrice;
            this.renewalPrice = this.createOrderWrapper.renewalPrice;
            if(this.createOrderWrapper.agreementEndAction == 'RENEW_AGREEMENT'){
                this.showRenewalPricing = true;
            }
            else{
                this.showRenewalPricing = false;
            }
            if(this.createOrderWrapper.overrideAgreementEndDate !=''){
                this.isOverRideDate = true;
            }
        }

    }
    handleOverRideDate(event){
        this.overrideAgreementEndDate =  event.target.value;
    }
    handleOverRideCheckbox(event){
        this.isOverRideDate = event.target.checked;
    }
    HandlePeriodChange(event){
        this.agreementPeriod = event.detail.value;
    }
    ConfirmConfigure(){
        this.isConfigure = false;
        this.orderConfirmation = false;
        this.showHideSections = true;
        this.nextSection = false;
        this.isAddAgreement = false;
        if(this.agreementId && this.agreementId != undefined && this.agreementId.trim() != ''){
            this.isConfigureDataTrue = true;
            this.displayAgreement = true;
            this.createOrderWrapper.agreementId= this.agreementId;
            this.createOrderWrapper.agreementPeriodType = this.agreementPeriodType;
            this.createOrderWrapper.agreementEndAction = this.agreementEndAction;
            this.createOrderWrapper.overrideAgreementEndDate = this.overrideAgreementEndDate;
            this.createOrderWrapper.agreementName = this.agreementName;
            this.createOrderWrapper.agreementPeriod =  this.agreementPeriod;
            this.createOrderWrapper.preserveAgreementPrice = this.preserveAgreementPrice;
            this.createOrderWrapper.renewalPrice = this.renewalPrice;
        }
        else{
            this.isAddAgreement = true;
            this.isConfigureDataTrue = false;
            this.displayAgreement = false;
            this.agreementId = undefined;
            this.agreementName = undefined;
            this.agreementPeriod = undefined;
            this.agreementEndAction = undefined;
            this.preserveAgreementPrice = undefined;
            this.renewalPrice = undefined;
            this.overrideAgreementEndDate = undefined;
            this.agreementPeriodType = undefined;
        }
    }


    saveCreateChangeOrder(){
        if(this.productDetails.Requires_Agreement__c && this.agreementId){
            this.errorMessage = 'Please configure the agreement';
            this.showErrorMessage = true; 
        }
        else{
            this.isLoading = true;
            createOppLineItem({
                changeOrderWrapper: JSON.stringify(this.createOrderWrapper),
                opportunityId: this.oppRecordId
            })
            .then(result=>{
                console.log('result::'+JSON.stringify(result));
                this.dispatchEvent(new CustomEvent("closeModal", {
                    bubbles : true,
                    detail: this.oppRecordId
               }));
            })
            .catch(error => {
                console.log('In Error');
                if (typeof error.body.message === 'string') {
                    this.errorMessage = error.body.message;
                }
                else if (Array.isArray(error.body)) {
                    this.errorMessage = error.body.map(e => e.message).join(', ');
                }
                this.showErrorMessage = true; 
                this.isLoading = false;
                
            });
        }
        

    };

  
    
    openModal() {
        this.isModalOpen = true;
    }

   closeModal(event) {
    const closeCreateOrderEvent = new CustomEvent('submitsuccess');
    this.dispatchEvent(closeCreateOrderEvent);
    this.isModalOpen = false;
       
    }

    redirectToOpportunity(event){
        this.dispatchEvent(new CustomEvent("closeModal", {
             bubbles : true,
             detail: this.oppRecordId
        }));
    }
  
}