import { LightningElement,track,api } from 'lwc';
import CreatecreateOrderWrapper from "@salesforce/apex/AccountDetailController_LT.getCreateChangeServiceWrapper";
import CreateChangeOrder from "@salesforce/apex/AccountDetailController_LT.createChangeOrderInGTV";
import getIdentifierList from "@salesforce/apex/AccountDetailController_LT.getIdentifierList";
import createOppLineItem from "@salesforce/apex/TractOppProduct_LT.createOppLineItem";

export default class CreateChangeOrderComp extends LightningElement {
    
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
   // @track showServiceResource = false;
   // showShortDescription = false;
  //  showAddress = false;
  //  showDiscountCode = false;
    value = 'Agreement';
    //showAgreement = false;
    showAgreementMessage = false;
   // showServiceResourceMessage = false;
    isPeriod = true;
    isRenewal = true;
    isOverRideDate= false;
    showAgreementDetails = false;
    showRenewalPricing = false;
    agreementConfigure= false;
    isConfigureDataTrue = true ;
  //  isServiceResourceDataTrue = true;
    configErrorMessage = false;
    isRendered= false;
    productDetails;
   // identifierList;
   // selectedServiceName;
   // SelectedServiceList=[];
   // totalResourceNumber = 0;
  /*  country={
     state: ''
    };*/
  //  usselected= false;
    /*-----------*/

  /*   fieldLabel;
     disabled = false;
    @track openDropDown = false;
    @track inputValue = "";
     placeholder = 'Start typing a service name.';
     @api options;
    @track optionsToDisplay;
     isvalue = "";
    @track label = "";
    delaytimeout;
    identifierToDisplay;*/

    /*-----------*/

   /* constructor() {
        super();
    }*/
    agreementId;
    agreementName;
    agreementPeriod;
    agreementEndAction;
    agreementPeriodType;
    renewalPrice;
    overrideAgreementEndDate;
    preserveAgreementPrice;
    connectedCallback() {
        if(this.objectApiName == 'Account'){
            this.showAccount = true;
            this.showOpportunity = false;
        }else
        if(this.objectApiName == 'Opportunity'){
            this.showOpportunity = true;
            this.showAccount = false;
        }
        
    //    this.setOptionsAndValues();
        this.isLoading = true;
        CreatecreateOrderWrapper({
            currentServiceId: this.currentServiceId,
            currencyType: this.currencyType
        })
        .then(result=>{
            if(result){
                 this.createOrderWrapper = result;
                 console.log('createOrderWrapper'+JSON.stringify(this.createOrderWrapper));
                 this.recurrencePriceList = this.createOrderWrapper.mapOfProductIdVsRecurrencePriceList[this.createOrderWrapper.currentProductId];
                 this.oneTimePriceList = this.createOrderWrapper.mapOfProductIdVsOneTimePriceList[this.createOrderWrapper.currentProductId];
                 this.agreementWrapper = this.createOrderWrapper.mapOfProductIdVsAgreementWrapper[this.createOrderWrapper.currentProductId];
                 this.productDetails = this.createOrderWrapper.mapofProductIdVsProduct[this.createOrderWrapper.currentProductId];
                 console.log('In Result2');
               //  this.SelectedServiceList = this.createOrderWrapper.srIdentifierList;
               /*  if(this.productDetails.TRACT3__minServiceResources__c >= 1){
                    this.showServiceResource = true;
                }*/
               //  console.log('this.productDetails:::::'+JSON.stringify(this.productDetails));
                 if(this.agreementWrapper.agreementList.length > 0){
                    this.showAgreement = true;
                    this.showAgreementMessage= false;
                   // this.showShortDescription = false;
                   // this.showAddress = false;
                   // this.showDiscountCode = false;
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
                        //this.createOrderWrapper.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.createOrderWrapper.agreementId];
                        if(this.createOrderWrapper.agreementEndAction == 'RENEW_AGREEMENT'){
                            this.showRenewalPricing = true;
                        }
                        if(this.createOrderWrapper.overrideAgreementEndDate !=''){
                            this.isOverRideDate = true;
                        }
                    }
                }
                this.isLoading = false;
                //this.errorMessage = undefined;
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
        /*if(this.productDetails.TRACT3__minServiceResources__c >= 1){
            this.showServiceResource = true;
        }
        if(this.productDetails.Short_Desc__c){
            this.createOrderWrapper.shortDescription = this.productDetails.Short_Desc__c;
        }
        else{
            this.createOrderWrapper.shortDescription = this.productDetails.Name;
        }*/

     //   this.SelectedServiceList = [];
      //  console.log('this.productDetails:::::'+JSON.stringify(this.productDetails));
        if(this.agreementWrapper.agreementList.length > 0){
            this.showAgreement = true;
            this.showAgreementMessage = false;
            this.agreementId = this.agreementWrapper.agreementList[0]["value"];
            this.agreementName = this.agreementWrapper.agreementList[0]["label"];
            //console.log('this.createOrderWrapper.agreementId'+this.createOrderWrapper.agreementId);
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
           // this.showAgreementMessage = true;
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

    handlerecurringpriceChange(event){
        this.createOrderWrapper.recurringpriceId = event.detail.value;
        this.createOrderWrapper.recurringprice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[this.createOrderWrapper.recurringpriceId][0].price;
        if(this.createOrderWrapper.oneTimePrice){
            this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
        }
        else{
            this.createOrderWrapper.totalPrice = this.createOrderWrapper.recurringprice;
        }
    }

    handleoneTimePriceChange(event){
        this.createOrderWrapper.oneTimePriceId = event.detail.value;
        this.createOrderWrapper.oneTimePrice =this.createOrderWrapper.mapOfProductPriceEidVsPriceRangeList[createOrderWrapper.oneTimePriceId][0].price;
        this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
    }

    handlerecurringpriceOverrirde(event){
        this.createOrderWrapper.recurringprice = event.target.value;
        if(this.createOrderWrapper.oneTimePrice){
            this.createOrderWrapper.totalPrice = (eval(this.createOrderWrapper.recurringprice)+eval(this.createOrderWrapper.oneTimePrice));
        }
        else{
            this.createOrderWrapper.totalPrice = this.createOrderWrapper.recurringprice;
        }
    }

    handleoneTimePriceOverrirde(event){
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
        this.nextSection= true;
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
        this.isModalOpen = false;
    }
    configureProduct(){
        this.isConfigure = true;
        this.orderConfirmation = false;
        this.showHideSections = false;
        this.nextSection = false;
       // this.showServiceResource = false;
       // this.showShortDescription = false;
       // this.showAddress = false;
       // this.showDiscountCode = false;
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
            //this.createOrderWrapper.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.createOrderWrapper.agreementId];
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
           /* { label: 'Services Resources', value: 'ServiceResource' },
            { label: 'Short Description', value: 'ShortDescription' },
            { label: 'Address', value: 'Address' },
            { label: 'Discount Code', value: 'DiscountCode' },
            */
            
        ];
    }
    
    handleRadioConfigureChange(event){
        const selectedOtion = event.detail.value;
        if(selectedOtion==='Agreement'){
            if(this.agreementWrapper.agreementList.length > 0){
                this.showAgreement = true;
                 this.showServiceResource = false;
                 this.showAgreementMessage = false;
               //  this.showServiceResourceMessage = false;
              //   this.showShortDescription = false;
                // this.showAddress = false;
                // this.showDiscountCode = false;
            }
            if(this.agreementWrapper.agreementList.length == 0 || this.agreementWrapper.agreementList.length < 0){
            this.showAgreement = false;
           // this.showServiceResource = false;
           // this.showAgreementMessage = true;
           // this.showServiceResourceMessage = false;
           // this.showShortDescription = false;
           // this.showAddress = false;
           // this.showDiscountCode = false;
            }
        }
      /*  if(selectedOtion==='ServiceResource'){
            console.log('Service Resource');
            console.log('Service Resource'+this.productDetails.TRACT3__SRC_eid__c);
            this.getListOfIdentifier();
            this.showAgreementMessage = false;
            this.showAgreement = false;
            this.showServiceResource = true;
            this.showShortDescription = false;
            this.showAddress = false;
            if(this.productDetails.TRACT3__minServiceResources__c < 1 || this.productDetails.TRACT3__minServiceResources__c==0){
                this.showServiceResource = false;
                this.showAgreementMessage = false;
                this.showAgreement = false;
                this.showServiceResourceMessage = true;
                this.showShortDescription = false;
                this.showAddress = false;
                this.showDiscountCode = false;
            }

        }*/
        /*if(selectedOtion==='ShortDescription'){
            this.showShortDescription = true;
            this.showAgreement = false;
            this.showServiceResource = false;
            this.showAgreementMessage = false;
            this.showServiceResourceMessage = false;
            this.showAddress = false;
            this.showDiscountCode = false;

        }
        if(selectedOtion==='Address'){
            this.showShortDescription = false;
            this.showAgreement = false;
            this.showServiceResource = false;
            this.showAgreementMessage = false;
            this.showServiceResourceMessage = false;
            this.showAddress = true;
            this.showDiscountCode = false;
        }
        if(selectedOtion==='DiscountCode'){
            this.showShortDescription = false;
            this.showAgreement = false;
            this.showServiceResource = false;
            this.showAgreementMessage = false;
            this.showServiceResourceMessage = false;
            this.showAddress = false;
            this.showDiscountCode = true;
        }*/
    }

    /*get options1() {
        return [
            { label: 'Product Price', value: 'option1' },
            { label: 'Service Price', value: 'option2' },
        ];
    }*/

    handleRenewalPricingChange(event){
        this.createOrderWrapper.renewalPrice = event.target.value;
    }
    CancelConfigure(){
        this.isConfigure = false;
        this.orderConfirmation = false;
        this.showHideSections = true;
        this.nextSection = false;
        this.isConfigureDataTrue = false;
       // this.isServiceResourceDataTrue = false;
        this.configErrorMessage = false;
        this.agreementId = this.createOrderWrapper.agreementId
            this.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.agreementId];
            this.agreementEndAction = this.createOrderWrapper.agreementEndAction;
            this.overrideAgreementEndDate = this.createOrderWrapper.overrideAgreementEndDate;
            this.agreementName = this.createOrderWrapper.agreementName;
            this.agreementPeriod =  this.createOrderWrapper.agreementPeriod;
            this.preserveAgreementPrice = this.createOrderWrapper.preserveAgreementPrice;
            this.renewalPrice = this.createOrderWrapper.renewalPrice;
            //this.createOrderWrapper.agreementPeriodType = this.agreementWrapper.mapOfAgreementPeriodType[this.createOrderWrapper.agreementId];
            if(this.createOrderWrapper.agreementEndAction == 'RENEW_AGREEMENT'){
                this.showRenewalPricing = true;
            }
            else{
                this.showRenewalPricing = false;
            }
            if(this.createOrderWrapper.overrideAgreementEndDate !=''){
                this.isOverRideDate = true;
            }
      //  this.showShortDescription = false;
      //  this.showAddress = false;
      //  this.showDiscountCode = false;
        /*if(this.SelectedServiceList.length <= this.productDetails.TRACT3__maxServiceResources__c){
            this.configErrorMessage = false;
        }*/

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
        this.showHideSections = false;
        this.nextSection = true;
        if(this.agreementId && this.agreementId != undefined && this.agreementId.trim() != ''){
            this.isConfigureDataTrue = true;
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
            this.isConfigureDataTrue = false;
            this.agreementId = undefined;
            this.agreementName = undefined;
            this.agreementPeriod = undefined;
            this.agreementEndAction = undefined;
            this.preserveAgreementPrice = undefined;
            this.renewalPrice = undefined;
            this.overrideAgreementEndDate = undefined;
            this.agreementPeriodType = undefined;
        }
     /*   if(this.SelectedServiceList.length >= 1){
            this.isServiceResourceDataTrue = true;
        }else{
            this.isServiceResourceDataTrue = false;
        }*/

       /* if(this.SelectedServiceList.length > this.productDetails.TRACT3__maxServiceResources__c){
            this.configErrorMessage ='Total Resources are greater than maximum available resources';
            this.isConfigure = true;
            this.orderConfirmation = false;
            this.showHideSections = false;
            this.nextSection = false;
            this.isConfigureDataTrue = false;
            this.isServiceResourceDataTrue = false;
        }
        else{
            this.CreateChangeOrder.srIdentifierList = this.SelectedServiceList;
            
        }*/
        
       
    }

    placeOrder(){
        this.isLoading = true;
        CreateChangeOrder({
            changeOrderString: JSON.stringify(this.createOrderWrapper)
        })
        .then(result=>{
                this.isModalOpen = false;
                this.isLoading = false;
                const closePaymentMethodEvent = new CustomEvent('submitsuccess');
                this.dispatchEvent(closePaymentMethodEvent);
        })
        .catch(error => {
            console.log('In Error');
            if (typeof error.body.message === 'string') {
                this.errorMessage = error.body.message;
            }
            else if (Array.isArray(error.body)) {
                this.errorMessage = error.body.map(e => e.message).join(', ');
            }
            //this.errorMessage = JSON.stringify(error);
            this.showErrorMessage = true; 
            this.isLoading = false;
            
        });
    };

    saveCreateChangeOrder(){
        if(this.productDetails.Requires_Agreement__c && this.agreementId){
            this.errorMessage = 'Please configure the agreement';
            this.showErrorMessage = true; 
        }
        else{
            this.isLoading = true;
            createOppLineItem({
                ChangeOrderWrapper: JSON.stringify(this.createOrderWrapper),
                opportunityId: this.oppRecordId
            })
            .then(result=>{
                console.log('result::'+JSON.stringify(result));
                    this.isModalOpen = false;
                    this.isLoading = false;
                    const closePaymentMethodEvent = new CustomEvent('submitsuccess');
                    this.dispatchEvent(closePaymentMethodEvent);
            })
            .catch(error => {
                console.log('In Error');
                if (typeof error.body.message === 'string') {
                    this.errorMessage = error.body.message;
                }
                else if (Array.isArray(error.body)) {
                    this.errorMessage = error.body.map(e => e.message).join(', ');
                }
                //this.errorMessage = JSON.stringify(error);
                this.showErrorMessage = true; 
                this.isLoading = false;
                
            });
        }
        

    };

  /*  getListOfIdentifier(){
        console.log('In Identifier List');
        console.log('Identifier List'+this.productDetails.TRACT3__SRC_eid__c);
        if(this.productDetails.TRACT3__SRC_eid__c != undefined){
            this.isLoading = true;
            getIdentifierList({
                resourceCategoryID: this.productDetails.TRACT3__SRC_eid__c
            })
            .then(result=>{
                console.log('result:::'+JSON.stringify(result));

                this.identifierList = result;
                this.identifierToDisplay = result;
                this.showServiceResource = true;
                this.showAgreement = false;
                this.showAgreementMessage = false;
                this.showServiceResourceMessage =false;  
                this.isLoading =false;
                
            })
            .catch(error => {
                console.log('In Error');
                if (typeof error.body.message === 'string') {
                    this.configErrorMessage = error.body.message;
                }
                else if (Array.isArray(error.body)) {
                    this.configErrorMessage = error.body.map(e => e.message).join(', ');
                }
                //this.errorMessage = JSON.stringify(error);
                //this.showErrorMessage = true; 
                this.isLoading = false;
            });
            
        }
            
        
    
        
        
    };*/
    
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }

   closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
       // const closePaymentMethodEvent = new CustomEvent('closePaymentMethod');
       // this.dispatchEvent(closePaymentMethodEvent);
       
    }

  /*  renderedCallback() {
        console.log('rendered Call back');
        const style = document.createElement('style');
        style.innerText = '.left-tab .slds-form-element .slds-form-element__legend{display:none}.left-tab .slds-form-element .slds-radio{padding:0.25rem 0.5rem 0}.custom-combobox .slds-form-element__label{min-width: 140px; text-align: right;padding-right: 0;}.custom-combobox .slds-combobox_container{width:270px}.action-combobox .slds-combobox_container{max-width:235px}.custom-month .slds-form-element__control .slds-input{max-width:100px}.custom-month .slds-form-element__label .slds-required{display:none}.common-label-hidden .slds-form-element__label .slds-required{display:none}.custom-renewal .slds-form-element__legend{display:none}.custom-renewal .slds-radio .slds-form-element__label{font-weight: 400;}.override-email-check .slds-form-element__control .slds-form-element{float: left;}.override-email-check .slds-form-element__control .slds-checkbox{margin-top:0.5rem}left-tab .slds-form-element .slds-form-element__legend{display:none}.left-tab .slds-form-element .slds-radio{padding:0.25rem 0.5rem 0}.custom-combobox .slds-form-element__label{min-width: 142px; text-align: right;padding-right: 0;}.custom-combobox .slds-combobox_container{width:270px}.action-combobox .slds-combobox_container{max-width:235px}.custom-month .slds-form-element__control .slds-input{max-width:100px}.custom-month .slds-form-element__label .slds-required{display:none}.custom-renewal .slds-form-element__legend{display:none}.custom-renewal .slds-radio .slds-form-element__label{font-weight: 400;}.override-email-check .slds-form-element__control .slds-form-element{float: left;}.override-email-check .slds-form-element__control .slds-checkbox{margin-top:0.5rem}.agreement-address-form .slds-form-element_horizontal .slds-form-element__control .slds-form-element{max-width:235px}';
        this.template.querySelector('.custom-tab').appendChild(style);
    }*/

    renderedCallback() {
       /* if (this.openDropDown) {
            this.template.querySelectorAll('.search-input-class').forEach(inputElem => {
                inputElem.focus();
            });
        }*/

        console.log(this.isRendered);
        if (this.isRendered) {
            let style = document.createElement('style');
        style.innerText = '.left-tab .slds-form-element .slds-form-element__legend{display:none}.left-tab .slds-form-element .slds-radio{padding:0.25rem 0.5rem 0}.custom-combobox .slds-form-element__label{min-width: 135px; text-align: right;padding-right: 0;}.custom-combobox .slds-combobox_container{width:270px}.action-combobox .slds-combobox_container{max-width:235px}.custom-month .slds-form-element__control .slds-input{max-width:100px}.custom-month .slds-form-element__label .slds-required{display:none}.custom-renewal .slds-form-element__legend{display:none}.custom-renewal .slds-radio .slds-form-element__label{font-weight: 400;}.override-email-check .slds-form-element__control .slds-form-element{float: left;}.override-email-check .slds-form-element__control .slds-checkbox{margin-top:0.5rem}left-tab .slds-form-element .slds-form-element__legend{display:none}.left-tab .slds-form-element .slds-radio{padding:0.25rem 0.5rem 0}.custom-combobox .slds-form-element__label{min-width: 135px; text-align: right;padding-right: 0;}.custom-combobox .slds-combobox_container{width:270px}.action-combobox .slds-combobox_container{max-width:235px}.custom-month .slds-form-element__control .slds-input{max-width:100px}.custom-month .slds-form-element__label .slds-required{display:none}.custom-renewal .slds-form-element__legend{display:none}.custom-renewal .slds-radio .slds-form-element__label{font-weight: 400;}.override-email-check .slds-form-element__control .slds-form-element{float: left;}.override-email-check .slds-form-element__control .slds-checkbox{margin-top:0.5rem}';
        this.template.querySelector('.custom-tab').appendChild(style);
        }
        this.isRendered = true;
    
        
    }

   /* handleServiceResourceChange(event){
        console.log('event.detail.value'+event.detail.value);
        //srIdentifierList;
        
       
        for( var key in this.identifierList){
            if(this.identifierList[key]["value"] == event.detail.value){
                this.selectedServiceName = this.identifierList[key]["label"];
                console.log('here--'+this.identifierList[key]["label"]);
                this.SelectedServiceList.push(this.selectedServiceName);
                  console.log('this.selectedServiceName::::'+this.selectedServiceName);
                
                break;
            }
        }
        this.totalResourceNumber = this.totalResourceNumber +1;
        if(this.totalResourceNumber >1){
            this.totalResourceNumber = this.totalResourceNumber-1;
        }
        
     


    }*/

   /*  setOptionsAndValues() {
        this.optionsToDisplay = (this.options && this.options.length > 0 ? this.options : []);
        if (this.isvalue && this.isvalue != "") {
            let label = this.getLabel(this.isvalue);
            if (label && label != "") {
                this.label = label;
            }
           
        }
        else {
            this.label = "";
        }
    }

    //Method to get Label for value provided
    getLabel(value) {
        let selectedObjArray = this.options.filter(obj => obj.value === value);
        if (selectedObjArray && selectedObjArray.length > 0) {
            return selectedObjArray[0].label;
        }
        return null;
    }

    //Method to open listbox dropdown
    openDropDown(event) {
        this.toggleOpenDropDown(true);
    }

    //Method to close listbox dropdown
    closeDropdown(event) {
	
        if (event.relatedTarget && event.relatedTarget.tagName == "UL" && event.relatedTarget.className.includes('customClass')) {
            console.log(JSON.stringify(event.relatedTarget.className));
            if (this.openDropDown) {
                this.template.querySelectorAll('.search-input-class').forEach(inputElem => {
                    inputElem.focus();
                });
            }
        }
        else {
            window.setTimeout(() => {
                this.toggleOpenDropDown(false);
            }, 300);
        }
    }

    //Method to handle readonly input click
    handleInputClick(event) {
        this.resetParameters();
        this.toggleOpenDropDown(true);
        

       
    }

    //Method to handle key press on text input
    handleKeyPress(event) {
        const searchKey = event.target.value;
        this.setInputValue(searchKey);
        if (this.delaytimeout) {
            window.clearTimeout(this.delaytimeout);
        }

        this.delaytimeout = setTimeout(() => {
            //filter dropdown list based on search key parameter
            this.filterDropdownList(searchKey);
        }, delay);

        
    }

    //Method to filter dropdown list
    filterDropdownList(key) {
        console.log('FilterOption');
        const filteredOptions = this.identifierList.filter(item => item.label.toLowerCase().includes(key.toLowerCase()));
        console.log('FilterOption 1');
        this.identifierToDisplay = filteredOptions;

      //  const filteredOptions = this.optionss.filter(item => item.label.toLowerCase().includes(key.toLowerCase()));
      //  this.optionsToDisplay = filteredOptions;
    }

    //Method to handle selected options in listbox
    optionsClickHandler(event) {
        const value = event.target.closest('li').dataset.value;
        const label = event.target.closest('li').dataset.label;
        this.setValues(value, label);
        this.toggleOpenDropDown(false);
        const detail = {};
        detail["value"] = value;
        detail["label"] = label;
        
       //this.dispatchEvent(new CustomEvent('change', { detail: detail }));
       if(this.label.length> 1){
        this.SelectedServiceList.push(this.label);
        }

        console.log('this.SelectedServiceList::::'+this.SelectedServiceList);
    }

    //Method to reset necessary properties
    resetParameters() {
        this.setInputValue("");
        this.optionsToDisplay = this.options;
    }

    //Method to set inputValue for search input box
    setInputValue(value) {
        this.inputValue = value;
    }

    //Method to set label and value based on
    //the parameter provided
    setValues(value, label) {
        this.label = label;
        this.isvalue = value;
    }

    //Method to toggle openDropDown state
    toggleOpenDropDown(toggleState) {
        this.openDropDown = toggleState;
    }

    //getter setter for labelClass
    get labelClass() {
        return (this.fieldLabel && this.fieldLabel != "" ? "slds-form-element__label slds-show" : "slds-form-element__label slds-hide")
    }

    //getter setter for dropDownClass
    get dropDownClass() {
        return (this.openDropDown ? "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open" : "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click");
    }

    //getter setter for isValueSelected
    get isValueSelected() {
        return (this.label && this.label != "" ? true : false);
    }

    get isDropdownOpen() {
        return (this.openDropDown ? true : false);
    }

    removeService(event){
        let idToDelete = event.target.name;
        let deleteResource = this.SelectedServiceList;
        let SelectedServiceListIndex;

        for(let i=0; i<deleteResource.length; i++) {
            if(idToDelete === deleteResource[i]) {
                SelectedServiceListIndex = i;
                break;
            }
        }       
        deleteResource.splice(SelectedServiceListIndex, 1);
    }

    handleShortDescriptionChange(event){
        console.log('event.target.value'+event.target.value);
        this.createOrderWrapper.shortDescription =  event.target.value;
    }

    selectedCountry = '';
    countryStateeMap = {
        US: [
            { label: 'ALABAMA', value: 'ALABAMA' },
            { label: 'ALASKA', value: 'ALASKA' },
            { label: 'ARIZONA', value: 'ARIZONA' },
            { label: 'ARKANSAS', value: 'ARKANSAS' },
            { label: 'ARMED FORCES AFRICA, CANADA, EUROPE, MIDDLE EAST', value: 'ARMED FORCES AFRICA, CANADA, EUROPE, MIDDLE EAST ' },
            { label: 'ARMED FORCES AMERICA', value: 'ARMED FORCES AMERICA' },
            { label: 'ARMED FORCES PACIFIC', value: 'ARMED FORCES PACIFIC' },
            { label: 'CALIFORNIA', value: 'CALIFORNIA' },
            { label: 'CONNECTICUT', value: 'CONNECTICUT' },
            { label: 'DISTRICT OF COLUMBIA', value: 'DISTRICT OF COLUMBIA' },
            { label: 'DELAWARE', value: 'DELAWARE' },
            { label: 'FLORIDA', value: 'FLORIDA' },
            { label: 'GEORGIA', value: 'GEORGIA' },
            { label: 'HAWAII', value: 'HAWAII' },
            { label: 'IDAHO', value: 'IDAHO' },
            { label: 'ILLINOIS', value: 'ILLINOIS' },
            { label: 'IOWA', value: 'IOWA' },
            { label: 'INDIANA', value: 'INDIANA' },
            { label: 'KANSAS', value: 'KANSAS' },
            { label: 'KENTUCKY', value: 'KENTUCKY' },
            { label: 'LOUISIANA', value: 'LOUISIANA' },
            { label: 'MAINE', value: 'MAINE' },
            { label: 'MANITOBA', value: 'MANITOBA' },
            { label: 'MARYLAND', value: 'MARYLAND' },
            { label: 'MASSACHUSETTS', value: 'MASSACHUSETTS' },
            { label: 'MICHIGAN', value: 'MICHIGAN' },
            { label: 'MINNESOTA', value: 'MINNESOTA' },
            { label: 'MISSISSIPPI', value: 'MISSISSIPPI' },
            { label: 'MISSOURI', value: 'MISSOURI' },
            { label: 'MONTANA', value: 'MONTANA' },
            { label: 'NEBRASKA', value: 'NEBRASKA' },
            { label: 'NEVADA', value: 'NEVADA' },
            { label: 'NEW HAMPSHIRE', value: 'NEW HAMPSHIRE' },
            { label: 'NEW JERSEY', value: 'NEW JERSEY' },
            { label: 'NEW MEXICO', value: 'NEW MEXICO' },
            { label: 'NEW YORK', value: 'NEW YORK' },
            { label: 'NORTH CAROLINA', value: 'NORTH CAROLINA' },
            { label: 'NORTH DAKOTA', value: 'NORTH DAKOTA' },
            { label: 'OHIO', value: 'OHIO' },
            { label: 'OKLAHOMA', value: 'OKLAHOMA' },
            { label: 'OREGON', value: 'OREGON' },
            { label: 'PENNSYLVANIA', value: 'PENNSYLVANIA' },
            { label: 'PUERTO RICO', value: 'PUERTO RICO' },
            { label: 'RHODE ISLAND', value: 'RHODE ISLAND' },
            { label: 'SOUTH CAROLINA', value: 'SOUTH CAROLINA' },
            { label: 'SOUTH DAKOTA', value: 'SOUTH DAKOTA' },
            { label: 'TENNESSEE', value: 'TENNESSEE' },
            { label: 'TEXAS', value: 'TEXAS' },
            { label: 'UTAH', value: 'UTAH' },
            { label: 'VERMONT', value: 'VERMONT' },
            { label: 'VIRGINIA', value: 'VIRGINIA' },
            { label: 'WASHINGTON', value: 'WASHINGTON' },
            { label: 'WEST VIRGINIA', value: 'WEST VIRGINIA' },
            { label: 'WISCONSIN', value: 'WISCONSIN' },
            { label: 'WYOMING', value: 'WYOMING' }
        ]
    };

    countryOptions = [
        {
            value: "United States",
            key: "US",
            label: "United States"
        },
        {
            value: "Afghanistan",
            key: "AF",
            label: "Afghanistan"
        },
        {
            value: "Åland Islands",
            key: "AX",
            label: "Åland Islands"
        },
        {
            value: "Albania",
            key: "AL",
            label: "Albania"
        },
        {
            value: "Algeria",
            key: "DZ",
            label: "Algeria"
        },
        {
            value: "American Samoa",
            key: "AS",
            label: "American Samoa"
        },
        {
            value: "Andorra",
            key: "AD",
            label: "Andorra"
        },
        {
            value: "Angola",
            key: "AO",
            label: "Angola"
        },
        {
            value: "Anguilla",
            key: "AI",
            label: "Anguilla"
        },
        {
            value: "Antarctica",
            key: "AQ",
            label: "Antarctica"
        },
        {
            value: "Antigua and Barbuda",
            key: "AG",
            label: "Antigua and Barbuda"
        },
        {
            value: "Argentina",
            key: "AR",
            label: "Argentina"
        },
        {
            value: "Armenia",
            key: "AM",
            label: "Armenia"
        },
        {
            value: "Aruba",
            key: "AW",
            label: "Aruba"
        },
        {
            value: "Australia",
            key: "AU",
            label: "Australia"
        },
        {
            value: "Austria",
            key: "AT",
            label: "Austria"
        },
        {
            value: "Azerbaijan",
            key: "AZ",
            label: "Azerbaijan"
        },
        {
            value: "Bahamas",
            key: "BS",
            label: "Bahamas"
        },
        {
            value: "Bahrain",
            key: "BH",
            label: "Bahrain"
        },
        {
            value: "Bangladesh",
            key: "BD",
            label: "Bangladesh"
        },
        {
            value: "Barbados",
            key: "BB",
            label: "Barbados"
        },
        {
            value: "Belarus",
            key: "BY",
            label: "Belarus"
        },
        {
            value: "Belgium",
            key: "BE",
            label: "Belgium"
        },
        {
            value: "Belize",
            key: "BZ",
            label: "Belize"
        },
        {
            value: "Benin",
            key: "BJ",
            label: "Benin"
        },
        {
            value: "Bermuda",
            key: "BM",
            label: "Bermuda"
        },
        {
            value: "Bhutan",
            key: "BT",
            label: "Bhutan"
        },
        {
            value: "Bolivia",
            key: "BO",
            label: "Bolivia"
        },
        {
            value: "Bosnia and Herzegovina",
            key: "BA",
            label: "Bosnia and Herzegovina"
        },
        {
            value: "Botswana",
            key: "BW",
            label: "Botswana"
        },
        {
            value: "Bouvet Island",
            key: "BV",
            label: "Bouvet Island"
        },
        {
            value: "Brazil",
            key: "BR",
            label: "Brazil"
        },
        {
            value: "British Indian Ocean Territory",
            key: "IO",
            label: "British Indian Ocean Territory"
        },
        {
            value: "Brunei Darussalam",
            key: "BN",
            label: "Brunei Darussalam"
        },
        {
            value: "Bulgaria",
            key: "BG",
            label: "Bulgaria"
        },
        {
            value: "Burkina Faso",
            key: "BF",
            label: "Burkina Faso"
        },
        {
            value: "Burundi",
            key: "BI",
            label: "Burundi"
        },
        {
            value: "Cambodia",
            key: "KH",
            label: "Cambodia"
        },
        {
            value: "Cameroon",
            key: "CM",
            label: "Cameroon"
        },
        {
            value: "Canada",
            key: "CA",
            label: "Canada"
        },
        {
            value: "Cape Verde",
            key: "CV",
            label: "Cape Verde"
        },
        {
            value: "Cayman Islands",
            key: "KY",
            label: "Cayman Islands"
        },
        {
            value: "Central African Republic",
            key: "CF",
            label: "Central African Republic"
        },
        {
            value: "Chad",
            key: "TD",
            label: "Chad"
        },
        {
            value: "Chile",
            key: "CL",
            label: "Chile"
        },
        {
            value: "China",
            key: "CN",
            label: "China"
        },
        {
            value: "Christmas Island",
            key: "CX",
            label: "Christmas Island"
        },
        {
            value: "Cocos (Keeling) Islands",
            key: "CC",
            label: "Cocos (Keeling) Islands"
        },
        {
            value: "Colombia",
            key: "CO",
            label: "Colombia"
        },
        {
            value: "Comoros",
            key: "KM",
            label: "Comoros"
        },
        {
            value: "Congo",
            key: "CG",
            label: "Congo"
        },
        {
            value: "Congo, The Democratic Republic of the",
            key: "CD",
            label: "Congo, The Democratic Republic of the"
        },
        {
            value: "Cook Islands",
            key: "CK",
            label: "Cook Islands"
        },
        {
            value: "Costa Rica",
            key: "CR",
            label: "Costa Rica"
        },
        {
            value: "Cote D'Ivoire",
            key: "CI",
            label: "Cote D'Ivoire"
        },
        {
            value: "Croatia",
            key: "HR",
            label: "Croatia"
        },
        {
            value: "Cuba",
            key: "CU",
            label: "Cuba"
        },
        {
            value: "Cyprus",
            key: "CY",
            label: "Cyprus"
        },
        {
            value: "Czech Republic",
            key: "CZ",
            label: "Czech Republic"
        },
        {
            value: "Denmark",
            key: "DK",
            label: "Denmark"
        },
        {
            value: "Djibouti",
            key: "DJ",
            label: "Djibouti"
        },
        {
            value: "Dominica",
            key: "DM",
            label: "Dominica"
        },
        {
            value: "Dominican Republic",
            key: "DO",
            label: "Dominican Republic"
        },
        {
            value: "Ecuador",
            key: "EC",
            label: "Ecuador"
        },
        {
            value: "Egypt",
            key: "EG",
            label: "Egypt"
        },
        {
            value: "El Salvador",
            key: "SV",
            label: "El Salvador"
        },
        {
            value: "Equatorial Guinea",
            key: "GQ",
            label: "Equatorial Guinea"
        },
        {
            value: "Eritrea",
            key: "ER",
            label: "Eritrea"
        },
        {
            value: "Estonia",
            key: "EE",
            label: "Estonia"
        },
        {
            value: "Ethiopia",
            key: "ET",
            label: "Ethiopia"
        },
        {
            value: "Falkland Islands (Malvinas)",
            key: "FK",
            label: "Falkland Islands (Malvinas)"
        },
        {
            value: "Faroe Islands",
            key: "FO",
            label: "Faroe Islands"
        },
        {
            value: "Fiji",
            key: "FJ",
            label: "Fiji"
        },
        {
            value: "Finland",
            key: "FI",
            label: "Finland"
        },
        {
            value: "France",
            key: "FR",
            label: "France"
        },
        {
            value: "French Guiana",
            key: "GF",
            label: "French Guiana"
        },
        {
            value: "French Polynesia",
            key: "PF",
            label: "French Polynesia"
        },
        {
            value: "French Southern Territories",
            key: "TF",
            label: "French Southern Territories"
        },
        {
            value: "Gabon",
            key: "GA",
            label: "Gabon"
        },
        {
            value: "Gambia",
            key: "GM",
            label: "Gambia"
        },
        {
            value: "Georgia",
            key: "GE",
            label: "Georgia"
        },
        {
            value: "Germany",
            key: "DE",
            label: "Germany"
        },
        {
            value: "Ghana",
            key: "GH",
            label: "Ghana"
        },
        {
            value: "Gibraltar",
            key: "GI",
            label: "Gibraltar"
        },
        {
            value: "Greece",
            key: "GR",
            label: "Greece"
        },
        {
            value: "Greenland",
            key: "GL",
            label: "Greenland"
        },
        {
            value: "Grenada",
            key: "GD",
            label: "Grenada"
        },
        {
            value: "Guadeloupe",
            key: "GP",
            label: "Guadeloupe"
        },
        {
            value: "Guam",
            key: "GU",
            label: "Guam"
        },
        {
            value: "Guatemala",
            key: "GT",
            label: "Guatemala"
        },
        {
            value: "Guernsey",
            key: "GG",
            label: "Guernsey"
        },
        {
            value: "Guinea",
            key: "GN",
            label: "Guinea"
        },
        {
            value: "Guinea-Bissau",
            key: "GW",
            label: "Guinea-Bissau"
        },
        {
            value: "Guyana",
            key: "GY",
            label: "Guyana"
        },
        {
            value: "Haiti",
            key: "HT",
            label: "Haiti"
        },
        {
            value: "Heard Island and Mcdonald Islands",
            key: "HM",
            label: "Heard Island and Mcdonald Islands"
        },
        {
            value: "Holy See (Vatican City State)",
            key: "VA",
            label: "Holy See (Vatican City State)"
        },
        {
            value: "Honduras",
            key: "HN",
            label: "Honduras"
        },
        {
            value: "Hong Kong",
            key: "HK",
            label: "Hong Kong"
        },
        {
            value: "Hungary",
            key: "HU",
            label: "Hungary"
        },
        {
            value: "Iceland",
            key: "IS",
            label: "Iceland"
        },
        {
            value: "India",
            key: "IN",
            label: "India"
        },
        {
            value: "Indonesia",
            key: "ID",
            label: "Indonesia"
        },
        {
            value: "Iran, Islamic Republic Of",
            key: "IR",
            label: "Iran, Islamic Republic Of"
        },
        {
            value: "Iraq",
            key: "IQ",
            label: "Iraq"
        },
        {
            value: "Ireland",
            key: "IE",
            label: "Ireland"
        },
        {
            value: "Isle of Man",
            key: "IM",
            label: "Isle of Man"
        },
        {
            value: "Israel",
            key: "IL",
            label: "Israel"
        },
        {
            value: "Italy",
            key: "IT",
            label: "Italy"
        },
        {
            value: "Jamaica",
            key: "JM",
            label: "Jamaica"
        },
        {
            value: "Japan",
            key: "JP",
            label: "Japan"
        },
        {
            value: "Jersey",
            key: "JE",
            label: "Jersey"
        },
        {
            value: "Jordan",
            key: "JO",
            label: "Jordan"
        },
        {
            value: "Kazakhstan",
            key: "KZ",
            label: "Kazakhstan"
        },
        {
            value: "Kenya",
            key: "KE",
            label: "Kenya"
        },
        {
            value: "Kiribati",
            key: "KI",
            label: "Kiribati"
        },
        {
            value: "Korea, Democratic People's Republic of",
            key: "KP",
            label: "Korea, Democratic People's Republic of"
        },
        {
            value: "Korea, Republic of",
            key: "KR",
            label: "Korea, Republic of"
        },
        {
            value: "Kuwait",
            key: "KW",
            label: "Kuwait"
        },
        {
            value: "Kyrgyzstan",
            key: "KG",
            label: "Kyrgyzstan"
        },
        {
            value: "Lao People's Democratic Republic",
            key: "LA",
            label: "Lao People's Democratic Republic"
        },
        {
            value: "Latvia",
            key: "LV",
            label: "Latvia"
        },
        {
            value: "Lebanon",
            key: "LB",
            label: "Lebanon"
        },
        {
            value: "Lesotho",
            key: "LS",
            label: "Lesotho"
        },
        {
            value: "Liberia",
            key: "LR",
            label: "Liberia"
        },
        {
            value: "Libyan Arab Jamahiriya",
            key: "LY",
            label: "Libyan Arab Jamahiriya"
        },
        {
            value: "Liechtenstein",
            key: "LI",
            label: "Liechtenstein"
        },
        {
            value: "Lithuania",
            key: "LT",
            label: "Lithuania"
        },
        {
            value: "Luxembourg",
            key: "LU",
            label: "Luxembourg"
        },
        {
            value: "Macao",
            key: "MO",
            label: "Macao"
        },
        {
            value: "Macedonia, The Former Yugoslav Republic of",
            key: "MK",
            label: "Macedonia, The Former Yugoslav Republic of"
        },
        {
            value: "Madagascar",
            key: "MG",
            label: "Madagascar"
        },
        {
            value: "Malawi",
            key: "MW",
            label: "Malawi"
        },
        {
            value: "Malaysia",
            key: "MY",
            label: "Malaysia"
        },
        {
            value: "Maldives",
            key: "MV",
            label: "Maldives"
        },
        {
            value: "Mali",
            key: "ML",
            label: "Mali"
        },
        {
            value: "Malta",
            key: "MT",
            label: "Malta"
        },
        {
            value: "Marshall Islands",
            key: "MH",
            label: "Marshall Islands"
        },
        {
            value: "Martinique",
            key: "MQ",
            label: "Martinique"
        },
        {
            value: "Mauritania",
            key: "MR",
            label: "Mauritania"
        },
        {
            value: "Mauritius",
            key: "MU",
            label: "Mauritius"
        },
        {
            value: "Mayotte",
            key: "YT",
            label: "Mayotte"
        },
        {
            value: "Mexico",
            key: "MX",
            label: "Mexico"
        },
        {
            value: "Micronesia, Federated States of",
            key: "FM",
            label: "Micronesia, Federated States of"
        },
        {
            value: "Moldova, Republic of",
            key: "MD",
            label: "Moldova, Republic of"
        },
        {
            value: "Monaco",
            key: "MC",
            label: "Monaco"
        },
        {
            value: "Mongolia",
            key: "MN",
            label: "Mongolia"
        },
        {
            value: "Montserrat",
            key: "MS",
            label: "Montserrat"
        },
        {
            value: "Morocco",
            key: "MA",
            label: "Morocco"
        },
        {
            value: "Mozambique",
            key: "MZ",
            label: "Mozambique"
        },
        {
            value: "Myanmar",
            key: "MM",
            label: "Myanmar"
        },
        {
            value: "Namibia",
            key: "NA",
            label: "Namibia"
        },
        {
            value: "Nauru",
            key: "NR",
            label: "Nauru"
        },
        {
            value: "Nepal",
            key: "NP",
            label: "Nepal"
        },
        {
            value: "Netherlands",
            key: "NL",
            label: "Netherlands"
        },
        {
            value: "Netherlands Antilles",
            key: "AN",
            label: "Netherlands Antilles"
        },
        {
            value: "New Caledonia",
            key: "NC",
            label: "New Caledonia"
        },
        {
            value: "New Zealand",
            key: "NZ",
            label: "New Zealand"
        },
        {
            value: "Nicaragua",
            key: "NI",
            label: "Nicaragua"
        },
        {
            value: "Niger",
            key: "NE",
            label: "Niger"
        },
        {
            value: "Nigeria",
            key: "NG",
            label: "Nigeria"
        },
        {
            value: "Niue",
            key: "NU",
            label: "Niue"
        },
        {
            value: "Norfolk Island",
            key: "NF",
            label: "Norfolk Island"
        },
        {
            value: "Northern Mariana Islands",
            key: "MP",
            label: "Northern Mariana Islands"
        },
        {
            value: "Norway",
            key: "NO",
            label: "Norway"
        },
        {
            value: "Oman",
            key: "OM",
            label: "Oman"
        },
        {
            value: "Pakistan",
            key: "PK",
            label: "Pakistan"
        },
        {
            value: "Palau",
            key: "PW",
            label: "Palau"
        },
        {
            value: "Palestinian Territory, Occupied",
            key: "PS",
            label: "Palestinian Territory, Occupied"
        },
        {
            value: "Panama",
            key: "PA",
            label: "Panama"
        },
        {
            value: "Papua New Guinea",
            key: "PG",
            label: "Papua New Guinea"
        },
        {
            value: "Paraguay",
            key: "PY",
            label: "Paraguay"
        },
        {
            value: "Peru",
            key: "PE",
            label: "Peru"
        },
        {
            value: "Philippines",
            key: "PH",
            label: "Philippines"
        },
        {
            value: "Pitcairn",
            key: "PN",
            label: "Pitcairn"
        },
        {
            value: "Poland",
            key: "PL",
            label: "Poland"
        },
        {
            value: "Portugal",
            key: "PT",
            label: "Portugal"
        },
        {
            value: "Puerto Rico",
            key: "PR",
            label: "Puerto Rico"
        },
        {
            value: "Qatar",
            key: "QA",
            label: "Qatar"
        },
        {
            value: "Reunion",
            key: "RE",
            label: "Reunion"
        },
        {
            value: "Romania",
            key: "RO",
            label: "Romania"
        },
        {
            value: "Russian Federation",
            key: "RU",
            label: "Russian Federation"
        },
        {
            value: "RWANDA",
            key: "RW",
            label: "RWANDA"
        },
        {
            value: "Saint Helena",
            key: "SH",
            label: "Saint Helena"
        },
        {
            value: "Saint Kitts and Nevis",
            key: "KN",
            label: "Saint Kitts and Nevis"
        },
        {
            value: "Saint Lucia",
            key: "LC",
            label: "Saint Lucia"
        },
        {
            value: "Saint Pierre and Miquelon",
            key: "PM",
            label: "Saint Pierre and Miquelon"
        },
        {
            value: "Saint Vincent and the Grenadines",
            key: "VC",
            label: "Saint Vincent and the Grenadines"
        },
        {
            value: "Samoa",
            key: "WS",
            label: "Samoa"
        },
        {
            value: "San Marino",
            key: "SM",
            label: "San Marino"
        },
        {
            value: "Sao Tome and Principe",
            key: "ST",
            label: "Sao Tome and Principe"
        },
        {
            value: "Saudi Arabia",
            key: "SA",
            label: "Saudi Arabia"
        },
        {
            value: "Senegal",
            key: "SN",
            label: "Senegal"
        },
        {
            value: "Serbia and Montenegro",
            key: "CS",
            label: "Serbia and Montenegro"
        },
        {
            value: "Seychelles",
            key: "SC",
            label: "Seychelles"
        },
        {
            value: "Sierra Leone",
            key: "SL",
            label: "Sierra Leone"
        },
        {
            value: "Singapore",
            key: "SG",
            label: "Singapore"
        },
        {
            value: "Slovakia",
            key: "SK",
            label: "Slovakia"
        },
        {
            value: "Slovenia",
            key: "SI",
            label: "Slovenia"
        },
        {
            value: "Solomon Islands",
            key: "SB",
            label: "Solomon Islands"
        },
        {
            value: "Somalia",
            key: "SO",
            label: "Somalia"
        },
        {
            value: "South Africa",
            key: "ZA",
            label: "South Africa"
        },
        {
            value: "South Georgia and the South Sandwich Islands",
            key: "GS",
            label: "South Georgia and the South Sandwich Islands"
        },
        {
            value: "Spain",
            key: "ES",
            label: "Spain"
        },
        {
            value: "Sri Lanka",
            key: "LK",
            label: "Sri Lanka"
        },
        {
            value: "Sudan",
            key: "SD",
            label: "Sudan"
        },
        {
            value: "Suriname",
            key: "SR",
            label: "Suriname"
        },
        {
            value: "Svalbard and Jan Mayen",
            key: "SJ",
            label: "Svalbard and Jan Mayen"
        },
        {
            value: "Swaziland",
            key: "SZ",
            label: "Swaziland"
        },
        {
            value: "Sweden",
            key: "SE",
            label: "Sweden"
        },
        {
            value: "Switzerland",
            key: "CH",
            label: "Switzerland"
        },
        {
            value: "Syrian Arab Republic",
            key: "SY",
            label: "Syrian Arab Republic"
        },
        {
            value: "Taiwan, Province of China",
            key: "TW",
            label: "Taiwan, Province of China"
        },
        {
            value: "Tajikistan",
            key: "TJ",
            label: "Tajikistan"
        },
        {
            value: "Tanzania, United Republic of",
            key: "TZ",
            label: "Tanzania, United Republic of"
        },
        {
            value: "Thailand",
            key: "TH",
            label: "Thailand"
        },
        {
            value: "Timor-Leste",
            key: "TL",
            label: "Timor-Leste"
        },
        {
            value: "Togo",
            key: "TG",
            label: "Togo"
        },
        {
            value: "Tokelau",
            key: "TK",
            label: "Tokelau"
        },
        {
            value: "Tonga",
            key: "TO",
            label: "Tonga"
        },
        {
            value: "Trinidad and Tobago",
            key: "TT",
            label: "Trinidad and Tobago"
        },
        {
            value: "Tunisia",
            key: "TN",
            label: "Tunisia"
        },
        {
            value: "Turkey",
            key: "TR",
            label: "Turkey"
        },
        {
            value: "Turkmenistan",
            key: "TM",
            label: "Turkmenistan"
        },
        {
            value: "Turks and Caicos Islands",
            key: "TC",
            label: "Turks and Caicos Islands"
        },
        {
            value: "Tuvalu",
            key: "TV",
            label: "Tuvalu"
        },
        {
            value: "Uganda",
            key: "UG",
            label: "Uganda"
        },
        {
            value: "Ukraine",
            key: "UA",
            label: "Ukraine"
        },
        {
            value: "United Arab Emirates",
            key: "AE",
            label: "United Arab Emirates"
        },
        {
            value: "United Kingdom",
            key: "GB",
            label: "United Kingdom"
        },
        
        {
            value: "United States Minor Outlying Islands",
            key: "UM",
            label: "United States Minor Outlying Islands"
        },
        {
            value: "Uruguay",
            key: "UY",
            label: "Uruguay"
        },
        {
            value: "Uzbekistan",
            key: "UZ",
            label: "Uzbekistan"
        },
        {
            value: "Vanuatu",
            key: "VU",
            label: "Vanuatu"
        },
        {
            value: "Venezuela",
            key: "VE",
            label: "Venezuela"
        },
        {
            value: "Viet Nam",
            key: "VN",
            label: "Viet Nam"
        },
        {
            value: "Virgin Islands, British",
            key: "VG",
            label: "Virgin Islands, British"
        },
        {
            value: "Virgin Islands, U.S.",
            key: "VI",
            label: "Virgin Islands, U.S."
        },
        {
            value: "Wallis and Futuna",
            key: "WF",
            label: "Wallis and Futuna"
        },
        {
            value: "Western Sahara",
            key: "EH",
            label: "Western Sahara"
        },
        {
            value: "Yemen",
            key: "YE",
            label: "Yemen"
        },
        {
            value: "Zambia",
            key: "ZM",
            label: "Zambia"
        },
        {
            value: "Zimbabwe",
            key: "ZW",
            label: "Zimbabwe"
        }
    ];

    get stateOptions() {
        return this.countryStateeMap[this.selectedCountry];
    }

    get countryOptions() {
        return this.countryOptions;
    }

    handleAddressChange(event){
        this.country = event.detail.value;
        if (event.detail.value === 'United States') {
            this.selectedCountry = 'US';
            
            this.usselected = true;
        }
        else {
            this.selectedCountry = event.detail.value;
            this.usselected = false;
        }
    }

    handleStateChange= event =>{
        this.country.state = event.detail.value;
    }*/



}