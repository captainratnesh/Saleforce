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
 * This class is a test class of TabbedAccount_LtController class.
 * @author Aman Jain
 */

@isTest
public class TabbedAccount_LtController_Test {
  static testMethod void myunitTest() {
    Account acc = HelperClass.getAccount();
    insert acc;

    TRACT_Setup__c tractSetup = HelperClass.getTract();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Test.startTest();
    tabbedAccount_LtController.checkBilingAccount(acc.id);
    tabbedAccount_LtController.saveAccount(acc.id);
    Test.stopTest();

    System.assertNotEquals(acc, null);
  }

  static testMethod void myunitTestTwo() {
    Account acc = HelperClass.getAccount();
    insert acc;

    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Test.startTest();
    tabbedAccount_LtController.checkBilingAccount(acc.id);
    tabbedAccount_LtController.saveAccount(acc.id);
    // GlobalGTVActions.createBillingAccount(acc.id);
    Test.stopTest();

    System.assertNotEquals(acc, null);
  }

  static testMethod void myunitTest3() {
    Account acc = HelperClass.getAccount();
    insert acc;

    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Test.startTest();
    tabbedAccount_LtController.checkBilingAccount(acc.id);
    tabbedAccount_LtController.saveAccount(acc.id);
    //GlobalGTVActions.createBillingAccount(acc.id);
    Test.stopTest();

    System.assertNotEquals(acc, null);
  }
  static testMethod void myunitTest4() {
    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    acc.GTV_Account_Category__c = 'testType';
    acc.GTV_Payment_Term__c = 'Net 30';
    acc.GTV_Bill_Cycle__c = 'testBill';
    insert acc;

    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Test.startTest();
    tabbedAccount_LtController.checkBilingAccount(acc.id);
    tabbedAccount_LtController.saveAccount(acc.id);
    //GlobalGTVActions.createBillingAccount(acc.id);
    Test.stopTest();

    System.assertNotEquals(acc, null);
  }
  static testMethod void myunitTest5() {
    Account acc = HelperClass.getAccount();
    acc.GTV_Account_Category__c = 'testType';
    acc.GTV_Payment_Term__c = 'Net 30';
    acc.GTV_Bill_Cycle__c = 'testBill';
    acc.Tract_Billing_Account__c = '123';
    insert acc;

    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Test.startTest();
    tabbedAccount_LtController.checkBilingAccount(acc.id);
    tabbedAccount_LtController.saveAccount(acc.id);
    //GlobalGTVActions.createBillingAccount(acc.id);
    Test.stopTest();

    System.assertNotEquals(acc, null);
  }
}