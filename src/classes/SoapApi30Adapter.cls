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
** Module Name   : ScheduleChargesWrapper
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN     /** 
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
** Module Name   : SoapApi30Adapter
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN   	This class is no longer in use but it is global so can’t be deleted from the package.


******************************************************************************************************************************/



global with sharing class SoapApi30Adapter {     
/**
    * Intialize Tract Service Endpoint
    */
   /* public static SoapApi30Service.TractPort getTractServicePort(TRACT_Setup__c  tractConfig) {
        
        SoapApi30Service.TractPort port = new SoapApi30Service.TractPort();
        
        //Prepare String for base64 Encoding
        //String userPass= tractConfig.Tract_User_Name__c+ ':' + tractConfig.Tract_Password__c;
        String userPass= tractConfig.Tract_User_Name__c+ ':' + tractConfig.TPassword__c;
        String encodedusernameandpassword = EncodingUtil.base64Encode(Blob.valueOf(userPass));
        
        //Set Authorization Header
        port.inputHttpHeaders_x = new Map<String, String>();
        port.inputHttpHeaders_x.put('Authorization','Basic ' + encodedusernameandpassword  );
        port.endpoint_x = tractConfig.TRACT_URL__c;
        port.timeout_x = 30000;
        
        return port;
    }

public static SoapApi30Domain.BillingAccount[] getBillingAccounts(TRACT_Setup__c  tractConfig, String entityType, 
                            String paramName, String paramvalue, Integer pageNumber,
                            Integer pageSize, String queryScope){
        SoapApi30Domain.BillingAccount[] results ;
        SoapApi30Domain.QueryResponse queryResponse;
        
        if(!Test.isRunningTest()){  
            queryResponse = queryTractByParamAndValue(tractConfig, entityType, paramName,
                                                        paramvalue , pageNumber, pageSize, queryScope); 
        } else {
            queryResponse = SoapApi30TestUtil.getBillingAccounts();
        }
        
        if(queryResponse.successful && null != queryResponse.billingAccounts.billingAccount) {
            results =  queryResponse.billingAccounts.billingAccount;
        } else {
            //TODOs: Either request failed or account not found.
            results = new List<SoapApi30Domain.BillingAccount>();
        }
        return results;                                     
    }


public static SoapApi30Domain.QueryResponse queryTractByParamAndValue(TRACT_Setup__c  tractConfig, 
                                    String entityType, String paramName, String paramValue, Integer pageNumber,
                                         Integer pageSize, String queryScope) {
        
        //Prepare Query
        SoapApi30Domain.SimpleDataQuery sdq = new SoapApi30Domain.SimpleDataQuery();
        
        if(entityType != null) {
            sdq.type_x = entityType;
        }
        if(paramName != null && paramValue != null) {
            SoapApi30Domain.ParameterAndValue[] params = new List<SoapApi30Domain.ParameterAndValue>();
            SoapApi30Domain.ParameterAndValue paramAndValue = new SoapApi30Domain.ParameterAndValue();
            paramAndValue.parameter = paramName;
            paramAndValue.parameterValue = paramvalue ;
            paramAndValue.operator = 'EQ';
            params.add(paramAndValue);  
            sdq.parameter =  params;
        }
        
        if(pageNumber != null){
            sdq.pageNumber = pageNumber;
        }
        
        if(pageSize != null){
            sdq.pageSize = pageSize;
        }
                
        SoapApi30Domain.QueryRequest queryRequest = new SoapApi30Domain.QueryRequest();
        queryRequest.simpleDataQuery =  sdq;
        
        if(queryScope != null) {
            queryRequest.queryScope = queryScope;
        }
         
        SoapApi30Service.TractPort tract = getTractServicePort(tractConfig);
        tract.timeout_x = 120000;
        If(!Test.isRunningTest()){
            SoapApi30Domain.QueryResponse response = tract.query(queryRequest);
            return response;
        }
        else 
            return null;
    }*/

   WebService static String contactUpdateOnAccount(Id contactId){
        
       /* String conId = contactId;
        TRACT_Setup__c[] tract=null;
        String ErrorMessage = '';
        Contact currentContact = null;
        Account accountNumber = null;
        String Emessage;
        if(TRACTAPIUtil.checkFieldLevelSecurity('TRACT3__TRACT_Setup__c', 'id,Postal_Address_Purpose__c,Tract_Password__c, TPassword__c,Tract_User_Name__c,TRACT_URL__c,Email_Address_Purpose__c,Store_SFDC_Account_Id__c,Bill_Cycle_Name__c,Billing_Account_Bill_Type__c,Active__c,Create_Tract_Account__c,Configure__c, CustomField__c','Query')){
            tract = [select id,Postal_Address_Purpose__c,Tract_Password__c, TPassword__c,
                    Tract_User_Name__c,TRACT_URL__c,Email_Address_Purpose__c,Store_SFDC_Account_Id__c,
                    Bill_Cycle_Name__c,Billing_Account_Bill_Type__c,Active__c,
                    Configure__c, CustomField__c from TRACT_Setup__c WHERE Active__c=true limit 1 ];
        }
        if(tract.size() > 0){
            if(TRACTAPIUtil.checkFieldLevelSecurity('Contact', 'id, Name, accountId, MailingPostalCode,MailingStreet,LastName,FirstName,Phone,MobilePhone,Email,MailingCity,MailingState,MailingCountry,otherPostalCode,otherCity,otherState,otherCountry,otherStreet,Shipping_Zip_Postal_Code__c,Shipping_City__c,Shipping_State_Province__c,Shipping_Street__c,Shipping_Country__c','Query')){
                currentContact = [select id, Name, accountId, MailingPostalCode,MailingStreet,LastName,FirstName, 
                                Phone,MobilePhone,Email,MailingCity,MailingState,MailingCountry,otherPostalCode,otherCity,
                                otherState,otherCountry,otherStreet,Shipping_Zip_Postal_Code__c,Shipping_City__c,Shipping_State_Province__c,
                                Shipping_Street__c,Shipping_Country__c from contact where id =: conId limit 1];
            }            
            if(currentContact != null){
                if(TRACTAPIUtil.checkFieldLevelSecurity('Account', 'id, name, Tract_Billing_Account__c','Query'))
                    accountNumber = [select id, name, Tract_Billing_Account__c from Account where id =: currentContact.accountId];
            }
            SoapApi30Domain.QueryResponse contactCategory ;
            SoapApi30Domain.AddPersonToBillingAccount addPersonToBillingAccount = new SoapApi30Domain.AddPersonToBillingAccount();
            SoapApi30Domain.Person person = new SoapApi30Domain.Person();
            SoapApi30Domain.PartyCategory partyCat = new SoapApi30Domain.PartyCategory();
            SoapApi30Domain.BillingAccount billingAccount = new SoapApi30Domain.BillingAccount();
            SoapApi30Service.TractPort  tractBilling = getTractServicePort(tract[0]);
            
            try{
                SoapApi30Domain.BillingAccount[] billingAccounts = SoapApi30Adapter.getBillingAccounts(tract[0], 'BillingAccount', 'accountNum', accountNumber.Tract_Billing_Account__c, null, null, 'DEEP');
                
                if(billingAccounts.size() > 0){
                    
                
                    String accountEid = billingAccounts[0].eid;
                    billingAccount.eid = accountEid;
                     if(!Test.isRunningTest()) {
                        contactCategory = queryTractByParamAndValue(tract[0], 'PartyCategory', 'name', 'Billing' , null, null, null);
                    } else {
                        contactCategory = SoapApi30TestUtil.getpartyCategories();
                    } 
                          
                    
                    if(contactCategory.successful && null != contactCategory.partyCategories.partyCategory){
                        for (SoapApi30Domain.PartyCategory party  : contactCategory.partyCategories.partyCategory) {
                            partyCat.eid = party.eid;
                        }
                        person.category = partyCat;
                    }
                    addPersonToBillingAccount.billingAccount =  billingAccount;
                    
                    if(currentContact.LastName != null){
                        person.lastName = currentContact.LastName;
                    }
                    
                    if(currentContact.FirstName != null){
                        person.firstName = currentContact.FirstName;
                    }
                    
                    SoapApi30Domain.addresses_element contactAddresses = new SoapApi30Domain.addresses_element();
                                                    
                    if(currentContact.Email != null){
                        SoapApi30Domain.EmailAddress[] contactEmailList =  new List<SoapApi30Domain.EmailAddress>();
            
                        SoapApi30Domain.EmailAddress contactPrimaryEmail = new SoapApi30Domain.EmailAddress();
                        contactPrimaryEmail.email = currentContact.Email;
                        contactPrimaryEmail.purpose = 'PRIMARY';
                        contactEmailList.add(contactPrimaryEmail);
            
                        contactAddresses.emailAddress = contactEmailList;
                    }
                          
                        
                    SoapApi30Domain.PostalAddress[] postaladdressList =  new List<SoapApi30Domain.PostalAddress>();
                    
                    if(currentContact.MailingPostalCode != null || currentContact.MailingCity != null || 
                        currentContact.MailingState != null || 
                        currentContact.MailingStreet != null){
                        
                        SoapApi30Domain.PostalAddress postaladdress =  new SoapApi30Domain.PostalAddress();
                        postaladdress.purpose = 'BILLING';
                        postaladdress.postalCode = currentContact.MailingPostalCode;
                        if(currentContact.MailingCity != null){
                            postaladdress.city = currentContact.MailingCity;
                        }
                        postaladdress.regionOrState = currentContact.MailingState;
                        postaladdress.country = currentContact.MailingCountry;
                        postaladdress.line1 = currentContact.MailingStreet;
                        postaladdressList.add(postaladdress);
                        contactAddresses.postalAddress = postaladdressList;
                    }
                    if(currentContact.Shipping_Zip_Postal_Code__c != null || currentContact.Shipping_City__c != null || 
                        currentContact.Shipping_State_Province__c != null || 
                        currentContact.Shipping_Street__c != null){
                        
                        SoapApi30Domain.PostalAddress postaladdress =  new SoapApi30Domain.PostalAddress();
                        postaladdress.purpose = 'SERVICE';
                        postaladdress.postalCode = currentContact.Shipping_Zip_Postal_Code__c;
                        if(currentContact.MailingCity != null){
                            postaladdress.city = currentContact.Shipping_City__c;
                        }
                        postaladdress.regionOrState = currentContact.Shipping_State_Province__c;
                        postaladdress.country = currentContact.Shipping_Country__c;
                        postaladdress.line1 = currentContact.Shipping_Street__c;
                        postaladdressList.add(postaladdress);
                        contactAddresses.postalAddress = postaladdressList;
                    }
                    if(currentContact.otherPostalCode != null || currentContact.otherCity != null || 
                        currentContact.otherState != null || 
                        currentContact.otherCountry != null){
                        
                        SoapApi30Domain.PostalAddress postaladdress =  new SoapApi30Domain.PostalAddress();
                        postaladdress.purpose = 'SHIPPING';
                        postaladdress.postalCode = currentContact.otherPostalCode;
                        if(currentContact.MailingCity != null){
                            postaladdress.city = currentContact.otherCity;
                        }
                        postaladdress.regionOrState = currentContact.otherState;
                        postaladdress.country = currentContact.otherCountry;
                        postaladdress.line1 = currentContact.otherStreet;
                        postaladdressList.add(postaladdress);
                        contactAddresses.postalAddress = postaladdressList;
                    }
                    SoapApi30Domain.TelecomAddress[] telecomaddressList = new List<SoapApi30Domain.TelecomAddress>();       
                    if(currentContact.Phone != null){
                        string strphone = currentContact.Phone.trim();
                        if(strPhone!=null && strPhone!='' && !strPhone.IsNumeric()){
                            strPhone=strPhone.replaceAll('[^0-9]', '');
                        }
                        SoapApi30Domain.TelecomAddress telecomaddressoffice = new SoapApi30Domain.TelecomAddress();
                        telecomaddressoffice.purpose = 'OFFICE';
                        telecomaddressoffice.number_x = strphone;
                        telecomaddressList.add(telecomaddressoffice);
                        contactAddresses.telecomAddress = telecomaddressList;
                    }
                    if(currentContact.MobilePhone != null){
                        String strmobile = currentContact.MobilePhone;
                        if(strmobile!=null && strmobile!='' && !strmobile.IsNumeric()){
                            strmobile=strmobile.replaceAll('[^0-9]', '');
                        }
                        SoapApi30Domain.TelecomAddress telecomaddressmobile = new SoapApi30Domain.TelecomAddress();
                        telecomaddressmobile.purpose = 'MOBILE';
                        telecomaddressmobile.number_x = strmobile;
                        telecomaddressList.add(telecomaddressmobile);
                        contactAddresses.telecomAddress = telecomaddressList;  
                    }
                         
                    person.addresses = contactAddresses;
                    addPersonToBillingAccount.person = person;
                    SoapApi30Domain.CommandRequest addPersonCommandRequest = new SoapApi30Domain.CommandRequest();
                    addPersonCommandRequest.addPersonToBillingAccount = addPersonToBillingAccount;
                    SoapApi30Domain.CommandResponse commandResAddPerson;
                    try{
                        commandResAddPerson = tractBilling.command(addPersonCommandRequest);
                        if(commandResAddPerson.successful && null != commandResAddPerson.addResponse){
                            Contact tractContact = new Contact(ID =conId);
                            tractContact.Tract_Contact_Eid__c = commandResAddPerson.addResponse.eid;
                            if(TRACTAPIUtil.checkFieldLevelSecurity('Contact', 'Id,Tract_Contact_Eid__c','Update')){
                                update tractContact;
                            }
                        }
                    }
                    catch(Exception e){
                        
                        Emessage = string.valueof(e.getmessage());
                        Emessage = Emessage.substringBetween('Web service callout failed: WebService returned a SOAP Fault:',' faultcode=soap:Server faultactor=');
                        ErrorMessage = Emessage + '.';
                        return ErrorMessage;
                    }
                    if(!commandResAddPerson.successful) {
                        throw new MyException('Unable to add a Person on the Parent Account.');
                    }         
                    else{
                        ErrorMessage = 'Contact has been added to the billing Account successfully.';
                    }
                }
                else{
                    throw new MyException('Parent Account does not exist.');
                }
            }
            catch(Exception e){
                Emessage = string.valueof(e.getmessage());
                Emessage = Emessage.substringBetween('Web service callout failed: WebService returned a SOAP Fault:',' faultcode=soap:Server faultactor=');
                ErrorMessage = Emessage + '.';
                return ErrorMessage;
            }
        }
        return ErrorMessage;  */
        return '';
    }
}