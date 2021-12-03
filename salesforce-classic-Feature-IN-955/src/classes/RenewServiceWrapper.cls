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
 * This Wrapper is used to carry the service information while renewing a service.
 * @author AMAN JAIN
 */

public class RenewServiceWrapper {
  @AuraEnabled
  public boolean checkOneTimePrice { get; set; }
  @AuraEnabled
  public String serviceProductEid { get; set; }
  @AuraEnabled
  public boolean recurringPrice { get; set; }
  @AuraEnabled
  public list<SelectOption> serviceAgreementList { get; set; }
}