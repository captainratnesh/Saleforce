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
 * The DTO to capture the required information for creating a billing account.
 * @author AMAN JAIN
 */

global with sharing class GTVAccount {
  /**
   * The name of the GTV account.
   * @return accountName
   */
  global String accountName { get; set; }
  /**
   * The ISO-3166 3 alpha currency code for the account.
   * @return currencyType
   */
  global String currencyType { get; set; }
  /**
   * The billing account category name of the GTV account.
   * @return billingAccountCategoryName
   */
  global String billingAccountCategoryName { get; set; }
  /**
   * The bill cycle name of the GTV account.
   * @return billCycleName
   */
  global String billCycleName { get; set; }
  /**
   * The payment term name of the GTV account.
   * @return paymentTermName
   */
  global String paymentTermName { get; set; }
  /**
   * The billing Street of the GTV account.
   * @return billingStreet
   */
  global String billingStreet { get; set; }
  /**
   * The billing City of the GTV account.
   * @return billingCity
   */
  global String billingCity { get; set; }
  /**
   * The billing Country of the GTV account.
   * @return billingCountry
   */
  global String billingCountry { get; set; }
  /**
   * The billing State of the GTV account.
   * @return billingState
   */
  global String billingState { get; set; }
  /**
   * The billing Postal Code of the GTV account.
   * @return billingPostalCode
   */
  global String billingPostalCode { get; set; }
  /**
   * The shipping Street of the GTV account.
   * @return shippingStreet
   */
  global String shippingStreet { get; set; }
  /**
   * The shipping City of the GTV account.
   * @return shippingCity
   */
  global String shippingCity { get; set; }
  /**
   * The shipping Country of the GTV account.
   * @return shippingCountry
   */
  global String shippingCountry { get; set; }
  /**
   * The shipping State of the GTV account.
   * @return shippingState
   */
  global String shippingState { get; set; }
  /**
   * The shipping Postal Code of the GTV account.
   * @return shippingPostalCode
   */
  global String shippingPostalCode { get; set; }
  /**
   * The email of the GTV account.
   * @return email
   */
  global String email { get; set; }
  /**
   * The phone number of the GTV account.
   * @return phone
   */
  global String phone { get; set; }
  /**
   * The bill type of the GTV account.
   * @return billType
   */
  global String billType { get; set; }
  /**
   * A boolean flag to capture the tax exemption on the GTV account.
   * @return taxExempt
   */
  global Boolean taxExempt { get; set; }
  /**
   * The create date of the GTV account.
   * @return createDate
   */
  global Date createDate { get; set; }
}