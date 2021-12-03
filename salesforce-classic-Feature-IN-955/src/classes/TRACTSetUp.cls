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
 * This class is no longer in use but it is global so can’t be deleted from the package.
 * @author AMAN JAIN
 */

global class TRACTSetUp {
  /*
    >>                  savePriceBook FOR   TRACT                 _______________________ 
    */
  webService static String saveServiceResource() {
    String Terrormessage = '';
    return Terrormessage;
  }

  /*
    >>                  savePriceBook FOR   TRACT                 _______________________ 
    */
  webService static String savePriceBook() {
    String Terrormessage = '';
    return Terrormessage;
  }

  public static String setupPriceBookNew(TRACT_Setup__c tractConfig) {
    String returnMessage = '';
    return returnMessage;
  }

  webService static String createUsageEvent(Id opportunityLineItemId) {
    return null;
  }

  //>>                  Save SalesOrder FOR   TRACT                 _______________________

  webService static String saveSalesOrder(String OppId1) {
    String Terrormessage = '';
    return Terrormessage;
  }

  /*
    >>                  setupPriceBook FOR   TRACT                 _______________________ 
    */
  public static String SubmitOpportunity(
    List<Opportunity> thisOppList,
    TRACT_Setup__c tract
  ) {
    String errorMessage = '';
    return errorMessage;
  }
  /*
   * Create TRACT Billing ACcount
   */
  webService static String TRACTAccountCreator(String AccId) {
    return 'The Account is invalid.';
  }

  /*
    >>                 SAVE BILLING ACCOUNT                       _______________________ 
    */
  static String saveAccount(
    TRACT_Setup__c tract,
    List<Account> thisAccountList
  ) {
    return null;
  }
}