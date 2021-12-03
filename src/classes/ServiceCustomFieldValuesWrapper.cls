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
 * This class is a Wrapper class of Service Custom Field Values.
 * @author Aman Jain
 */

public class ServiceCustomFieldValuesWrapper {
  @AuraEnabled
  public String name { get; set; }
  @AuraEnabled
  public String eid { get; set; }
  @AuraEnabled
  public String value { get; set; }
  @AuraEnabled
  public List<SelectOption> serviceListType { get; set; }
  @AuraEnabled
  public String serviceListTypeValue { get; set; }
  @AuraEnabled
  public Boolean checkListtype { get; set; }
  @AuraEnabled
  public Boolean datetype { get; set; }
  @AuraEnabled
  public String dateField { get; set; }
  @AuraEnabled
  public String fieldValidationType { get; set; }
  @AuraEnabled
  public String id { get; set; }
}