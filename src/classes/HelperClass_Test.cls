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
 * This class is a test class of HelperClass class.
 * @author Aman Jain
 */

@isTest
private class HelperClass_Test {
  static testMethod void myUnitTest() {
    OpportunityLineItem oppObj;
    HelperClass.getTract();
    HelperClass.getAccount();
    HelperClass.getOpportunity();
    HelperClass.getPriceBook2();
    HelperClass.getPricebookEntry();
    HelperClass.getServiceresource();
    HelperClass.getProduct2();
    HelperClass.getServicec();
    HelperClass.getAccountCustomField();
    HelperClass.getOpportunityLineItem();
    HelperClass.getAPI1TRACT();
    HelperClass.getAPI2TRACT();
    HelperClass.getSystemSettings();
    HelperClass.getPricelist();
    HelperClass.getAccountCategory();
    HelperClass.getBillCycle();
    HelperClass.getPaymentTerms();
    oppObj = HelperClass.getOpportunityLineItem1();
    System.assertNotEquals(oppObj, null);
  }
  /*static testMethod void myUnitTes1() {
HelperClass.getServicec();
HelperClass.getAccountCustomField();
}   */
}