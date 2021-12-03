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
 * This class is used for the post installation functionality.
 * @author AMAN JAIN
 */
global class PostInstallClass implements InstallHandler {
  global void onInstall(InstallContext context) {
    if (GTV_Currencies__c.getValues('Currency') == null) {
      GTV_Currencies__c gtvCurrencies = new GTV_Currencies__c();
      gtvCurrencies.name = 'Currency';
      gtvCurrencies.GTV_Currency_List__c = 'USD,AUD,ZAR,COP,EUR,KRW,PKR,SGD,IDR,TWD,MYR,BRL,KWD,BWP,NGN,ARS,CZK,ISK,PHP,CAD';
      insert (gtvCurrencies);
    }
  }
}