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
 * The GTV order creation response wrapper.
 * @author AMAN JAIN
 */

global with sharing class CreateOrderResponse {
  /**
   * A boolean flag that indicates the success and failure of the order creation.
   * @return success
   */
  @AuraEnabled
  public Boolean responseSuccess { get; set; }
  /**
   * The response message for the API callout.
   * @return message
   */
  @AuraEnabled
  public String responseMessage { get; set; }
  /**
   * The GTV id of the order.
   * @return orderId
   */
  @AuraEnabled
  public String gtvOrderId { get; set; }
  /**
   * The GTV id of the billing account.
   * @return orderId
   */
  @AuraEnabled
  public String gtvAccountId { get; set; }
  /**
   * The GTV order number.
   * @return orderId
   */
  @AuraEnabled
  public String gtvOrderNumber { get; set; }
  /**
   * The salesforce account id.
   * @return orderId
   */
  @AuraEnabled
  public String salesforceAccountId { get; set; }
  /**
   * The response code for the API callout.
   * @return responseCode
   */
  @AuraEnabled
  public Integer responseCode { get; set; }
}