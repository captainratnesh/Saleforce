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
 * This class is a test class of ProductUsesWrapper class.
 * @author Aman Jain
 */

@isTest
public class ProductUsesWrapper_Test {
  @isTest
  public static void myTest() {
    ProductUsesWrapper pu = new ProductUsesWrapper();
    pu.chargeName = 'test';
    pu.chargeType = 'test';
    pu.usageRuleEid = '20';
    pu.chargeCategory = 'test';
    pu.taper = 'test';
    pu.rate = '50';
    pu.fromDate = String.valueOf(system.today());
    pu.thruDate = String.valueOf(system.today());
    pu.status = 'Active';
    pu.recordId = '50';
    System.assert(pu != null);

    MyException exp = new MyException('My message');
    System.assert(exp != null);
  }
}