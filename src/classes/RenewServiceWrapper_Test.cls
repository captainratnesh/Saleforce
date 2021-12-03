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
 * This class is a test class of RenewServiceWrapper class.
 * @author Aman Jain
 */

@isTest
private class RenewServiceWrapper_Test {
  static testMethod void myUnitTest() {
    RenewServiceWrapper rsw = new RenewServiceWrapper();
    rsw.checkOneTimePrice = true;
    rsw.RecurringPrice = true;
    rsw.ServiceAgreementList = new List<SelectOption>();
    System.assertEquals(rsw.checkOneTimePrice, true);
  }
}