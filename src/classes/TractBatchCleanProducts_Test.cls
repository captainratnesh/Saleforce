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

/**
 * This class is a test class of TractBatchCleanProducts class.
 * @author Aman Jain
 */

@isTest
private class TractBatchCleanProducts_Test {
  static testMethod void testBatchMethods() {
    TRACT_Setup__c tractSetup = HelperClass.getTract();
    insert tractSetup;

    Tract_Service_Custom_Field__c tractSerCustFldObj = new Tract_Service_Custom_Field__c();
    System.assert(tractSerCustFldObj != null);
    insert tractSerCustFldObj;

    Tract_Order_Custom_Field__c tractOrdCustFldObj = new Tract_Order_Custom_Field__c();
    System.assert(tractOrdCustFldObj != null);
    insert tractOrdCustFldObj;

    Account_Custom_Field__c tractAccountCustFldobj = new Account_Custom_Field__c();
    System.assert(tractAccountCustFldobj != null);
    insert tractAccountCustFldobj;

    Payment_Term__c paymentTermObj = new Payment_Term__c();
    System.assert(paymentTermObj != null);
    insert paymentTermObj;

    Price_List__c priceListObj = new Price_List__c();
    System.assert(priceListObj != null);
    insert priceListObj;

    TRACT_Bill_Cycle__c billCycleObj = new TRACT_Bill_Cycle__c();
    System.assert(billCycleObj != null);
    insert billCycleObj;

    TRACTBillingAccountCategory__c billingAccountCategory = new TRACTBillingAccountCategory__c();
    System.assert(billingAccountCategory != null);
    insert billingAccountCategory;

    //TractBatchCleanProducts batchObj = new TractBatchCleanProducts(tractSetup);
    //TractBatchCleanProducts.clearPreviousTRACTData();
  }
}