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
** Module Name   : CreateProductWrapper
** Description   : Wrapper class to store information of new product to be created.
**
** Revision History:-
** Version             Date            Author                Description of Action
** 1.0                 07/11/2019      AMAN JAIN             This Wrapper is used to carry the required information while 
                                                             creating a product to the lightning component.      
********************************************************************************************************************/
public with sharing class CreateProductWrapper {
    
    @AuraEnabled
    public List<SelectOption> productTypeList{get;set;}
    @AuraEnabled
    public String productType{get;set;}
    @AuraEnabled
    public String productName{get;set;}
    @AuraEnabled
    public String shortDescription{get;set;}
    @AuraEnabled
    public String Description{get;set;}
    @AuraEnabled
    public String internalName{get;set;}
    @AuraEnabled
    public String externalName{get;set;}
    @AuraEnabled
    public List<SelectOption> productCategoryList{get;set;}
    @AuraEnabled
    public String productCategory{get;set;}
    @AuraEnabled
    public DateTime introductionDate{get;set;}
    @AuraEnabled
    public DateTime salesDiscontinuationDate{get;set;}
    @AuraEnabled
    public String SKU{get;set;}
    @AuraEnabled
    public List<SelectOption> productTagList{get;set;}
    @AuraEnabled
    public List<String> selectedproductTagsList{get;set;}
    @AuraEnabled
    public Boolean consumePrepaidBalance{get;set;}
    @AuraEnabled
    public Boolean fundPrepaidBalance{get;set;}
    @AuraEnabled
    public Boolean taxable{get;set;}
    @AuraEnabled
    public Boolean unique{get;set;}
    @AuraEnabled
    public Decimal defaultQuantity{get;set;}
    @AuraEnabled
    public Boolean agreementMandatory{get;set;}
    @AuraEnabled
    public List<SelectOption> ruleModeList{get;set;}
    @AuraEnabled
    public String ruleMode{get;set;}
    @AuraEnabled
    public Boolean ruleOverride{get;set;}
    @AuraEnabled
    public List<SelectOption> ruleTypeList{get;set;}
    @AuraEnabled
    public String ruleType{get;set;}
    @AuraEnabled
    public List<SelectOption> identifierCategoryList{get;set;}
    @AuraEnabled
    public String identifierCategory{get;set;}
    @AuraEnabled
    public Integer minimumIdentifiers{get;set;}
    @AuraEnabled
    public Integer maximumIdentifiers{get;set;}
    @AuraEnabled
    public String sfdcProductId{get;set;}
    @AuraEnabled
    public String eid{get;set;}
    @AuraEnabled
    public List<SelectOption> productRegisterTypeList{get;set;}
    @AuraEnabled
    public String productRegisterType{get;set;}

    public CreateProductWrapper() {
        ruleMode = 'APPEND';
        ruleType = 'TAPERED';
        defaultQuantity = 1.0;
        unique = true;
        minimumIdentifiers = 0;
        maximumIdentifiers = 0;
        selectedproductTagsList = new List<String>();
        fundPrepaidBalance = false;
        consumePrepaidBalance = false;
    }
}