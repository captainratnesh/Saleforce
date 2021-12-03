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
 * The service custom field query response wrapper.
 * @author AMAN JAIN
 */
global class QueryServiceCustomFieldResponse {
  public boolean responseSuccess { get; set; }
  public Integer responseCode { get; set; }
  public String responseMessage { get; set; }
  public List<GTVServiceCustomField> serviceCustomFieldList { get; set; }
}