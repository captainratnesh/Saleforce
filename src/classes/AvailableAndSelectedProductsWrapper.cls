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
 * This Wrapper is used to carry the available and selectd product in the pricelists.
 * @author AMAN JAIN
 */

public with sharing class AvailableAndSelectedProductsWrapper {
  @AuraEnabled
  public list<String> listOfSelectedProducts { get; set; }
  @AuraEnabled
  public list<selectOption> listOfAvailableProducts { get; set; }
}