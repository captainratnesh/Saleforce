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
 * This class is required for authorization while making REST API callouts.
 * @author AMAN JAIN
 */

public with sharing class GTVAPIClient extends GTVAPIRestClient.ApiClient {
  /**
   * constructor to intialize rest api client
   */
  public GTVAPIClient() {
    basePath = 'https://qa-public-api.gotransverse.com/billing/2';
    calloutName = 'TRACT_Billing_API';
    authentications.put(
      'x-api-key',
      new GTVAPIRestClient.ApiKeyHeaderAuth('x-api-key')
    );
    authentications.put(
      'bearer',
      new GTVAPIRestClient.ApiKeyHeaderAuth('Authorization')
    );
  }
  /**
   * constructor to intialize rest api client with tract setting
   * @param tract tract configuration setting
   */
  public GTVAPIClient(TRACT_Setup__c tract) {
    basePath = tract.TRACT_URL2_0__c;
    calloutName = 'TRACT_Billing_API';
    authentications.put(
      'x-api-key',
      new GTVAPIRestClient.ApiKeyHeaderAuth('x-api-key')
    );
    authentications.put(
      'bearer',
      new GTVAPIRestClient.ApiKeyHeaderAuth('Authorization')
    );
  }
}