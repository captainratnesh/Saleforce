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
 * his Wrapper class is used to parse the API response for the Product Custom Field Values.
 * @author Aman Jain
 */

public with sharing class ProductCustomFieldValueWrapper {
  @AuraEnabled
  public String name { get; set; }
  @AuraEnabled
  public String eid { get; set; }
  @AuraEnabled
  public String value { get; set; }
}