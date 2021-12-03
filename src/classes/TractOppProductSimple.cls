/** 
* Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
* This software contains confidential and trade secret information of:
* Transverse, LLC.
* 620 Congress Ave.
* Suite 200
* Austin, TX 78701
* USA
* Use, duplication or disclosure of this software is prohibited
* without prior written permission of Transverse, LLC.
*/

/*******************************************************************************************************************
** Module Name   : TractOppProductSimple
**
** Revision History:-
** Version             Date            Author      Description of Action:
** 1.0                 22/04/2019      AMAN JAIN   This class is the Controller to handle the quick add product module.
******************************************************************************************************************************/

public  class TractOppProductSimple {
    @AuraEnabled
    public static Boolean checkExistingCustomer(String OpportunityId){
        Opportunity opportunity= [select id,Type,pricebook2.Name,Pricebook2Id,AccountId,Tract_Sales_Order__c, Account.Tract_Billing_Account__c, Account.Currency_Type__c from Opportunity where id =:OpportunityId limit 1];
        if(opportunity.Type == 'Existing Customer - Upgrade' || opportunity.Type == 'Existing Customer - Downgrade' || opportunity.Type == 'Existing Customer - Replacement'){
            return true;
        }else{
            return false;
        }
    }
    
    @AuraEnabled
    public static ProductListWrapper getProductLists(String OpportunityId){
        String pricebook2Id;
        String pricebookName;
        List<String> ProductIDSet = new List<String>();
        ProductListWrapper proList = new ProductListWrapper();
        list<Product2Wrapper>  Product2Wrapper_List = new list<Product2Wrapper>();
        APIDataService dataService = GTVDataService.getService();
        Opportunity opportunity= [select id,pricebook2.Name,Pricebook2Id,AccountId,Tract_Sales_Order__c, Account.Tract_Billing_Account__c, Account.Currency_Type__c from Opportunity where id =:OpportunityId limit 1];
        if(opportunity!=null ){
            pricebook2Id =opportunity.Pricebook2Id;
            pricebookName = opportunity.pricebook2.Name;
        }
        if(opportunity.Tract_Sales_Order__c != null){
            proList.errorMessage = 'OrderCreated';
            return proList;
        } 
        if(opportunity.AccountId == null || opportunity.Account.Tract_Billing_Account__c == null){
            proList.errorMessage = 'NoBillingAccount';
            return proList;
        }
       /* else if(opportunity.Account.Currency_Type__c == null){
            proList.errorMessage = 'NoCurrencyType';
            return proList;
        }*/
        else if(opportunity.Account.Currency_Type__c == null){
            TRACTAccountWrapper billingAccount;
        try{
           billingAccount = dataService.getBillingAccount(opportunity.Account.id);
        }
        catch(exception e){
        }
        if(null !=billingAccount && null != billingAccount.billingAccount.Tract_Billing_Account__c ){
                opportunity.Account.Currency_Type__c = billingAccount.accountCurrency;  
            }
            else{
                proList.errorMessage = 'NoCurrencyType';
                  return proList;
            }
       }
        /*if(pricebook2Id == null){*/
            for(Pricebook2 pricebook : [SELECT id,Name FROM Pricebook2]){
                if(pricebook.Name.contains(opportunity.Account.Currency_Type__c)){            
                    pricebook2Id = pricebook.Id;
                    pricebookName = pricebook.Name;
                }
            }
        if(pricebook2Id == null){
            proList.errorMessage = 'NoPriceBook';
            return proList;
        }
        for(PricebookEntry PbeRecord : [select id, name, Pricebook2Id,Product2Id from PricebookEntry where Pricebook2Id =:pricebook2Id limit 50000]){
            ProductIDSet.add(PbeRecord.Product2Id);        
        }
        
        for(product2 ProductRec : [Select id, name,eid__c,Price_Information__c, Requires_Agreement__c, Agreement_Information__c,description,ProductCode,Short_Desc__c,RuleOverride__c,RuleType__c,PriceLists__c, maxServiceResources__c, minServiceResources__c  
                                   from Product2 where Id IN : ProductIDSet and eid__c != null and ProductCode != 'Add-on' and description != 'This Product is No longer available in TRACT' and IsActive = true ORDER BY Name ASC]){
                                       Product2Wrapper w = new Product2Wrapper();
                                       w.IsSelected = false;
                                       w.prod = ProductRec;
                                       Product2Wrapper_List.add(w);             
                                   }
        proList.product2WrapperList = Product2Wrapper_List;
        opportunity.Pricebook2Id = pricebook2Id;
        update opportunity;
        proList.pricebook= pricebookName;
        proList.productIdList= ProductIDSet;
        return proList;
    }
    
    @AuraEnabled
    public static ProductListWrapper getProductListsByName(List<String> ProductIDSet ,String searchKey){
        String name = '%' + searchKey + '%';
        ProductListWrapper proList = new ProductListWrapper();
        list<Product2Wrapper>  Product2Wrapper_List = new list<Product2Wrapper>();
        
        for(product2 ProductRec : [Select id, name,eid__c,description,Price_Information__c, Agreement_Information__c, Requires_Agreement__c,ProductCode,Short_Desc__c,RuleOverride__c,RuleType__c,PriceLists__c, maxServiceResources__c, minServiceResources__c  
                                   from Product2 where Id IN : ProductIDSet and eid__c != null and ProductCode != 'Add-on' and description != 'This Product is No longer available in TRACT' and IsActive = true and name LIKE :name ORDER BY Name ASC]){
                                       Product2Wrapper w = new Product2Wrapper();
                                       w.IsSelected = false;
                                       w.prod = ProductRec;
                                       Product2Wrapper_List.add(w);             
                                   }
        proList.product2WrapperList = Product2Wrapper_List;
        return proList;
    }
    
    @AuraEnabled
    public static list<Product2AddWrapper> getProductDetailLists(product2[] productList, String OpportunityId){
        TRACT_Setup__c tract=[select id,TPassword__c,
                                         Tract_User_Name__c,TRACT_URL__c,
                                         Active__c 
                                         from TRACT_Setup__c WHERE Active__c=true limit 1 ];  
        list<String> PricebookName = new list<String>();
        Map<Id,list<String>> productPriceListMap = new Map<Id,list<String>>();
        opportunity opportunity = [select id,Pricebook2Id,AccountId from Opportunity where id =:OpportunityId ];
        string pricebookId = opportunity.Pricebook2Id;
        pricebook2 pricebook = [select id , name from pricebook2 where ID =:pricebookId ];
        if(pricebook !=null ){ 
            PricebookName = pricebook.name.split(' ');    
        }
        Map<String, Product2> addOnMap = new Map<String, Product2>();    
        for (product2 pro : [Select id, name,eid__c,description, ProductCode,Price_Information__c,Agreement_Information__c, Requires_Agreement__c, Short_Desc__c,RuleOverride__c,RuleType__c,PriceLists__c, maxServiceResources__c, minServiceResources__c, Serialized__c  
                             from Product2  where (ProductCode = 'Add-on' OR ProductCode = 'ADD-ON') and eid__c != null and description != 'This Product is No longer available in TRACT' and IsActive = true ORDER BY Name ASC]) {
             addOnMap.put(pro.eid__c, pro);
        }
        map<decimal,OpportunityLineItem> opLIMAp = new map<decimal,OpportunityLineItem>();
        for(OpportunityLineItem oli : [select eid__c,productEid__c,Quantity, Service_Resource__c, minServiceResources__c,
                                      username__c, firstname__c ,lastname__c ,Email__c ,
                                      New_Service_Resource__c, RecurringPrice__c, OneTimePrice__c, 
                                      PricebookEntryId,Applied_Agreement_Eid__c
                                      FROM OpportunityLineItem  WHERE OpportunityId =: OpportunityId limit 50000]){
            opLIMAp.put(oli.productEid__c , oli);  
        }
        list<Product2AddWrapper> SelectedProductWrapper_List = new list<Product2AddWrapper>();
        Integer counter = 0;
        for(product2 product : productList){
            list<String> priceListEidList = new list<String>();
            list<ProductPriceWrapper> listProductPrice = (list<ProductPriceWrapper>)JSON.deserialize(product.Price_Information__c,list<ProductPriceWrapper>.Class);
            for(ProductPriceWrapper productPriceObj : listProductPrice){
                if(productPriceObj.currencyType == PricebookName[1] && !priceListEidList.contains(productPriceObj.priceListEid)){
                    priceListEidList.add(productPriceObj.priceListEid);
                }
            }
            Product2AddWrapper wrprodRec = new Product2AddWrapper();
            wrprodRec.errorMessage = 'NoError';
            String childErrorMessage = null;
            wrprodRec.prod = product;
            wrprodRec.ProductEid = product.eid__c;
            wrprodRec.RuleType = product.RuleType__c;
            wrprodRec.MinServiceResource = product.minServiceResources__c;
            wrprodRec.MaxServiceResource = product.maxServiceResources__c;
            wrprodRec.RuleOverride = product.RuleOverride__c;
            //query and store pricList for this product
            List<SelectOption> priceListOption = new List<SelectOption>();
            List<SelectOption> recurrencePeriodOption = new List<SelectOption>();
            if(product.PriceLists__c != null){
                for(String priceList : product.PriceLists__c.split(',')){
                    list<String> priceLists = new list<String>(); 
                    priceLists = priceList.split(':');
                    if(priceList != null && priceLists.size()>0){
                        string priceListName = '';
                        string priceListEid = '';
                        if(priceLists[0] != null){
                            priceListName = priceLists[0];
                        }
                        if(priceLists.size()>1){
                            priceListEid =  priceLists[1];
                        }
                        if(priceListEidList.contains(priceListEid)){
                            priceListOption.add(new SelectOption(priceListEid, priceListName));
                        }
                    }
                }
            }
            wrprodRec.productPriceList = priceListOption;
            wrprodRec.RecurrenceoptList = recurrencePeriodOption;
            wrprodRec.PricebookNames = PricebookName;
            if(priceListOption.size()>0){
                wrprodRec.priceListValue = priceListOption[0].getValue();
            }
            String proWrapper = JSON.serialize(wrprodRec);
            wrprodRec = getProductPricesApex(proWrapper);
            wrprodRec.agreements = getProductAgreement(wrprodRec.prod,wrprodRec.PricebookNames[1]);
            Decimal parentProdEid = Decimal.valueOf(wrprodRec.prod.eid__c);
            if(opLIMAp.containsKey(parentProdEid)){
                OpportunityLineItem oli = opLIMAp.get(parentProdEid);
                if(null != oli.RecurringPrice__c && null!=oli.OneTimePrice__c){
                    wrprodRec.totelPriceValue =  String.valueOf((oli.RecurringPrice__c+oli.OneTimePrice__c).setScale(2));
                }if(null != oli.RecurringPrice__c){
                    wrprodRec.totelPriceValue =  String.valueOf((oli.RecurringPrice__c ).setScale(2));
                }else if(null != oli.OneTimePrice__c){
                    wrprodRec.totelPriceValue =  String.valueOf((oli.OneTimePrice__c).setScale(2));
                }else if(null != wrprodRec.Recurringprice && null!=wrprodRec.OneTimePrice){
                    wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.Recurringprice+wrprodRec.OneTimePrice).setScale(2));
                }else{
                    if(null != wrprodRec.Recurringprice){
                        wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.Recurringprice).setScale(2));
                    }else{
                        wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.OneTimePrice).setScale(2));
                    }
                }
                wrprodRec.agreementId = oli.Applied_Agreement_Eid__c;
            }else{
                if(null != wrprodRec.Recurringprice && null!=wrprodRec.OneTimePrice){
                    wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.Recurringprice+wrprodRec.OneTimePrice).setScale(2));                 
                }else if(null != wrprodRec.Recurringprice){
                    wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.Recurringprice).setScale(2));
                }else if(null != wrprodRec.OneTimePrice){
                    wrprodRec.totelPriceValue =  String.valueOf((wrprodRec.OneTimePrice).setScale(2));
                }
            }
            wrprodRec = setOrderCurrencyType(JSON.serialize(wrprodRec));
            Set<String> childEidList = getRelatedProduct(product.eid__c);
            List<Product2> childProducts = new  List<Product2>(); 
            for(String child : childEidList){
                if(addOnMap.get(child) != null){
                    childProducts.add(addOnMap.get(child));
                }
            }
            wrprodRec.childProducts = new List<Product2AddWrapper>();
            for(Product2 childProduct : childProducts){
                list<String> childPriceListEidList = new list<String>();
                list<ProductPriceWrapper> listChildProductPrice = (list<ProductPriceWrapper>)JSON.deserialize(childProduct.Price_Information__c,list<ProductPriceWrapper>.Class);
                for(ProductPriceWrapper productPriceObj : listChildProductPrice){
                    if(productPriceObj.currencyType == PricebookName[1] && !childPriceListEidList.contains(productPriceObj.priceListEid)){
                        childPriceListEidList.add(productPriceObj.priceListEid);
                    }
                }
                Product2AddWrapper wrprodRecChild = new Product2AddWrapper();
                wrprodRecChild.errorMessage = 'NoError';
                wrprodRecChild.Quantity = 0;
                wrprodRecChild.prod = childProduct;
                wrprodRecChild.ProductEid = childProduct.eid__c;
                wrprodRecChild.service = product.Id;
                wrprodRecChild.serialized = product.Serialized__c;
                //query and store pricList for this product
                List<SelectOption> priceListOptionChild = new List<SelectOption>();
                List<SelectOption> recurrencePeriodOptionChild = new List<SelectOption>();
                if(childProduct.PriceLists__c != null){
                    for(String priceList : childProduct.PriceLists__c.split(',')){
                        if(priceList != null){
                            list<String> priceLists = new list<String>(); 
                            priceLists = priceList.split(':');
                            if(priceList != null && priceLists.size()>0){
                                string priceListName = '';
                                string priceListEid = '';
                                if(priceLists[0] != null){
                                    priceListName = priceLists[0];
                                }
                                if(priceLists.size()>1){
                                    priceListEid =  priceLists[1];
                                }
                                if(childPriceListEidList.contains(priceListEid)){
                                    priceListOptionChild.add(new SelectOption(priceListEid, priceListName));
                                }
                            }
                        }
                    }
                }
                wrprodRecChild.productPriceList = priceListOptionChild;
                wrprodRecChild.RecurrenceoptList = recurrencePeriodOptionChild;
                wrprodRecChild.PricebookNames = PricebookName;
                if(priceListOptionChild.size() > 0){
                    wrprodRecChild.priceListValue = priceListOptionChild[0].getValue();
                }
                String proWrapperChild = JSON.serialize(wrprodRecChild);
                wrprodRecChild = getProductPricesApex(proWrapperChild);
                if(wrprodRecChild.errorMessage != 'NoError'){
                    // error occured, so the AddOn will not be added to cart
                    break;
                }
                wrprodRecChild = setOrderCurrencyType(JSON.serialize(wrprodRecChild));
                wrprodRecChild.agreements = getProductAgreement(childProduct,wrprodRecChild.PricebookNames[1]);
                Decimal prodEid = Decimal.valueOf(wrprodRecChild.prod.eid__c);
                if(opLIMAp.containsKey(prodEid)){
                    OpportunityLineItem oli = opLIMAp.get(prodEid);
                    wrprodRecChild.Quantity = Integer.valueOf(oli.Quantity);
                    if(null != oli.RecurringPrice__c){
                        wrprodRecChild.totelPriceValue =  String.valueOf((oli.RecurringPrice__c * oli.Quantity).setScale(2));
                    }else{
                        wrprodRecChild.totelPriceValue =  String.valueOf((wrprodRecChild.Recurringprice * oli.Quantity).setScale(2));
                    }
                    wrprodRecChild = setOrderCurrencyType(JSON.serialize(wrprodRecChild));
                    wrprodRecChild.agreementId = oli.Applied_Agreement_Eid__c;
                }
                wrprodRec.childProducts.add(wrprodRecChild);
            }
            SelectedProductWrapper_List.add(wrprodRec);  
        }
        return SelectedProductWrapper_List;
    }
    
    @AuraEnabled
    public static list<Product2AddWrapper> getProductDetailListsExisting(String OpportunityId){
        APIDataService dataService = GTVDataService.getService(); 
        Map<Id,list<String>> productPriceListMap = new Map<Id,list<String>>();
        Opportunity opportunity= [select id,pricebook2.Name,Pricebook2Id,AccountId,Tract_Sales_Order__c, Account.Tract_Billing_Account__c, Account.Currency_Type__c from Opportunity where id =:OpportunityId limit 1];
        map<decimal,OpportunityLineItem> opLIMAp = new map<decimal,OpportunityLineItem>();
        OpportunityLineItem[] opLI = [select eid__c,productEid__c,Quantity, Service_Resource__c, minServiceResources__c,
                                      username__c, firstname__c ,lastname__c ,Email__c ,
                                      New_Service_Resource__c, RecurringPrice__c, OneTimePrice__c, 
                                      PricebookEntryId, Applied_Agreement_Eid__c
                                      FROM OpportunityLineItem 
                                      WHERE OpportunityId =: OpportunityId
                                      limit 50000];
        for(OpportunityLineItem oli : opLI){
            opLIMAp.put(oli.productEid__c , oli);  
        }  
        list<String> PricebookName = new list<String>();
        string pricebookId = opportunity.Pricebook2Id;
        
        if(pricebookId == null){
            for(Pricebook2 pricebook : [SELECT id,Name FROM Pricebook2]){
                if(pricebook.Name.contains(opportunity.Account.Currency_Type__c)){
                    pricebookId = pricebook.Id;
                }
            }
        }
        pricebook2 pricebook = [select id , name from pricebook2 where ID =:pricebookId ];
        if(pricebook !=null ){ 
            PricebookName = pricebook.name.split(' ');    
        }
        List<Account> accList = [Select name,id,Tract_Billing_Account__c from Account where id =: opportunity.AccountId limit 1];
        
        Map<String, Product2> addOnMap = new Map<String, Product2>();    
        for (product2 pro : [Select id, name,eid__c,description,Price_Information__c, Agreement_Information__c, Requires_Agreement__c, ProductCode,Short_Desc__c,RuleOverride__c,RuleType__c,PriceLists__c, maxServiceResources__c, minServiceResources__c  
                             from Product2  where ProductCode = 'Add-on' and eid__c!=null and description != 'This Product is No longer available in TRACT' and IsActive = true ORDER BY Name ASC])
         {
             addOnMap.put(pro.eid__c, pro);
         }
        List<Service__c> servicesList = new List<Service__c>(); 
        if(accList[0] != null && accList[0].Tract_Billing_Account__c != null){
            TractServiceWrapper serviceWrapperObj = dataService.getServiceByBillingAccount(accList);
            servicesList = serviceWrapperObj.serviceList;
        } 
        Set<String> productEid = new Set<String>();
        Map<String, Service__c> productQuantityVSEidMap = new Map<String, Service__c>();
        Map<String, String> productServiceVSEidMap = new Map<String, String>();
        list<String> agreementEidList = new list<String>();
        map<String,String> prodIdvsAgreementIdMap = new map<String,String>();
        
        for(Service__c srv : servicesList){
            productEid.add(srv.ProductEid__c);
            productQuantityVSEidMap.put(srv.ProductEid__c, srv);
            productServiceVSEidMap.put(srv.ProductEid__c, srv.ServiceEid__c);
            agreementEidList.add(srv.Service_Agreement__c);
            prodIdvsAgreementIdMap.put(srv.ProductEid__c,srv.Service_Agreement__c);
        }
       
        List<product2> productList =  [Select id, name,eid__c,description,ProductCode,Short_Desc__c, Agreement_Information__c, Requires_Agreement__c, RuleOverride__c,RuleType__c,Price_Information__c,PriceLists__c, maxServiceResources__c, minServiceResources__c  
                                       from Product2 where eid__c IN : productEid and eid__c!=null and ProductCode != 'Add-on' and description != 'This Product is No longer available in TRACT' and IsActive = true ORDER BY Name ASC]; 
        list<Product2AddWrapper> SelectedProductWrapper_List = new list<Product2AddWrapper>();
        Integer counter = 0;
        for(product2 product : productList){
            list<String> priceListEidList = new list<String>();
            list<ProductPriceWrapper> listProductPrice = (list<ProductPriceWrapper>)JSON.deserialize(product.Price_Information__c,list<ProductPriceWrapper>.Class);
            for(ProductPriceWrapper productPriceObj : listProductPrice){
                if(productPriceObj.currencyType == PricebookName[1] && !priceListEidList.contains(productPriceObj.priceListEid)){
                    priceListEidList.add(productPriceObj.priceListEid);
                }
            }
            Product2AddWrapper wrprodRec = new Product2AddWrapper();
            wrprodRec.prod = product;
            wrprodRec.existing = true;
            //query and store pricList for this product
            List<SelectOption> priceListOption = new List<SelectOption>();
            List<SelectOption> recurrencePeriodOption = new List<SelectOption>();
            if(product.PriceLists__c != null){
                for(String priceList : product.PriceLists__c.split(',')){
                    if(priceList != null){
                        list<String> priceLists = new list<String>(); 
                        priceLists = priceList.split(':');
                        if(priceList != null && priceLists.size()>0){
                            string priceListName = '';
                            string priceListEid = '';
                            if(priceLists[0] != null){
                                priceListName = priceLists[0];
                            }
                            if(priceLists.size()>1){
                                priceListEid =  priceLists[1];
                            }
                            if(priceListEidList.contains(priceListEid)){
                                priceListOption.add(new SelectOption(priceListEid, priceListName));
                            }
                        }
                    }
                }
            }
            wrprodRec.productPriceList = priceListOption;
            wrprodRec.RecurrenceoptList = recurrencePeriodOption;
            wrprodRec.PricebookNames = PricebookName;
            wrprodRec.priceListValue = priceListOption[0].getValue();
            String proWrapper = JSON.serialize(wrprodRec);
            wrprodRec = getProductPricesApex(proWrapper);
            wrprodRec = setOrderCurrencyType(JSON.serialize(wrprodRec));
            wrprodRec.agreements = getProductAgreement(wrprodRec.prod,wrprodRec.PricebookNames[1]);
            if(prodIdvsAgreementIdMap.containsKey(wrprodRec.prod.eid__c)){
                wrprodRec.agreementId = prodIdvsAgreementIdMap.get(wrprodRec.prod.eid__c);
            }
            if(productQuantityVSEidMap.containsKey(wrprodRec.prod.eid__c)){
                wrprodRec.totelPriceValue =  String.valueOf(productQuantityVSEidMap.get(wrprodRec.prod.eid__c).Service_Amount__c);
            }
            Set<String> childEidList = getRelatedProduct(product.eid__c);
            List<Product2> childProducts = new  List<Product2>(); 
            for(String child : childEidList){
                if(addOnMap.get(child) != null){
                    childProducts.add(addOnMap.get(child));
                }
            }
            wrprodRec.childProducts = new List<Product2AddWrapper>();
            for(Product2 childProduct : childProducts){
                list<String> childPriceListEidList = new list<String>();
                list<ProductPriceWrapper> listChildProductPrice = (list<ProductPriceWrapper>)JSON.deserialize(childProduct.Price_Information__c,list<ProductPriceWrapper>.Class);
                for(ProductPriceWrapper productPriceObj : listChildProductPrice){
                    if(productPriceObj.currencyType == PricebookName[1] && !childPriceListEidList.contains(productPriceObj.priceListEid)){
                        childPriceListEidList.add(productPriceObj.priceListEid);
                    }
                }
                Product2AddWrapper wrprodRecChild = new Product2AddWrapper();
                if(productQuantityVSEidMap.containsKey(childProduct.eid__c)){
                    wrprodRecChild.Quantity = Integer.valueOf(productQuantityVSEidMap.get(childProduct.eid__c).Quantity__c);
                    wrprodRecChild.existing = true;
                    wrprodRecChild.serviceEid = productQuantityVSEidMap.get(childProduct.eid__c).ServiceEid__c;
                }else{
                    wrprodRecChild.Quantity = 0;
                }
                wrprodRecChild.parentServiceEId = productServiceVSEidMap.get(product.eid__c);
                wrprodRecChild.prod = childProduct;
                wrprodRecChild.service = product.Id;
                //query and store pricList for this product
                List<SelectOption> priceListOptionChild = new List<SelectOption>();
                List<SelectOption> recurrencePeriodOptionChild = new List<SelectOption>();
                if(childProduct.PriceLists__c != null){
                    for(String priceList : childProduct.PriceLists__c.split(',')){
                        if(priceList != null){
                            list<String> priceLists = new list<String>(); 
                            priceLists = priceList.split(':');
                            if(priceList != null && priceLists.size()>0){
                                string priceListName = '';
                                string priceListEid = '';
                                if(priceLists[0] != null){
                                    priceListName = priceLists[0];
                                }
                                if(priceLists.size()>1){
                                    priceListEid =  priceLists[1];
                                }
                                if(childPriceListEidList.contains(priceListEid)){
                                    priceListOptionChild.add(new SelectOption(priceListEid, priceListName));
                                }
                            }
                        }
                    }
                }
                wrprodRecChild.productPriceList = priceListOptionChild;
                wrprodRecChild.RecurrenceoptList = recurrencePeriodOptionChild;
                wrprodRecChild.PricebookNames = PricebookName;
                wrprodRecChild.priceListValue = priceListOptionChild[0].getValue();
                String proWrapperChild = JSON.serialize(wrprodRecChild);
                wrprodRecChild = getProductPricesApex(proWrapperChild);
                wrprodRecChild = setOrderCurrencyType(JSON.serialize(wrprodRecChild));
                wrprodRecChild.agreements = getProductAgreement(childProduct,wrprodRecChild.PricebookNames[1]);
                if(prodIdvsAgreementIdMap.containsKey(wrprodRecChild.prod.eid__c)){
                    wrprodRecChild.agreementId = prodIdvsAgreementIdMap.get(wrprodRecChild.prod.eid__c);
                }
                if(productQuantityVSEidMap.containsKey(childProduct.eid__c)){
                    wrprodRecChild.totelPriceValue =  String.valueOf(productQuantityVSEidMap.get(childProduct.eid__c).Service_Amount__c);
                }
                Decimal prodEid = Decimal.valueOf(wrprodRecChild.prod.eid__c);
                if(opLIMAp.containsKey(prodEid)){
                    OpportunityLineItem oli = opLIMAp.get(prodEid);
                    wrprodRecChild.Quantity = Integer.valueOf(oli.Quantity);
                    if(null != oli.RecurringPrice__c){
                        wrprodRecChild.totelPriceValue =  String.valueOf((oli.RecurringPrice__c * oli.Quantity).setScale(2));
                    }else{
                        wrprodRecChild.totelPriceValue =  String.valueOf((wrprodRecChild.Recurringprice * oli.Quantity).setScale(2));
                    }
                    wrprodRecChild = setOrderCurrencyType(JSON.serialize(wrprodRecChild));
                    wrprodRecChild.agreementId = oli.Applied_Agreement_Eid__c;
                }
                wrprodRec.childProducts.add(wrprodRecChild);
            }
            SelectedProductWrapper_List.add(wrprodRec);  
        }
        opportunity.Pricebook2Id = pricebookId;
        update opportunity;
        return SelectedProductWrapper_List;
    }
    
   @AuraEnabled
    public static Product2AddWrapper getProductPricesApex(String productWrapperString ){
        Product2AddWrapper productWrapper = (Product2AddWrapper)JSON.deserialize(productWrapperString, Product2AddWrapper.class);
        String priceListValue = productWrapper.priceListValue;
        String errorMessage = 'Price Not Available';
        Boolean disableRecurring = false;
        Boolean disableonetime = false;
        Boolean scheduleChargeEnable;
        Boolean oneTimeChargeEnable;
        Map<String, Decimal> idAndPriceValueMap = new Map<String, Decimal>();
        map<String, List<ProductPriceRangeWrapper>> priceVsPriceRanges = new map<String, List<ProductPriceRangeWrapper>>();
        Decimal recurringprice;
        Decimal oneTimePrice;
        if(priceListValue != '' && priceListValue != null) {
            List<SelectOption> opListrecurringNew = new List<SelectOption>();
            list<ProductPriceWrapper> listProductPrice = (list<ProductPriceWrapper>)JSON.deserialize(productWrapper.prod.Price_Information__c,list<ProductPriceWrapper>.class);
            for(ProductPriceWrapper productPriceObj : listProductPrice){
                if(productPriceObj.priceListEid == priceListValue){
                    if(productPriceObj.priceType == 'Recurring'){
                        if(productPriceObj.currencyType == productWrapper.PricebookNames[1]){
                            errorMessage = 'NoError';
                            scheduleChargeEnable = productPriceObj.scheduledCharges;
                            if(productPriceObj.thruDate!=null){
                                Date myDate =  date.newinstance(productPriceObj.thruDate.year(),productPriceObj.thruDate.month(),productPriceObj.thruDate.day());
                                if(myDate > Date.Today()){
                                    opListrecurringNew.add(new SelectOption(productPriceObj.eid , productPriceObj.recurrencePeriod)); 
                                }  
                            }else if(productPriceObj.thruDate==null){
                                opListrecurringNew.add(new SelectOption(productPriceObj.eid , productPriceObj.recurrencePeriod)); 
                            } else{
                                opListrecurringNew.add(new SelectOption(''  ,'No Rec Period'));
                            }
                            disableRecurring = productPriceObj.priceOverride;
                            priceVsPriceRanges.put(productPriceObj.eid, productPriceObj.priceRangesList);
                            for(ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList){
                                if(recurringprice == null ){
                                    recurringprice = productPriceRangeObj.price;  
                                }
                                idAndPriceValueMap.put(productPriceObj.eid , productPriceRangeObj.price);
                            }
                        }
                    }
                    if(productPriceObj.priceType == 'OneTime'){
                        if(productPriceObj.currencyType == productWrapper.PricebookNames[1]){
                            errorMessage = 'NoError';
                            oneTimeChargeEnable = productPriceObj.scheduledCharges;
                            disableonetime = productPriceObj.priceOverride;
                            for(ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList){
                                oneTimePrice = productPriceRangeObj.price;
                                break;
                            }
                        }
                    }
                }
            }
            productWrapper.disableRecurring = disableRecurring;
            productWrapper.disableonetime = disableonetime;
            productWrapper.scheduleChargeEnable = scheduleChargeEnable;
            productWrapper.oneTimeChargeEnable = oneTimeChargeEnable;
            productWrapper.IdAndPriceValueMap = idAndPriceValueMap;
            productWrapper.Recurringprice = recurringprice;
            productWrapper.OneTimePrice = oneTimePrice;
            productWrapper.priceVsPriceRanges = priceVsPriceRanges;
            productWrapper.errorMessage = errorMessage;
            if(productWrapper.OneTimePrice != null && productWrapper.Recurringprice != null){
                productWrapper.totelPriceValue = String.valueOf((productWrapper.Recurringprice + productWrapper.OneTimePrice) * productWrapper.Quantity);
            }else if(productWrapper.OneTimePrice != null){
                productWrapper.totelPriceValue = String.valueOf(productWrapper.OneTimePrice * productWrapper.Quantity);
            }else if(productWrapper.Recurringprice != null){
                productWrapper.totelPriceValue = String.valueOf(productWrapper.Recurringprice * productWrapper.Quantity);
            }
            productWrapper.RecurrenceoptList = opListrecurringNew;
            if(productWrapper.DisableRecurring){
                if(!opListrecurringNew.isEmpty()){
                    productWrapper.Recurringprice =productWrapper.IdAndPriceValueMap.get(opListrecurringNew[0].getValue());
                    productWrapper.RecurrencPerValue = opListrecurringNew[0].getValue();
                }
            }
        }
        return productWrapper;  
    } 
    
    @AuraEnabled
    public static Product2AddWrapper getpriceRangeValue(String productWrapperString ){
        TRACT_Setup__c tract =[select id, TPassword__c,
                             Tract_User_Name__c,TRACT_URL__c,
                             Active__c 
                             from TRACT_Setup__c WHERE Active__c=true limit 1 ];
        Product2AddWrapper productWrapper = (Product2AddWrapper)JSON.deserialize(productWrapperString, Product2AddWrapper.class);
        String priceEid = productWrapper.RecurrencPerValue;
        List<ProductPriceRangeWrapper> priceRanges = productWrapper.priceVsPriceRanges.get(priceEid);
        Integer quantity = Integer.valueOf(productWrapper.Quantity);
        for(ProductPriceRangeWrapper prange : priceRanges){
            if((quantity >= prange.quantityBeginRange && quantity <= prange.quantityEndRange) || (prange.quantityEndRange == null && quantity >= prange.quantityBeginRange)){
                productWrapper.priceRangeValue = prange.price.setScale(2);
                productWrapper.Recurringprice = productWrapper.priceRangeValue;
            }
        }
        productWrapper.totelPriceValue = String.valueOf((productWrapper.priceRangeValue * productWrapper.Quantity).setScale(2));
        productWrapper = setOrderCurrencyType(JSON.serialize(productWrapper));
        return productWrapper;
    }     
    
    @AuraEnabled
    public static Agreementwrapper getProductAgreement(product2 prod,String currencyType){
        Agreementwrapper agreementWrap = new Agreementwrapper();
        Map<String,Decimal> mapOfAgreementPeriod = new Map<String,Decimal>();
        List<SelectOption> agreementOption = new List<SelectOption>();
        List<SelectOption> renewActionList = new list<SelectOption>();
        if(prod != null){
            list<ProductAgreementWrapper> agreementList = (list<ProductAgreementWrapper>)JSON.deserialize(prod.Agreement_Information__c,list<ProductAgreementWrapper>.class);      
            if(null != agreementList){
                if(agreementList.size() > 0){
                    agreementWrap.hasAgreement = true;
                    if(!prod.Requires_Agreement__c){
                            agreementOption.add(new SelectOption(' ' ,'--None--'));
                    }
                    for(ProductAgreementWrapper ag: agreementList){
                        if(ag.currencyType == currencyType){
                            agreementOption.add(new SelectOption(ag.eid,ag.name));
                            mapOfAgreementPeriod.put(ag.eid, ag.agreementPeriod);
                        }
                        else{
                            agreementWrap.hasAgreement = false;
                        }
                    }
                    renewActionList.add(new SelectOption(' ', '--Choose One--' ));
                    for(TractSFDC_Util.AgreementEndAction endAction : TractSFDC_Util.AgreementEndAction.values()){
                        renewActionList.add(new SelectOption(endAction.name(), TractSFDC_Util.convertToCamelCase(endAction.name(),'_')));
                    }
                }else{
                    agreementOption.add(new SelectOption(' ' ,'--None--'));
                    agreementWrap.hasAgreement = false;
                } 
            }
           
        }
        agreementWrap.agreementList = agreementOption;
        agreementWrap.renewAction = renewActionList;
        agreementWrap.mapOfAgreementPeriod = mapOfAgreementPeriod;
        return agreementWrap;
    } 

    @AuraEnabled
    public static Product2AddWrapper getDisounts(String productWrapperString) {         
        Product2AddWrapper productWrapper;
        APIDataService dataService = GTVDataService.getService();
        productWrapper = (Product2AddWrapper)dataService.getDiscountsQuickAdd(productWrapperString);
        return productWrapper;
    }
    
    @AuraEnabled
    public static  Product2AddWrapper getServiceResource(String productWrapperString) {
        Product2AddWrapper productWrapper = (Product2AddWrapper)JSON.deserialize(productWrapperString, Product2AddWrapper.class);
        productWrapper.errorMessage = 'NoError';
        ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
        APIDataService dataService = GTVDataService.getService();
        srWrapper = dataService.getServiceResourceById(productWrapper.serviceResourceName);
        productWrapper.errorMessage = srWrapper.errorMessage;
        return productWrapper;
    }
    @AuraEnabled
    public static string  saveScheduleCharges(string listOfFilledScheduledCharges, Decimal oneTimevalue, string productEid, String oppId){
        List<Schdeule_Charge__c> listOfFilledScheduledCharges1= ( List<Schdeule_Charge__c>)JSON.deserialize(listOfFilledScheduledCharges, List<Schdeule_Charge__c>.class);
        string discountError = 'NoError';
        Integer j = 0;
        Decimal TotalOneTime = 0.0;
        
        for(Schdeule_Charge__c fieldCheck1:listOfFilledScheduledCharges1){
            if(fieldCheck1.Schdeule_Description__c == null || fieldCheck1.Schdeule_Description__c == '' || 
               fieldCheck1.Schdeule_Amount__c == null || fieldCheck1.Schdeule_Amount__c == '' || 
               String.ValueOf(fieldCheck1.Schdeule_Date__c) == null || String.valueOf(fieldCheck1.Schdeule_Date__c) == ''){
                   j++;
               }
            if(fieldCheck1.Schdeule_Amount__c != null && fieldCheck1.Schdeule_Amount__c != '' && Pattern.matches('^[0-9]*^[0-9.0-9]*$', fieldCheck1.Schdeule_Amount__c)){
                TotalOneTime += Double.valueOf(fieldCheck1.Schdeule_Amount__c);
            }
        }
        
        if(j>0){
            discountError = 'Please enter the value.';
        }
        else if(TotalOneTime != oneTimevalue){
            discountError = 'Total One-Time Charge Amount must equal the Total Amount.';
        }
        else{
            List<Schdeule_Charge__c> addListToInsert = new List<Schdeule_Charge__c>();
            for(Schdeule_Charge__c charges1 : listOfFilledScheduledCharges1) {
                if(null != charges1.Schdeule_Description__c  && charges1.Schdeule_Amount__c  != ''
                   && charges1.Schdeule_Amount__c != null && '' != charges1.Schdeule_Description__c && 
                   String.ValueOf(charges1.Schdeule_Date__c) != null && String.valueOf(charges1.Schdeule_Date__c) != '') {
                       charges1.productEid__c = productEid + oppId; 
                       charges1.Charge_Type__c = 'OneTime';
                       addListToInsert.add(charges1);  
                       
                   }   
            } 
            if(!addListToInsert.isEmpty()){
                insert addListToInsert;
            }
        }
        return  discountError;
    }
    
    @AuraEnabled
    public static List<ProductUsesWrapper> showActivityChargeRule(String activityProductEid, String oppId){     
        List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
        if(null != activityProductEid){
            List<OrderUsageRule__c> orderUsageRuleObjList = new List<OrderUsageRule__c>();
            orderUsageRuleObjList = [Select UsageUom__c, UsageRate__c, UsageRateUom__c, Status__c, RuleType__c, RollOverType__c, RateTypeValue__c, RateTableUsageFieldName__c, RateTableEid__c, ProratedOnOrder__c, ProratedOnCancel__c, ProductUsageValue__c, ProductEid__c, Limit__c, GlobalUsageEid__c, FormulaOperator__c, FormulaFieldvalue__c, FormulaFieldName__c, ChargeCategory__c, ChargeCategoryEid__c, AllowanceType__c, Name, Id,OpportunityID__c From OrderUsageRule__c where ProductEid__c = :activityProductEid AND OpportunityID__c = :oppId];
            for(OrderUsageRule__c orderUsageRuleObj: orderUsageRuleObjList){
                if(orderUsageRuleObj.ProductUsageValue__c == 'Match All Events'){
                    ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
                    productUsesWrapper.ChargeName = orderUsageRuleObj.Name;
                    productUsesWrapper.Rule = 'Matches all';
                    productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c;  
                    productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c;
                    if(null != orderUsageRuleObj.UsageRate__c){  
                        productUsesWrapper.Rate = String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) + ' per ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                        if(orderUsageRuleObj.limit__c > 0)
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() + 's';
                        else  
                            productUsesWrapper.Taper = orderUsageRuleObj.AllowanceType__c + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                    }  
                    if(null != orderUsageRuleObj.RateTableEid__c){
                        productUsesWrapper.Rate = 'Table Rate '+ orderUsageRuleObj.RateTypeValue__c;
                        productUsesWrapper.Taper = orderUsageRuleObj.AllowanceType__c + ' ' + orderUsageRuleObj.RateTableUsageFieldName__c;
                    }  
                    if(null != orderUsageRuleObj.RateTableUsageFieldName__c && orderUsageRuleObj.RateTableUsageFieldName__c != 'Choose One'){  
                        productUsesWrapper.Rate = 'Pass Through '+ orderUsageRuleObj.RateTableUsageFieldName__c;
                        if(orderUsageRuleObj.RateTypeValue__c == 'Flat'){
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() + 's';
                        }else{
                            if(String.valueOf(orderUsageRuleObj.limit__c) != null)
                                productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0));
                        }
                    }  
                    if(null !=  orderUsageRuleObj.Status__c)
                        productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase().capitalize();  
                    RuleOverrides.add(productUsesWrapper);
                }else if(orderUsageRuleObj.ProductUsageValue__c == 'Formula'){
                    ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
                    productUsesWrapper.ChargeName = orderUsageRuleObj.name;
                    productUsesWrapper.Rule = orderUsageRuleObj.FormulaFieldName__c + ' = ' + orderUsageRuleObj.FormulaFieldvalue__c;   
                    productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c;    
                    productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c; 
                    if(null != orderUsageRuleObj.UsageRate__c){  
                        productUsesWrapper.Rate = String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) + ' per ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                        if(orderUsageRuleObj.limit__c > 0)
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() + 's';
                        else  
                            productUsesWrapper.Taper = orderUsageRuleObj.AllowanceType__c + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                    }
                    if(null != orderUsageRuleObj.RateTableEid__c){
                        productUsesWrapper.Rate = 'Table Rate '+ orderUsageRuleObj.RateTypeValue__c;
                        productUsesWrapper.Taper = orderUsageRuleObj.AllowanceType__c + ' ' + orderUsageRuleObj.RateTableUsageFieldName__c;
                    }  
                    if(null != orderUsageRuleObj.RateTableUsageFieldName__c && orderUsageRuleObj.RateTableUsageFieldName__c != 'Choose One'){  
                        productUsesWrapper.Rate = 'Pass Through '+ orderUsageRuleObj.RateTableUsageFieldName__c;
                        if(orderUsageRuleObj.RateTypeValue__c == 'Flat'){
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() + 's';
                        }else{
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0));
                        }
                    }     
                    if(null !=  orderUsageRuleObj.Status__c)
                        productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase().capitalize();  
                    RuleOverrides.add(productUsesWrapper);
                }else{
                    ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
                    productUsesWrapper.ChargeName = orderUsageRuleObj.name;
                    productUsesWrapper.Rule = 'Global';   
                    productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c; 
                    productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c;
                    if(null != orderUsageRuleObj.UsageRate__c){  
                        productUsesWrapper.Rate = String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) + ' per ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                        if(orderUsageRuleObj.limit__c > 0)
                            productUsesWrapper.Taper = String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() + 's';
                        else  
                            productUsesWrapper.Taper = orderUsageRuleObj.AllowanceType__c + ' ' + orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
                    } 
                    if(null !=  orderUsageRuleObj.Status__c)
                        productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase().capitalize();  
                    RuleOverrides.add(productUsesWrapper);
                }
            }
        }
        return RuleOverrides;
    }     
    
    @AuraEnabled
    public static ChargeRulesWrapper getChargeRulesWrapper( ){
        
        TRACT_Setup__c tract = [select id,
                               Tract_User_Name__c,TRACT_URL__c,
                               Active__c, TPassword__c from TRACT_Setup__c WHERE Active__c=true limit 1 ]; 
        
        list<SelectOption> selectStatusList = new list<SelectOption>();
        list<SelectOption> productUsageRuleList = new list<SelectOption>();
        list<SelectOption> rateTypeList = new list<SelectOption>();
        list<SelectOption> chargesPicklist = new list<SelectOption>();
        list<SelectOption> allowanceTypeList = new list<SelectOption>();
        list<SelectOption> roleOverList = new list<SelectOption>();
        list<SelectOption> formulaField = new list<SelectOption>();
        list<SelectOption> operationList = new list<SelectOption>();
        list<SelectOption> passThroughChargeList = new list<SelectOption>();
        
        selectStatusList.add(new SelectOption('Draft','Draft'));
        selectStatusList.add(new SelectOption('Active','Active'));
        
        productUsageRuleList.add(new SelectOption('Match All Events','Match All Events'));
        productUsageRuleList.add(new SelectOption('Formula','Formula'));
        productUsageRuleList.add(new SelectOption('Global','Global'));
        
        rateTypeList.add(new SelectOption('Flat','Flat'));
        rateTypeList.add(new SelectOption('Table Rate','Table Rate'));
        rateTypeList.add(new SelectOption('Pass Through','Pass Through'));
        
        
        chargesPicklist.add(new SelectOption('Choose One','Choose One'));
        chargesPicklist.add(new SelectOption('Millisecond','Millisecond'));
        chargesPicklist.add(new SelectOption('Second','Second'));
        chargesPicklist.add(new SelectOption('Minute','Minute'));
        chargesPicklist.add(new SelectOption('Hour','Hour'));
        chargesPicklist.add(new SelectOption('Day','Day'));
        chargesPicklist.add(new SelectOption('Week','Week'));
        chargesPicklist.add(new SelectOption('Event','Event'));
        chargesPicklist.add(new SelectOption('Byte','Byte'));
        chargesPicklist.add(new SelectOption('Kilobyte','Kilobyte'));
        chargesPicklist.add(new SelectOption('Megabyte','Megabyte'));
        chargesPicklist.add(new SelectOption('Gigabyte','Gigabyte'));
        chargesPicklist.add(new SelectOption('Terabyte','Terabyte'));
        chargesPicklist.add(new SelectOption('Count','Count'));
        chargesPicklist.add(new SelectOption('Currency','Currency'));
        chargesPicklist.add(new SelectOption('BITS_PER_SECOND','Bits/Second'));
        chargesPicklist.add(new SelectOption('KILOBITS_PER_SECOND','Kilobits/Second'));
        chargesPicklist.add(new SelectOption('MEGABITS_PER_SECOND','Megabits/Second'));
        chargesPicklist.add(new SelectOption('GIGABITS_PER_SECOND','Gigabits/Second'));
        
        formulaField.add(new SelectOption('Choose One','Choose One'));
        formulaField.add(new SelectOption('text01','text01'));
        formulaField.add(new SelectOption('text02','text02'));
        formulaField.add(new SelectOption('text03','text03'));
        formulaField.add(new SelectOption('text04','text04'));
        formulaField.add(new SelectOption('text05','text05'));
        formulaField.add(new SelectOption('number01','number01'));
        formulaField.add(new SelectOption('number02','number02'));
        formulaField.add(new SelectOption('number03','number03'));
        formulaField.add(new SelectOption('number04','number04'));
        formulaField.add(new SelectOption('number05','number05'));
        formulaField.add(new SelectOption('boolean01','boolean01'));
        formulaField.add(new SelectOption('boolean02','boolean02'));
        formulaField.add(new SelectOption('boolean03','boolean03'));
        formulaField.add(new SelectOption('boolean04','boolean04'));
        formulaField.add(new SelectOption('boolean05','boolean05'));
        formulaField.add(new SelectOption('date01','date01'));
        formulaField.add(new SelectOption('date02','date02'));
        formulaField.add(new SelectOption('date03','date03'));
        formulaField.add(new SelectOption('date04','date04'));
        formulaField.add(new SelectOption('date05','date05'));
        
        passThroughChargeList.add(new SelectOption('Choose One','Choose One'));
        passThroughChargeList.add(new SelectOption('number01','number01'));
        passThroughChargeList.add(new SelectOption('number02','number02'));
        passThroughChargeList.add(new SelectOption('number03','number03'));
        passThroughChargeList.add(new SelectOption('number04','number04'));
        passThroughChargeList.add(new SelectOption('number05','number05'));
        
        operationList.add(new SelectOption('Choose One','Choose One'));
        operationList.add(new SelectOption('Equals','='));
        operationList.add(new SelectOption('NotEquals','<>'));
        operationList.add(new SelectOption('GreaterThan','>'));
        operationList.add(new SelectOption('GreaterThanEquals','>='));
        operationList.add(new SelectOption('LessThan','<'));
        operationList.add(new SelectOption('LessThanEquals','<='));
        operationList.add(new SelectOption('Lookup','Lookup'));
        
        allowanceTypeList.add(new SelectOption('Recurring','Recurring'));
        allowanceTypeList.add(new SelectOption('Unlimited','Unlimited'));
        allowanceTypeList.add(new SelectOption('OneTime','One Time'));
        
        roleOverList.add(new SelectOption('None','None'));
        roleOverList.add(new SelectOption('Uncapped','Uncapped'));
        
        ChargeRulesWrapper chargeRules = new ChargeRulesWrapper();
        chargeRules.selectStatusList1 = selectStatusList;
        chargeRules.selectStatusListValue = 'Draft';
        chargeRules.productUsageRuleList1 = productUsageRuleList;
        chargeRules.productUsageRuleListValue = 'Match All Events';
        chargeRules.rateTypeList1 = rateTypeList;
        chargeRules.rateTypeListValue = 'Flat';
        chargeRules.chargesPicklist1 = chargesPicklist;
        chargeRules.chargesPicklistValue = ' ';
        chargeRules.allowanceTypeList1 = allowanceTypeList;
        chargeRules.allowanceTypeListValue =  'Recurring';
        chargeRules.roleOverList1 = roleOverList;
        chargeRules.roleOverListValue =  'None';
        chargeRules.formulaField1 = formulaField;
        chargeRules.formulaFieldValue =  ' ';
        chargeRules.operationList1 = operationList;
        chargeRules.operationListValue =  ' ';
        chargeRules.passThroughChargeList1 = passThroughChargeList;
        chargeRules.passThroughChargeListValue =  ' ';
        chargeRules.formulaUsageRuleList = getFormulaUsageRuleSpecificationListMethod();
        chargeRules.formulaUsageRuleListValue =   ' ';
        chargeRules.chargeListBytes = getchargeListBytesMethod();
        chargeRules.chargeListBytesValue =  ' ';
        chargeRules.chargeCategoryList = getchargeCategoryListMethod();
        chargeRules.chargeCategoryListValue = ' ';        
        chargeRules.ServiceUsageRuleName = ' ';
        chargeRules.chargeValue = 0;
        chargeRules.ammountValue = 0;
        chargeRules.ActivityFormulaValue = ' ';
        chargeRules.prorateOnOrder = false;
        chargeRules.prorateOnCancel = false;
        return chargeRules;        
    }
    private static list<SelectOption> getFormulaUsageRuleSpecificationListMethod(){
        list<SelectOption> FormulaUsageRuleSpecificationList = new list<SelectOption>();
        APIDataService dataService = GTVDataService.getService();
        FormulaUsageRuleSpecificationList = (list<SelectOption>)dataService.getAllGlobalUsageRule();
        return FormulaUsageRuleSpecificationList;
        
    }
    
    private static list<SelectOption> getchargeListBytesMethod(){
        
        list<SelectOption> chargeListBytes = new list<SelectOption>();
        APIDataService dataService = GTVDataService.getService();
        chargeListBytes = (list<SelectOption>)dataService.getAllChargeBytes();
        return chargeListBytes;
    }
    
    private static list<selectOption> getchargeCategoryListMethod(){
        
        list<SelectOption> chargeCategoryList = new list<SelectOption>();
        APIDataService dataService = GTVDataService.getService();
        chargeCategoryList = (list<SelectOption>)dataService.getAllChargeCategory();
        return chargeCategoryList;
    }
    
    @AuraEnabled
    public static String createNewActivityChargeRule (string serviceWrapperString, String activityProductEid, string checkRuleTypeValue){
        ChargeRulesWrapper chargeRuleWrapper = (ChargeRulesWrapper)JSON.deserialize(serviceWrapperString, ChargeRulesWrapper.class);
        String productUsageValue = chargeRuleWrapper.productUsageRuleListValue;
        String chargeCategoryValue =  chargeRuleWrapper.chargeCategoryListValue;
        String allowanceValue =  chargeRuleWrapper.allowanceTypeListValue;
        String amoutChargeSelect =  chargeRuleWrapper.chargesPicklistValue;
        String StatusValue =  chargeRuleWrapper.selectStatusListValue;
        String rateTypeValue =  chargeRuleWrapper.rateTypeListValue;
        String selectedCharge =  chargeRuleWrapper.chargesPicklistValue;
        String chargeListByteValue =  chargeRuleWrapper.chargeListBytesValue;
        String chargeFormulaFieldValue =  chargeRuleWrapper.formulaFieldValue;
        String passThroughListValue =  chargeRuleWrapper.passThroughChargeListValue;
        String fieldvalue =  chargeRuleWrapper.formulaFieldValue;
        String selectedChargeGlobal =  chargeRuleWrapper.chargesPicklistValue;
        String rollOverValue =  chargeRuleWrapper.roleOverListValue;
        String serviceUsageRuleName =  chargeRuleWrapper.ServiceUsageRuleName;
        String prorateOnOrder = String.valueOf(chargeRuleWrapper.prorateOnOrder);
        String prorateOnCancel =  String.valueOf(chargeRuleWrapper.prorateOnCancel);
        Double ammountValue =  chargeRuleWrapper.ammountValue;
        String activityFormulaValue =  chargeRuleWrapper.ActivityFormulaValue;
        Decimal chargeValue =  chargeRuleWrapper.chargeValue;
        OrderUsageRule__c storeUsageRuleValue = new OrderUsageRule__c();
        String Emessage = 'NoError';
        storeUsageRuleValue.ProductEid__c = activityProductEid;
        storeUsageRuleValue.ProductUsageValue__c = productUsageValue;
        if(productUsageValue == 'Match All Events'){  
            if(null != chargeCategoryValue){
                storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
            }
            storeUsageRuleValue.name = serviceUsageRuleName;
            storeUsageRuleValue.AllowanceType__c = allowanceValue;
            storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
            storeUsageRuleValue.Status__c = StatusValue.toUppercase();
            storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
            storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
            storeUsageRuleValue.Limit__c = ammountValue;
            storeUsageRuleValue.RollOverType__c = rollOverValue;
            storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
            storeUsageRuleValue.RateTypeValue__c = rateTypeValue;
            if(rateTypeValue == 'Flat'){
                storeUsageRuleValue.UsageRateUom__c =  selectedCharge.toUppercase();
                storeUsageRuleValue.UsageRate__c = chargeValue;  
            }
            else if(rateTypeValue == 'Table Rate'){
                storeUsageRuleValue.RateTableEid__c = chargeListByteValue;
                storeUsageRuleValue.RateTableUsageFieldName__c = chargeFormulaFieldValue;
            }
            else {
                storeUsageRuleValue.RateTableUsageFieldName__c = passThroughListValue;
            }
        }
        else if(productUsageValue == 'Formula'){
            if(null != chargeCategoryValue){
                storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
            }
            storeUsageRuleValue.name = serviceUsageRuleName;
            storeUsageRuleValue.FormulaFieldName__c = fieldvalue;
            storeUsageRuleValue.FormulaOperator__c = chargeRuleWrapper.operationListValue;
            storeUsageRuleValue.FormulaFieldvalue__c = activityFormulaValue;
            storeUsageRuleValue.AllowanceType__c = allowanceValue;
            if(amoutChargeSelect != 'Choose One'){
                storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
            }
            if(selectedChargeGlobal != 'Choose One'){
                storeUsageRuleValue.UsageUom__c = selectedChargeGlobal.toUpperCase();
            }
            storeUsageRuleValue.Status__c = StatusValue.toUppercase();
            storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
            storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
            storeUsageRuleValue.Limit__c = ammountValue;
            storeUsageRuleValue.RollOverType__c = rollOverValue;
            storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
            storeUsageRuleValue.RateTypeValue__c = rateTypeValue;
            if(rateTypeValue == 'Flat'){
                storeUsageRuleValue.UsageRateUom__c = selectedCharge.toUppercase();
                storeUsageRuleValue.UsageRate__c = chargeValue;
            }
            else if(rateTypeValue == 'Table Rate'){
                storeUsageRuleValue.RateTableEid__c = chargeListByteValue;
                storeUsageRuleValue.RateTableUsageFieldName__c = chargeFormulaFieldValue;
            }
            else {
                storeUsageRuleValue.RateTableUsageFieldName__c = passThroughListValue;
            }
        }
        else{
            if(null != chargeCategoryValue){
                storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
            }
            storeUsageRuleValue.GlobalUsageEid__c = chargeRuleWrapper.formulaUsageRuleListValue;
            storeUsageRuleValue.name = serviceUsageRuleName;
            storeUsageRuleValue.AllowanceType__c = allowanceValue;
            if(allowanceValue == 'Unlimited'){
                storeUsageRuleValue.UsageUom__c =  selectedChargeGlobal.toUpperCase();
            }
            else{
                storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
            }
            storeUsageRuleValue.Status__c = StatusValue.toUppercase();
            storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
            storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
            storeUsageRuleValue.Limit__c = ammountValue;
            storeUsageRuleValue.RollOverType__c = rollOverValue;
            storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
            
        }
        insert storeUsageRuleValue;
        
        return Emessage;
        
    }
    /**
    ** @param productWrapperString - serialized list of parent products
    ** @param childProductWrapperString - serialized list of child products, we have created two seperate list to tract the changes in child
    ** parent products as well. The component showing several anomalies while having child and parent products in same list.
    **/
    @AuraEnabled
    public static  ProductListWrapper createSalesOrderApex (string productWrapperString, String OpportunityId, String childProductWrapperString){
        String Terrormessage = 'NoError';
        String priceBookName;
        ProductListWrapper listWrapper = new ProductListWrapper();
        List<Product2AddWrapper> productWrapperList = (List<Product2AddWrapper>)JSON.deserialize(productWrapperString, List<Product2AddWrapper>.class);
        List<Product2AddWrapper> childProductWrapperList = (List<Product2AddWrapper>)JSON.deserialize(childProductWrapperString, List<Product2AddWrapper>.class);
        TRACT_Setup__c tract;
        List<opportunityLineItem> OLI_List_to_Insert = new List<opportunityLineItem>();
        try {
            tract  = [select id,   Tract_User_Name__c,TPassword__c, 
                      TRACT_URL__c,  
                      Active__c, OrderStatus__c from TRACT_Setup__c
                      WHERE Active__c = true limit 1 ];
        }
        
        catch(Exception e){
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            listWrapper.errorMessage = Terrormessage;
            return listWrapper; 
        }
        if(tract == null)
        {  
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }
        Opportunity thisOpp = [SELECT Id,Name,Account.Name,Amount,CloseDate, Description,Owner.Name,TotalOpportunityQuantity,
                               Probability,StageName,Type,Campaign.Name,LeadSource,NextStep,Tract_Sales_Order__c,Pricebook2Id,
                               Account.Tract_Billing_Account__c,ExpectedRevenue,FiscalQuarter,Fiscal,
                               FiscalYear,ForecastCategory,ForecastCategoryName,LastActivityDate, Order_Date__c,
                               IsWon,IsDeleted,IsClosed,HasOpportunityLineItem, PriceBook2.Name,
                                Billing_Account__c, AccountId
                               FROM Opportunity 
                               WHERE id =: OpportunityId ]; 
        
        
        if(thisOpp.Pricebook2Id == null){
            Terrormessage =  'Please enter Pricebook, and try again.'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        } 
        if(thisOpp.AccountId == null || zconvert.ToString(thisOpp.AccountId) == 'NA') {
            Terrormessage =  'Please enter Account, and try again.'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }
        
        Account acc = [select id, Tract_Billing_Account__c from Account
                       WHERE Id=:thisOpp.AccountId ];
        
        if(acc.Tract_Billing_Account__c == null || acc.Tract_Billing_Account__c == '') {
            Terrormessage =  'Opportunity is not having a TRACT Billing Account'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }                            
        map<id, id> pricebookentryMap = new map<id, id>();
        for(PriceBookEntry pbe : [SELECT Id, Product2.Id,Pricebook2Id,Product2.Name,Product2Id FROM PriceBookEntry where Pricebook2Id =: thisOpp.Pricebook2Id limit 50000]){                
            pricebookentryMap.put(pbe.Product2Id,pbe.id);                 
        }
        set<String> idSet = new set<String>();
        for(Product2AddWrapper wr : productWrapperList){
            idSet.add(wr.agreementId);
        }
        
        map<decimal,OpportunityLineItem> opLIMAp = new map<decimal,OpportunityLineItem>();
        OpportunityLineItem[] opLI = [select eid__c,productEid__c,Service_Resource__c, minServiceResources__c,
                                      username__c, firstname__c ,lastname__c ,Email__c ,
                                      New_Service_Resource__c, RecurringPrice__c, OneTimePrice__c, 
                                      PricebookEntryId, Applied_Agreement_Eid__c
                                      FROM OpportunityLineItem  WHERE OpportunityId =: OpportunityId limit 50000];
        for(OpportunityLineItem oli : opLI){
            opLIMAp.put(oli.productEid__c , oli);  
        } 
        List<Product2AddWrapper> productsToInsert = new List<Product2AddWrapper>();
        for(Product2AddWrapper wr : productWrapperList){
            if(wr.discountName != null && wr.discountName != ' '){
                wr = getDisounts(JSON.serialize(wr));
                if(wr.errorMessage != 'NoError'){
                    listWrapper.errorMessage = wr.errorMessage;
                    return listWrapper;
                }
            }
            productsToInsert.add(wr);
        }
        for(Product2AddWrapper wr : childProductWrapperList){
            if(wr.Quantity > 0){
                if(wr.discountName != null && wr.discountName != ' '){
                    wr = getDisounts(JSON.serialize(wr));
                    if(wr.errorMessage != 'NoError'){
                        listWrapper.errorMessage = wr.errorMessage;
                        return listWrapper;
                    }
                }
                productsToInsert.add(wr);
            }
        }

        for(Product2AddWrapper wr : productsToInsert){
            Decimal prodEid = Decimal.valueOf(wr.prod.eid__c);
            if(opLIMAp.get(prodEid) !=null){
                opportunityLineItem oli = opLIMAp.get(prodEid);
                oli.Agreement_Period__c = wr.agreementPeriod;
                if(wr.agreements != null && wr.agreements.renewAction.size() > 0){
                    oli.agreementEndAction__c = wr.agreements.renewAction[1].getValue();
                }
                
                oli.overrideAgreementEndDate__c = wr.OLineItem.overrideAgreementEndDate__c;
                
                if(wr.Quantity==null){
                    Terrormessage = 'Error: Quantitly Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                else if(pricebookentryMap.get(wr.prod.id)==null){
                    Terrormessage = 'Error: PricebookEntry Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                oli.Quantity = wr.Quantity;
                oli.Discount_eid__c = wr.discountEid;
                oli.Discount__c = wr.discountName;
                
                oli.Service_Resource_Eid__c = wr.serviceResourceEid;
                oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
                if(wr.newServiceResource != null){
                    oli.New_Service_Resource__c = wr.newServiceResource;
                }
                if((wr.service == null && wr.parentServiceEId == ' ') && wr.prod.ProductCode == 'Add-on'){
                    Terrormessage = 'Please select a parent service for ' +wr.prod.Name +'.';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;    
                }
                if(wr.Recurringprice!=null && wr.OneTimePrice!=null) 
                    oli.UnitPrice = wr.OneTimePrice+wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice != null)
                    oli.UnitPrice = wr.OneTimePrice;
                else if(wr.Recurringprice != null && wr.OneTimePrice == null)
                    oli.UnitPrice = wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice == null){
                    Terrormessage = 'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }  
                if(wr.agreementId==null || wr.agreementId.trim() == '') 
                    oli.Applied_Agreement_Eid__c = null;
                else {       
                    oli.Applied_Agreement_Eid__c = wr.agreementId;
                    
                }
                if(wr.service != null && wr.service != ' ' ){
                    oLI.Service__c = wr.service;
                }
                if(wr.parentServiceEId != null && wr.parentServiceEId != ' '){
                    oLI.ParentServiceEid__c = wr.parentServiceEId; 
                }
                
                oLI.ServiceName__c = wr.prod.Name;
                oLI.productEid__c = Decimal.valueof(wr.prod.eid__c); 
                oLI.ProductID__c = wr.prod.Id;
                oLI.productOppEid__c = wr.prod.eid__c + OpportunityId;
                if(wr.Recurringprice != null && wr.Recurringprice != wr.IdAndPriceValueMap.get(wr.RecurrencPerValue))             
                    oli.RecurringPrice__c = wr.Recurringprice;
                if(wr.OneTimePrice != null){
                    for(ProductPriceWrapper prodPriceWrapObj : (list<ProductPriceWrapper>)JSON.deserialize(wr.prod.Price_Information__c,list<ProductPriceWrapper>.class)){
                        if(prodPriceWrapObj.priceType == 'OneTime' && prodPriceWrapObj.priceListEid == wr.priceListValue && prodPriceWrapObj.currencyType == thisOpp.PriceBook2.Name.split(' ')[1]){
                            Decimal oneTimePriceValue; 
                            for(ProductPriceRangeWrapper pr : prodPriceWrapObj.priceRangesList){
                                oneTimePriceValue = pr.price;  
                            }
                            if(wr.OneTimePrice != oneTimePriceValue)
                                oli.OneTimePrice__c = wr.OneTimePrice;
                        }
                    }
                }
                if(wr.RecurrencPerValue != null)                    
                    oli.RecurringProductPriceEid__c = wr.RecurrencPerValue;
                oli.description = wr.OLineItem.description;
                if(wr.priceListValue != null )
                    oli.priceList_Eid__c = wr.priceListValue;
                OLI_List_to_Insert.add(oli); 
            }
            else{
                opportunityLineItem oli = new opportunityLineItem();
                oli.Agreement_Period__c = wr.agreementPeriod;
                
                if(wr.agreements != null && wr.agreements.renewAction.size() > 0){
                    oli.agreementEndAction__c = wr.agreements.renewAction[1].getValue();
                }
                oli.overrideAgreementEndDate__c = wr.OLineItem.overrideAgreementEndDate__c;
                
                if(wr.Quantity==null){
                    Terrormessage = 'Error: Quantitly Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                else if(pricebookentryMap.get(wr.prod.id)==null){
                    Terrormessage = 'Error: PricebookEntry Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                oli.OpportunityId = OpportunityId;  
                oli.PricebookEntryId = pricebookentryMap.get(wr.prod.id);
                oli.Quantity = wr.Quantity;
                oli.Discount_eid__c = wr.discountEid;
                oli.Discount__c = wr.discountName;
                oli.Service_Resource_Eid__c = wr.serviceResourceEid; 
                oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
                if(wr.newServiceResource != null){
                    oli.New_Service_Resource__c = wr.newServiceResource;
                }
                if((wr.service == null && wr.parentServiceEId == ' ') && wr.prod.ProductCode == 'Add-on'){
                    Terrormessage = 'Please select a parent service for ' +wr.prod.Name +'.';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;   
                }
                if(wr.Recurringprice!=null && wr.OneTimePrice!=null) 
                    oli.UnitPrice = wr.OneTimePrice+wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice != null)
                    oli.UnitPrice = wr.OneTimePrice;
                else if(wr.Recurringprice != null && wr.OneTimePrice == null)
                    oli.UnitPrice = wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice == null){
                    Terrormessage = 'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }  
                if(wr.agreementId==null || wr.agreementId.trim() =='') 
                    oli.Applied_Agreement_Eid__c = null;
                else {        
                    oli.Applied_Agreement_Eid__c = wr.agreementId;
                    
                }
                if(wr.service != null && wr.service != '' ){
                    oLI.Service__c = wr.service;
                }
                if(wr.parentServiceEId != null && wr.parentServiceEId != ' '){
                    oLI.ParentServiceEid__c = wr.parentServiceEId; 
                }
                oLI.ServiceName__c = wr.prod.Name;
                
                oLI.productEid__c = Decimal.valueof(wr.prod.eid__c); 
                oLI.eid__c = wr.prod.eid__c;
                oLI.productOppEid__c = wr.prod.eid__c + OpportunityId;
                if(wr.Recurringprice != null && wr.Recurringprice != wr.IdAndPriceValueMap.get(wr.RecurrencPerValue))             
                    oli.RecurringPrice__c = wr.Recurringprice;
                if(wr.OneTimePrice != null){
                    for(ProductPriceWrapper prodPriceWrapObj : (list<ProductPriceWrapper>)JSON.deserialize(wr.prod.Price_Information__c,list<ProductPriceWrapper>.class)){
                        if(prodPriceWrapObj.priceType == 'OneTime' && prodPriceWrapObj.priceListEid == wr.priceListValue && prodPriceWrapObj.currencyType == thisOpp.PriceBook2.Name.split(' ')[1]){
                            Decimal oneTimePriceValue; 
                            for(ProductPriceRangeWrapper pr : prodPriceWrapObj.priceRangesList){
                                oneTimePriceValue = pr.price;  
                            }
                            if(wr.OneTimePrice != oneTimePriceValue)
                                oli.OneTimePrice__c = wr.OneTimePrice;
                        }
                    }
                }
                if(wr.RecurrencPerValue != null)                    
                    oli.RecurringProductPriceEid__c = wr.RecurrencPerValue;
                oli.description = wr.OLineItem.description;
                if(wr.priceListValue != null )
                    oli.priceList_Eid__c = wr.priceListValue;
                OLI_List_to_Insert.add(oli);  
            }
        }
        if(OLI_List_to_Insert!=null && OLI_List_to_Insert.size()>0){ 
                upsert  OLI_List_to_Insert   ; 
        }
        updateOneTimeCharges(OLI_List_to_Insert);       
        for(Integer i=0; i < OLI_List_to_Insert.size(); i++){
            productsToInsert[i].oliId =  OLI_List_to_Insert[i].Id;
        }     
        listWrapper.errorMessage = Terrormessage;
        listWrapper.product2addWrapperList = productWrapperList;
        return listWrapper;
    }
    
    @AuraEnabled
    public static  ProductListWrapper createSalesOrderApexExisting (string productWrapperString, String OpportunityId){
        String Terrormessage = 'NoError';
        String priceBookName;
        ProductListWrapper listWrapper = new ProductListWrapper();
        List<Product2AddWrapper> productWrapperList = (List<Product2AddWrapper>)JSON.deserialize(productWrapperString, List<Product2AddWrapper>.class);
        TRACT_Setup__c tract;
        List<opportunityLineItem> OLI_List_to_Insert = new List<opportunityLineItem>();
        try {
            tract  = [select id,   Tract_User_Name__c,TPassword__c, 
                      TRACT_URL__c,  
                      Active__c, OrderStatus__c from TRACT_Setup__c
                      WHERE Active__c = true limit 1 ];
        }
        
        catch(Exception e){
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            listWrapper.errorMessage = Terrormessage;
            return listWrapper; 
        }
        if(tract==null)
        {  
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }
        Opportunity thisOpp = [SELECT Id,Name,Account.Name,Amount,CloseDate, Description,Owner.Name,TotalOpportunityQuantity,
                               Probability,StageName,Type,Campaign.Name,LeadSource,NextStep,Tract_Sales_Order__c,Pricebook2Id,
                               Account.Tract_Billing_Account__c,ExpectedRevenue,FiscalQuarter,Fiscal,
                               FiscalYear,ForecastCategory,ForecastCategoryName,LastActivityDate,
                               Order_Date__c, PriceBook2.Name,
                               IsWon,IsDeleted,IsClosed,HasOpportunityLineItem,
                                Billing_Account__c, AccountId
                               FROM Opportunity WHERE id =: OpportunityId ]; 
        if(thisOpp.Pricebook2Id == null){
            Terrormessage =  'Please enter Pricebook, and try again.'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        } 
        if(thisOpp.AccountId == null || zconvert.ToString(thisOpp.AccountId) == 'NA') {
            Terrormessage =  'Please enter Account, and try again.'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }
        Account acc = [select id, Tract_Billing_Account__c from Account
                       WHERE Id=:thisOpp.AccountId ];
        
        if(acc.Tract_Billing_Account__c == null || acc.Tract_Billing_Account__c == '') {
            Terrormessage =  'Opportunity is not having a TRACT Billing Account'; 
            listWrapper.errorMessage = Terrormessage;
            return listWrapper;
        }                            
        map<id, id> pricebookentryMap = new map<id, id>();
        for(PriceBookEntry pbe : [SELECT Id, Product2.Id,Pricebook2Id,Product2.Name,Product2Id FROM PriceBookEntry where Pricebook2Id =: thisOpp.Pricebook2Id limit 50000]){                
            pricebookentryMap.put(pbe.Product2Id,pbe.id);                 
        }
        set<String> idSet = new set<String>();
        for(Product2AddWrapper wr : productWrapperList){
            idSet.add(wr.agreementId);
        }
        
        map<decimal,OpportunityLineItem> opLIMAp = new map<decimal,OpportunityLineItem>();
        OpportunityLineItem[] opLI = [select eid__c,productEid__c,Service_Resource__c, minServiceResources__c,
                                      username__c, firstname__c ,lastname__c ,Email__c ,
                                      New_Service_Resource__c, RecurringPrice__c, OneTimePrice__c, 
                                      PricebookEntryId,Applied_Agreement_Eid__c
                                      FROM OpportunityLineItem  WHERE OpportunityId =: OpportunityId limit 50000];
        for(OpportunityLineItem oli : opLI){
            opLIMAp.put(oli.productEid__c , oli);  
        } 
        List<Product2AddWrapper> productsToInsert = new List<Product2AddWrapper>();
        for(Product2AddWrapper wr : productWrapperList){
            for(Product2AddWrapper child : wr.childProducts){
                if(child.Quantity > 0 ){
                    if(child.discountName != null && child.discountName != ' '){
                        child = getDisounts(JSON.serialize(child));
                        if(child.errorMessage != 'NoError'){
                            listWrapper.errorMessage = child.errorMessage;
                            return listWrapper;
                        }
                    }
                    productsToInsert.add(child);
                }
            }
        }
        for(Product2AddWrapper wr : productsToInsert){
            Decimal prodEid = Decimal.valueOf(wr.prod.eid__c);
            if(opLIMAp.get(prodEid) !=null){
                opportunityLineItem oli = opLIMAp.get(prodEid);
                if(wr.existing){
                    oli.Existing_Service__c = wr.existing;
                    oli.Existing_Service_Eid__c = wr.serviceEid;
                    
                }  
                oli.Agreement_Period__c = wr.agreementPeriod;
                if(wr.agreements != null && wr.agreements.renewAction.size() > 0){
                    oli.agreementEndAction__c = wr.agreements.renewAction[1].getValue();
                }
                oli.overrideAgreementEndDate__c = wr.OLineItem.overrideAgreementEndDate__c;
                if(wr.Quantity==null){
                    Terrormessage = 'Error: Quantity Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                else if(pricebookentryMap.get(wr.prod.id)==null){
                    Terrormessage = 'Error: PricebookEntry Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                oli.Quantity = wr.Quantity;
                oli.Discount_eid__c = wr.discountEid;
                oli.Discount__c = wr.discountName;
                oli.Service_Resource_Eid__c = wr.serviceResourceEid;
                oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
                if(wr.newServiceResource != null){
                    oli.New_Service_Resource__c = wr.newServiceResource;
                }
                if((wr.service == null && wr.parentServiceEId == ' ') && wr.prod.ProductCode == 'Add-on'){
                    Terrormessage = 'Please select a parent service for ' +wr.prod.Name +'.';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;    
                }
                if(wr.Recurringprice!=null && wr.OneTimePrice!=null) 
                    oli.UnitPrice = wr.OneTimePrice+wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice != null)
                    oli.UnitPrice = wr.OneTimePrice;
                else if(wr.Recurringprice != null && wr.OneTimePrice == null)
                    oli.UnitPrice = wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice == null){
                    Terrormessage = 'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }  
                if(wr.agreementId==null || wr.agreementId.trim() =='') 
                    oli.Applied_Agreement_Eid__c = null;
                else {       
                    oli.Applied_Agreement_Eid__c = wr.agreementId;
                }
                if(wr.service != null && wr.service != '' ){
                    oLI.Service__c = wr.service;
                }
                if(wr.parentServiceEId != null && wr.parentServiceEId != ' '){
                    oLI.ParentServiceEid__c = wr.parentServiceEId; 
                }
                oLI.ServiceName__c = wr.prod.Name;
                oLI.productEid__c = Decimal.valueof(wr.prod.eid__c); 
                oLI.ProductID__c = wr.prod.Id;
                oLI.productOppEid__c = wr.prod.eid__c + OpportunityId;
                if(wr.Recurringprice != null && wr.Recurringprice != wr.IdAndPriceValueMap.get(wr.RecurrencPerValue))             
                    oli.RecurringPrice__c = wr.Recurringprice;
                if(wr.OneTimePrice != null){
                    for(ProductPriceWrapper prodPriceWrapObj : (list<ProductPriceWrapper>)JSON.deserialize(wr.prod.Price_Information__c,list<ProductPriceWrapper>.class)){
                        if(prodPriceWrapObj.priceType == 'OneTime' && prodPriceWrapObj.priceListEid == wr.priceListValue && prodPriceWrapObj.currencyType == thisOpp.PriceBook2.Name.split(' ')[1]){
                            Decimal oneTimePriceValue; 
                            for(ProductPriceRangeWrapper pr : prodPriceWrapObj.priceRangesList){
                                oneTimePriceValue = pr.price;  
                            }
                            if(wr.OneTimePrice != oneTimePriceValue)
                                oli.OneTimePrice__c = wr.OneTimePrice;
                        }
                    }
                }
                if(wr.RecurrencPerValue != null)                    
                    oli.RecurringProductPriceEid__c =wr.RecurrencPerValue;
                oli.description = wr.OLineItem.description;
                OLI_List_to_Insert.add(oli); 
            }
            else{
                opportunityLineItem oli = new opportunityLineItem();
                if(wr.existing == true ){
                    oli.Existing_Service__c = wr.existing;
                    oli.Existing_Service_Eid__c = wr.serviceEid;
                } 
                oli.Agreement_Period__c = wr.agreementPeriod;
                
                if(wr.agreements != null && wr.agreements.renewAction.size() > 0){
                    oli.agreementEndAction__c = wr.agreements.renewAction[1].getValue();
                }
                oli.overrideAgreementEndDate__c = wr.OLineItem.overrideAgreementEndDate__c;
                
                if(wr.Quantity==null){
                    Terrormessage = 'Error: Quantitly Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                else if(pricebookentryMap.get(wr.prod.id)==null){
                    Terrormessage = 'Error: PricebookEntry Cannot be NULL';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }
                oli.OpportunityId = OpportunityId;  
                oli.PricebookEntryId = pricebookentryMap.get(wr.prod.id);
                oli.Quantity = wr.Quantity;
                oli.Discount_eid__c = wr.discountEid;
                oli.Discount__c = wr.discountName;
                oli.Service_Resource_Eid__c = wr.serviceResourceEid; 
                oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
                if(wr.newServiceResource != null){
                    oli.New_Service_Resource__c = wr.newServiceResource;
                }
                if((wr.service == null && wr.parentServiceEId == ' ') && wr.prod.ProductCode == 'Add-on'){
                    Terrormessage = 'Please select a parent service for ' +wr.prod.Name +'.';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;   
                }
                if(wr.Recurringprice!=null && wr.OneTimePrice!=null) 
                    oli.UnitPrice = wr.OneTimePrice+wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice != null)
                    oli.UnitPrice = wr.OneTimePrice;
                else if(wr.Recurringprice != null && wr.OneTimePrice == null)
                    oli.UnitPrice = wr.Recurringprice;
                else if(wr.Recurringprice == null && wr.OneTimePrice == null){
                    Terrormessage = 'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
                    listWrapper.errorMessage = Terrormessage;
                    return listWrapper;
                }  
                if(wr.agreementId==null || wr.agreementId.trim() =='') 
                    oli.Applied_Agreement_Eid__c = null;
                else {       
                    oli.Applied_Agreement_Eid__c = wr.agreementId;
                }
                if(wr.service != null && wr.service != '' ){
                    oLI.Service__c = wr.service;
                }
                if(wr.parentServiceEId != null && wr.parentServiceEId != ' '){
                    oLI.ParentServiceEid__c = wr.parentServiceEId; 
                }
                oLI.ServiceName__c = wr.prod.Name;
                oLI.productEid__c = Decimal.valueof(wr.prod.eid__c); 
                oLI.eid__c = wr.prod.eid__c;
                oLI.productOppEid__c = wr.prod.eid__c + OpportunityId;
                if(wr.Recurringprice != null && wr.Recurringprice != wr.IdAndPriceValueMap.get(wr.RecurrencPerValue))             
                    oli.RecurringPrice__c = wr.Recurringprice;
                if(wr.OneTimePrice != null){
                    for(ProductPriceWrapper prodPriceWrapObj : (list<ProductPriceWrapper>)JSON.deserialize(wr.prod.Price_Information__c,list<ProductPriceWrapper>.class)){
                        if(prodPriceWrapObj.priceType == 'OneTime' && prodPriceWrapObj.priceListEid == wr.priceListValue && prodPriceWrapObj.currencyType == thisOpp.PriceBook2.Name.split(' ')[1]){
                            Decimal oneTimePriceValue; 
                            for(ProductPriceRangeWrapper pr : prodPriceWrapObj.priceRangesList){
                                oneTimePriceValue = pr.price;  
                            }
                            if(wr.OneTimePrice != oneTimePriceValue)
                                oli.OneTimePrice__c = wr.OneTimePrice;
                        }
                    }
                }
                if(wr.RecurrencPerValue != null)                    
                    oli.RecurringProductPriceEid__c = wr.RecurrencPerValue;
                oli.description = wr.OLineItem.description;
                OLI_List_to_Insert.add(oli);  
            }
        }
        
        if(OLI_List_to_Insert!=null && OLI_List_to_Insert.size()>0){ 
                upsert  OLI_List_to_Insert   ; 
        }
        updateOneTimeCharges(OLI_List_to_Insert);       
        for(Integer i=0; i < OLI_List_to_Insert.size(); i++){
            productsToInsert[i].oliId =  OLI_List_to_Insert[i].Id;
        }     
        listWrapper.errorMessage = Terrormessage;
        listWrapper.product2addWrapperList = productWrapperList;
        return listWrapper;
    }
    
    private static void updateOneTimeCharges(List<opportunityLineItem> OLI_List_to_Insert){
        map<String,String> opLIMAp = new map<String,String>();
        for(OpportunityLineItem oli : OLI_List_to_Insert){
            opLIMAp.put(oli.productOppEid__c , oli.Id);  
        } 
        List<Schdeule_Charge__c> chargeToUpdate = new  List<Schdeule_Charge__c>();
        for(Schdeule_Charge__c charge : [select id,ProductId__c, productEid__c from  Schdeule_Charge__c limit 50000] ){
            if(opLIMAp.get(charge.productEid__c) != null){
                charge.ProductId__c = opLIMAp.get(charge.productEid__c); 
                chargeToUpdate.add(charge);
            }
        }
        if(chargeToUpdate != null && chargeToUpdate.size()>0){
                update chargeToUpdate;
        } 
    }
     @AuraEnabled
    public  static String  createOrderApex(String OpportunityId) {
        String Terrormessage = 'NoError';
        TRACT_Setup__c tract;
        try {
            tract  = [select id,   Tract_User_Name__c,TPassword__c, 
                      TRACT_URL__c,  
                      Active__c, OrderStatus__c from TRACT_Setup__c
                      WHERE Active__c = true limit 1 ];
        }
        catch(Exception e){
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            return Terrormessage; 
        }
        if(tract==null)
        {  
            Terrormessage='Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
            return Terrormessage;
        }
        Opportunity thisOpp = [SELECT Id,Name,Account.Name,Amount,CloseDate, Description,Owner.Name,TotalOpportunityQuantity,
                               Probability,StageName,Type,Campaign.Name,LeadSource,NextStep,Tract_Sales_Order__c,Pricebook2Id,
                               Account.Tract_Billing_Account__c,ExpectedRevenue,FiscalQuarter,Fiscal,
                               FiscalYear,ForecastCategory,ForecastCategoryName,LastActivityDate,
                               Order_Date__c,
                               IsWon,IsDeleted,IsClosed,HasOpportunityLineItem,
                                Billing_Account__c, AccountId
                               FROM Opportunity WHERE id =: OpportunityId ]; 
        
        
        if(thisOpp.Pricebook2Id == null){
            Terrormessage =  'Please enter Pricebook, and try again.'; 
            return Terrormessage;
        } 
        if(thisOpp.AccountId == null || zconvert.ToString(thisOpp.AccountId) == 'NA') {
            Terrormessage =  'Please enter Account, and try again.'; 
            return Terrormessage;
        }
        
        Account acc = [select id,Tract_Billing_Account__c from Account
                       WHERE Id=:thisOpp.AccountId ];
                       
       
        APIDataService dataService = GTVDataService.getService();
        TRACTAccountWrapper sfdcBillingAccount = dataService.getBillingAccount(acc.id);
        String accountEid = sfdcBillingAccount.eid;

        if(acc.Tract_Billing_Account__c == null || acc.Tract_Billing_Account__c == '') {
            Terrormessage =  'Opportunity is not having a TRACT Billing Account'; 
            return Terrormessage;
        }                            
        try {
            if(thisOpp.Pricebook2Id != null){
                List<pricebook2> pb2 = [select id ,CurrencyType__c, name from pricebook2 where id =: thisOpp.Pricebook2Id limit 1];
                if(pb2[0].name!=null && pb2[0].name!='' ){
                    List<String> str_List = (pb2[0].name).split(' ');
                    if(str_List.size() == 4 && str_List[0] == 'GTV' && str_List[2] == 'Price' && str_List[3] == 'Book' &&  str_List[1].length()==3){
                        Set<String> uniqueNames = new Set<String>();
                        
                        Map<String,OpportunityLineItem> eidOLIMap = new Map<String,OpportunityLineItem>();
                        
                        OpportunityLineItem[] opLI = [select eid__c, Service_Resource__c, minServiceResources__c,
                                                      username__c, firstname__c ,lastname__c ,Email__c ,
                                                      New_Service_Resource__c, RecurringPrice__c, 
                                                      PricebookEntryId,  Existing_Service__c, Quantity, Existing_Service_Eid__c
                                                      FROM OpportunityLineItem  WHERE OpportunityId =: thisOpp.Id limit 50000];
                        
                        if(opLI.size() == 0){                             
                            Terrormessage = 'Cannot create an order with 0 products';
                            return Terrormessage;
                        }
                        
                        List<OpportunityLineItem> existingOLI = new List<OpportunityLineItem>();                             
                        for(OpportunityLineItem oli : opLI){
                            if(oli.Existing_Service__c){
                                existingOLI.add(oli);
                                
                            }
                        }                              
                        if(existingOLI.size() > 0){
                            String msg = UpdateQuantityInTract(tract,existingOLI);
                            if(msg != 'NoError'){
                                return msg;
                            }
                        } 
                        String[] tractProdEid = new List<String>();
                        for(OpportunityLineItem tempOPLI : opLI) {
                            
                            if(!(tempOPLI.eid__c==null||tempOPLI.eid__c=='' || tempOPLI.Existing_Service__c == true)){
                                tractProdEid.add(tempOPLI.eid__c);
                            }
                            eidOLIMap.put(tempOPLI.eid__c,tempOPLI);
                        } 
                        Product2[] tractProducts = [SELECT eid__c,IsActive, PriceOverride__c,
                                                    Requires_Agreement__c, name,
                                                    minServiceResources__c, ProductCode
                                                    FROM Product2 WHERE eid__c =: tractProdEid limit 50000];
                        if(tractProducts.size() > 0){
                            for(Product2 tempTractProducts : tractProducts ) {
                                
                                
                                //ErrorMessage = 'Unable to Place the TRACT Sales order. Please select an Agreement for Opportunity Line Item :'+  cc.Service_Resource__c+'.sgsg ';
                                OpportunityLineItem currentOLI = eidOLIMap.get(tempTractProducts.eid__c );
                                
                                if( currentOLI.Service_Resource__c == null && currentOLI.New_Service_Resource__c==null
                                   && currentOLI.minServiceResources__c > 0) {
                                       Terrormessage =  'Unable to Place the TRACT Sales order. Please select Service Resource'+ 'for the Opportunity Line Item :' + tempTractProducts.name +'. '; 
                                       return Terrormessage;
                                   }
                                if(!tempTractProducts.IsActive) {
                                    Terrormessage =  'Unable to Place the TRACT Sales order.'+ ' Support for Opportunity Line Item :' + tempTractProducts.name +' have been Stopped. '; 
                                    return Terrormessage;
                                }
                                
                                if(tempTractProducts.ProductCode=='TRACT_SUBSCRIPTION') {
                                    
                                    if( currentOLI.username__c == null || currentOLI.Email__c == null
                                       || currentOLI.firstname__c == null || currentOLI.lastname__c == null 
                                       || currentOLI.username__c == '' || currentOLI.Email__c == '' 
                                       || currentOLI.firstname__c == ''|| currentOLI.lastname__c == '') {
                                           
                                           Terrormessage =  'Unable to Place the TRACT Sales order.'+ ' Please provide complete TRACT Administrator Information for' +' Opportunity Line Item :' + tempTractProducts.name + '. '; 
                                           return Terrormessage;
                                       }
                                }
                            }
                            
                            if(tract.OrderStatus__c != null && tract.OrderStatus__c.equals('DRAFT')) {
                                try{
                                    Map <String, String> orderInformation = getInformation(thisOpp,acc, tract,accountEid);
                                     dataService.tractCreateDraftOrder(orderInformation);
                                     Terrormessage = orderInformation.get('ErrorMessage');
                                }catch(Exception e){
                                    Terrormessage = e.getmessage(); 
                                    return Terrormessage;
                                } 
                            }
                            else {
                                //try{
                                    Map <String, String> orderInformation = getInformation(thisOpp,acc, tract,accountEid);
                                    dataService.tractCreateSalesOrder(orderInformation);
                                    Terrormessage = orderInformation.get('ErrorMessage');
                                /*}catch(Exception e){
                                    Terrormessage =  e.getCause() + String.valueOf(e.getLineNumber()) + e.getStackTraceString() + e.getTypeName(); 
                                    return Terrormessage;
                                }*/
                            }
                            
                        }
                    }
                }
            }
        }
        catch(MyException ex) {
            Terrormessage = ex.getmessage(); 
            return Terrormessage;
        }
        return Terrormessage; 
    }
    
    
    private Static String UpdateQuantityInTract(TRACT_Setup__c tract, List<OpportunityLineItem> existingOLI){
        String Emessage= 'NoError';
            try{
                APIDataService dataService = GTVDataService.getService();
                dataService.updateQuantityAddProduct(existingOLI);
            }catch(Exception e){
                Emessage = string.valueof(e.getmessage()+e.getLineNumber());
                Emessage = Emessage.substringBetween('Web service callout failed: WebService returned a SOAP Fault:',' faultcode=soap:Server faultactor=');
            }        
        return Emessage;
    }
    
    @TestVisible
    private static Map <String, String> getInformation(Opportunity thisOpp,Account acc, TRACT_Setup__c tract ,String accountEid) {     
        Map <String, String> information = new Map <String,String> {
            'ErrorMessage' => 'NoError',
            'orderFromLightning' => 'true',
            'OpportunityId' => zConvert.ToString(thisOpp.Id),
            'AccountId' => zConvert.ToString(thisOpp.AccountId),    
            'Amount' => zConvert.ToString(thisOpp.Amount),
            'CampaignId' => zConvert.ToString(thisOpp.CampaignId),
            'CloseDate' => zConvert.ToString(thisOpp.CloseDate),
            'Description' => zConvert.ToString(thisOpp.Description),
            'ExpectedRevenue' => zConvert.ToString(thisOpp.ExpectedRevenue),
            'Fiscal' => zConvert.ToString(thisOpp.Fiscal),
            'FiscalQuarter' => zConvert.ToString(thisOpp.FiscalQuarter),
            'FiscalYear' => zConvert.ToString(thisOpp.FiscalYear),
            'ForecastCategory' => zConvert.ToString(thisOpp.ForecastCategory),
            'ForecastCategoryName' => zConvert.ToString(thisOpp.ForecastCategoryName),
            'HasOpportunityLineItem' => zConvert.ToString(thisOpp.HasOpportunityLineItem),
            'IsClosed' => zConvert.ToString(thisOpp.IsClosed),
            'IsDeleted' => zConvert.ToString(thisOpp.IsDeleted),
            'IsWon' => zConvert.ToString(thisOpp.IsWon),
            'LastActivityDate' => zConvert.ToString(thisOpp.LastActivityDate),
            'LeadSource' => zConvert.ToString(thisOpp.LeadSource),
            'Name' => zConvert.ToString(thisOpp.Name),
            'NextStep' => zConvert.ToString(thisOpp.NextStep),
            'OwnerId' => zConvert.ToString(thisOpp.OwnerId),
            'Pricebook2Id' => zConvert.ToString(thisOpp.Pricebook2Id),
            'Probability' => zConvert.ToString(thisOpp.Probability),
            'StageName' => zConvert.ToString(thisOpp.StageName),
            'TotalOpportunityQuantity' => zConvert.ToString(thisOpp.TotalOpportunityQuantity),
            'Type' => zConvert.ToString(thisOpp.Type),
            'TRACT_APP__Tract_User_Name__c' => tract.Tract_User_Name__c,
            'TRACT_APP__Tract_Password__c' => tract.TPassword__c,
            'TRACT_APP__TPassword__c' => tract.TPassword__c,
            'TRACT_APP__TRACT_URL__c' => tract.TRACT_URL__c,
            'BillingAccounteid'=> accountEid,
            'BillingAccountNum'=> acc.Tract_Billing_Account__c,
            'OrderDate' => zConvert.ToString(thisOpp.Order_Date__c)
        };
        return information; 
    }         
    
    private static set<String> getRelatedProduct( String productEid){
        set<String> setOfParentName = new set<String>();
        APIDataService dataService = GTVDataService.getService();
        setOfParentName = dataService.getRelatedChidProducts(productEid);
        return setOfParentName;        
    }
    
    @AuraEnabled
    public static Product2AddWrapper setOrderCurrencyType(String proShowString){
        Product2AddWrapper proShow = (Product2AddWrapper)JSON.deserialize(proShowString,Product2AddWrapper.class);
        String currencyType = proShow.PricebookNames[1]; 
        String value, location;
        for(System_Setting__c settings : System_Setting__c.getall().values()){
            if(settings.name == 'Currency Identification'){
                value = settings.value__c;
            }
            if(settings.name == 'Currency Location'){
                location = settings.value__c;
            }
        }
        if(value == 'ISO Code'){
            if(location =='After'){
                proShow.totelPriceValue =  proShow.totelPriceValue +' ' +    currencyType;
            }  
            else{
                proShow.totelPriceValue =  currencyType +' ' +   proShow.totelPriceValue ; 
            }
        }else{
            if(location =='After'){
                proShow.totelPriceValue = proShow.totelPriceValue +   TractSFDC_Util.getCurrencySymbole(currencyType);
            }
            else{
                
                proShow.totelPriceValue = TractSFDC_Util.getCurrencySymbole(currencyType) +  proShow.totelPriceValue ;
            }
        }  
        return proShow;
    }  
    
    @AuraEnabled
    public static String checkExistingOrder(String OpportunityId){
        String message = '';
        Opportunity opportunity= [select id,Type,pricebook2.Name,Pricebook2Id,AccountId,Tract_Sales_Order__c, Account.Tract_Billing_Account__c, Account.Currency_Type__c from Opportunity where id =:OpportunityId limit 1];
        if(opportunity.Tract_Sales_Order__c != null){
            message = 'Order '+opportunity.Tract_Sales_Order__c+' in TRACT has already been created for this opportunity. To add additional products or services to an account, please create a new opportunity.';
            return message;
        }else{
            return message;
        }
    }
    String Terrormessage = 'NoError';    
    public class ProductListWrapper{
        @AuraEnabled
        public String errorMessage{get;set;}
        @AuraEnabled
        public String pricebook{get;set;}
        @AuraEnabled
        public List<Product2Wrapper> product2WrapperList{get;set;}
        @AuraEnabled
        public List<Product2AddWrapper> product2addWrapperList{get;set;}
        @AuraEnabled
        public List<String> productIdList{get;set;}
        
    }
    public class Product2Wrapper{
        @AuraEnabled
        public boolean IsSelected{get;set;}
        @AuraEnabled
        public product2 prod{get;set;}
        @AuraEnabled
        public String errorMessage{get;set;}
    }
  /*  public class Agreementwrapper{
        @AuraEnabled
        public list<SelectOption> agreementList{get;set;}
        @AuraEnabled
        public list<SelectOption> renewAction{get;set;}
        @AuraEnabled
        public Map<String,Decimal> mapOfAgreementPeriod{get;set;}
        @AuraEnabled
        public Boolean hasAgreement {get; set;}
    }*/
    
    //Wrapper Class To Show the Addedproducts
   /* public class Product2AddWrapper{
        
        @AuraEnabled
        public boolean existing{get;set;}
        @AuraEnabled
        public String serviceEid{get;set;}
        @AuraEnabled
        public String ProductEid{get;set;}
        @AuraEnabled
        public String RuleType{get;set;}
        @AuraEnabled
        public decimal MaxServiceResource{get;set;}
        @AuraEnabled
        public decimal MinServiceResource{get;set;}
        @AuraEnabled
        public boolean RuleOverride{get;set;}
        @AuraEnabled
        public product2 prod{get;set;}
        @AuraEnabled
        public String oppId{get;set;}
        @AuraEnabled
        public Boolean scheduleChargeEnable{get;set;}
        @AuraEnabled
        public Boolean DisableRecurring{get;set;}
        @AuraEnabled
        public Boolean oneTimeChargeEnable{get;set;}
        @AuraEnabled
        public Boolean Disableonetime{get;set;}
        @AuraEnabled
        public decimal Recurringprice{get;set;}
        @AuraEnabled
        public decimal OneTimePrice{get;set;}
        @AuraEnabled
        public Integer Quantity{get;set;}
        @AuraEnabled
        public map<String, decimal> IdAndPriceValueMap{get;set;}
        @AuraEnabled
        public map<String, String> IdAndEidMapOneTime{get;set;}
        @AuraEnabled
        public map<String, String> IdAndEidMap{get;set;}
        @AuraEnabled
        public map<String, List<ProductPriceRangeWrapper>> priceVsPriceRanges{get;set;}
        @AuraEnabled
        public decimal priceRangeValue{get;set;}
        @AuraEnabled
        public String totelPriceValue{get;set;}
        @AuraEnabled
        public List<SelectOption> productPriceList{get;set;}
        @AuraEnabled
        public String priceListValue{get;set;}
        @AuraEnabled
        public String priceListValue1{get;set;}
        @AuraEnabled
        public List<SelectOption> RecurrenceoptList{get;set;}
        @AuraEnabled
        public String RecurrencPer{get;set;}
        @AuraEnabled
        public Integer totelPrice{get;set;}
        @AuraEnabled
        public String RecurrencPerValue{get;set;}
        @AuraEnabled
        public String discountName{get;set;}
        @AuraEnabled
        public String discountEid{get;set;}
        @AuraEnabled
        public String newServiceResource{get;set;}
        @AuraEnabled
        public String serviceResourceName{get;set;}
        @AuraEnabled
        public String serviceResourceEid{get;set;}
        @AuraEnabled
        public String errorMessage{get;set;}
        @AuraEnabled
        public String oliId{get;set;}
        @AuraEnabled
        public List<String> PricebookNames{get;set;}
        @AuraEnabled
        public opportunityLineItem OLineItem{get;set;} 
        @AuraEnabled
        public String  agreementId{get;set;} 
        @AuraEnabled
        public String service{get;set;} 
        @AuraEnabled
        public String parentServiceEId{get;set;} 
        @AuraEnabled
        public Decimal agreementPeriod{get;set;} 
        @AuraEnabled
        public List<Product2AddWrapper> childProducts{get;set;} 
        @AuraEnabled 
        public Agreementwrapper agreements{get;set;} 
        @AuraEnabled
        public Boolean serialized {get; set;}
        
        public Product2AddWrapper(){
            priceListValue = ' ';
            priceListValue1 = ' ';
            RecurrencPer = ' ';
            discountName = ' ';
            discountEid = ' ';
            newServiceResource = ' ';
            serviceResourceName = ' ';
            serviceResourceEid = ' ';
            RecurrencPerValue = ' ';
            oliId = ' ';
            parentServiceEId = ' ';
            totelPriceValue = '0.00';
            Quantity = 1;
            totelPrice = 0;
            existing = false;
            OLineItem = new opportunityLineItem();
            IdAndPriceValueMap = new map<String, decimal>();
            IdAndEidMapOneTime = new map<String, string>();
            IdAndEidMap = new map<String, string>();
        }
    }*/
    
    public class ServiceCustomFieldValuesWrapper{
        @AuraEnabled
        public String Name{get;set;}
        @AuraEnabled
        public String Eid{get;set;}
        @AuraEnabled
        public String Value{get;set;}
        @AuraEnabled
        public List<SelectOption> ServiceListType{get;set;}
        @AuraEnabled
        public String ServiceListTypeValue{get;set;}
        @AuraEnabled
        public Boolean checkListtype{get;set;}
    }
    
    //Wrapper Class To Show the Product uses Rule
    public class ProductUsesWrapper{
        @AuraEnabled
        public String ChargeName{get;set;}
        @AuraEnabled
        public String ChargeType{get;set;}
        @AuraEnabled
        public String Rule{get;set;}     
        @AuraEnabled
        public String UsageRuleEid{get;set;}
        @AuraEnabled
        public String ChargeCategory{get;set;}
        @AuraEnabled
        public String Taper{get;set;}
        @AuraEnabled
        public String Rate{get;set;}
        @AuraEnabled
        public String FromDate{get;set;}
        @AuraEnabled
        public String ThruDate{get;set;}
        @AuraEnabled
        public String Status{get;set;}
    }
    
    public class ChargeRulesWrapper{
        @AuraEnabled
        public  list<SelectOption> selectStatusList1{get;set;}
        @AuraEnabled
        public  String selectStatusListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> productUsageRuleList1{get;set;}
        @AuraEnabled
        public  String productUsageRuleListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> rateTypeList1{get;set;}
        @AuraEnabled
        public  String rateTypeListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> chargesPicklist1{get;set;}
        @AuraEnabled
        public  String chargesPicklistValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> allowanceTypeList1{get;set;}
        @AuraEnabled
        public  String allowanceTypeListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> roleOverList1{get;set;}
        @AuraEnabled
        public  String roleOverListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> formulaField1{get;set;}
        @AuraEnabled
        public  String formulaFieldValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> operationList1{get;set;}
        @AuraEnabled
        public  String operationListValue{get;set;}
        @AuraEnabled
        public  list<SelectOption> passThroughChargeList1{get;set;}
        @AuraEnabled
        public  String passThroughChargeListValue{get;set;}
        @AuraEnabled
        public list<SelectOption> formulaUsageRuleList{get;set;}
        @AuraEnabled
        public  String formulaUsageRuleListValue{get;set;}
        @AuraEnabled
        public list<SelectOption> chargeListBytes{get;set;}
        @AuraEnabled
        public  String chargeListBytesValue{get;set;}
        @AuraEnabled
        public list<SelectOption> chargeCategoryList{get;set;}
        @AuraEnabled
        public  String chargeCategoryListValue{get;set;}
        @AuraEnabled
        public  String ServiceUsageRuleName{get;set;}
        @AuraEnabled
        public  Decimal chargeValue{get;set;}
        @AuraEnabled
        public  Double ammountValue{get;set;}
        @AuraEnabled
        public  String ActivityFormulaValue{get;set;}
        @AuraEnabled
        public  Boolean prorateOnOrder{get;set;}  
        @AuraEnabled
        public  Boolean prorateOnCancel{get;set;}
    }
   /* public class SelectOption {
        @AuraEnabled
        public String label{get;set;}  
        @AuraEnabled
        public String value{get;set;} 
        public SelectOption(String value, String label) {
            this.value = value;
            this.label = label;
        }
        public string getValue(){
            return value;
        } 
        
    }*/
}