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
 * This class is the test class for postInstallClass.
 * @author AMAN JAIN
 */

@isTest
public with sharing class TestPostInstallClass {
  @isTest
  public static void testInstallScript() {
    PostInstallClass postinstall = new PostInstallClass();
    Test.testInstall(postinstall, null);
    GTV_Currencies__c gtvCurrencies = GTV_Currencies__c.getValues('Currency');
    System.debug('gtvCurrencies ' + gtvCurrencies);
  }
}