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
 * The billing account creation response wrapper.
 * @author AMAN JAIN
 */

global with sharing class CreateAccountResponse {
  /**
   * A boolean flag that indicates the success and failure of the account creation.
   * @return responseSuccess
   */
  @AuraEnabled
  public Boolean responseSuccess { get; set; }
  /**
   * The GTV id of the account.
   * @return gtvAccountId
   */
  @AuraEnabled
  public String gtvAccountId { get; set; }
  /**
   * The GTV account number of the account.
   * @return gtvAccountNumber
   */
  @AuraEnabled
  public String gtvAccountNumber { get; set; }
  /**
   * The GTV Salesforce account record Id.
   * @return salesforceAccountId
   */
  @AuraEnabled
  public String salesforceAccountId { get; set; }
  /**
   * The response message for the API callout.
   * @return responseMessage
   */
  @AuraEnabled
  public String responseMessage { get; set; }
  /**
   * The response code for the API callout.
   * @return responseCode
   */
  @AuraEnabled
  public Integer responseCode { get; set; }
}