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
 **/

/**
 * This class provide method that specify which API to be used to fetch data.
 * @author AMAN JAIN
 */

public with sharing class GTVDataService {
  public static APIDataService dataService;
  /**
   * @description: Method is used to get APIDataService
   * @return GTVDataService, The instance of GTVDataService class.
   */
  public static APIDataService getService() {
    if (dataService == null) {
      createTRACTAPIService();
    }
    return dataService;
  }

  /**
   * @description: this method is used to get APIDataService only when there are changes in API configuration
   * @return APIDataService, The instance of APIDataService class.
   */
  public static APIDataService createTRACTAPIService() {
    // Query TRACT config to get version info
    TRACT_Setup__c tractConfig = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Active__c,
        TRACT_URL2_0__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tractConfig == null) {
      // throw exception
    } else {
      getApiService(tractConfig); // convert
    }

    return dataService;
  }
  /**
   * @description: this method is used to get APIDataService on the basis of API version
   * @param tractConfig configuration setting for tract
   * @return APIDataService, The instance of APIDataService class.
   */
  public static APIDataService getApiService(TRACT_Setup__c tractConfig) {
    GTVAPIVersion apiVersion = TractSFDC_Util.getAPIEnumValue(
      tractConfig.Api_Version__c
    ); // convert
    if (apiVersion == GTVAPIVersion.API_V2) {
      dataService = new GTVRESTDataService();
    } else if (apiVersion == GTVAPIVersion.API_V1) {
      dataService = new GTVSOAP133DataService();
    }
    return dataService;
  }
}