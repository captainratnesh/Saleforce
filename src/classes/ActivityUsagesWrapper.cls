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
 * This Wrapper is used to parse the API response for Activity Event.
 * @author Aman Jain
 */

public class ActivityUsagesWrapper {
  @AuraEnabled
  public DateTime eventTime { get; set; }
  @AuraEnabled
  public string serviceIdentifier { get; set; }
  @AuraEnabled
  public string referenceID { get; set; }
  @AuraEnabled
  public string sequenceID { get; set; }
  @AuraEnabled
  public string description { get; set; }
  @AuraEnabled
  public String amount { get; set; }
  @AuraEnabled
  public string unitOfMeasure { get; set; }
  @AuraEnabled
  public String totalCharge { get; set; }
  @AuraEnabled
  public string createdDate { get; set; }
  @AuraEnabled
  public string accountNumber { get; set; }
  @AuraEnabled
  public string serviceID { get; set; }
}