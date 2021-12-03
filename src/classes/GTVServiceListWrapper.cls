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
 * The wrapper to carry queried service to the lightning component.
 * @author AMAN JAIN
 */
public class GTVServiceListWrapper {
  @AuraEnabled
  public String errorMessage { get; set; }
  @AuraEnabled
  public List<GTVServiceWrapper> serviceList { get; set; }
  @AuraEnabled
  public String currencyCode { get; set; }
}