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
 * This Wrapper is used to parse the API response for Address.
 * @author Aman Jain
 */

public with sharing class AddressWrapper {
  @AuraEnabled
  public String type;
  @AuraEnabled
  public String line1;
  @AuraEnabled
  public String line2;
  @AuraEnabled
  public String city;
  @AuraEnabled
  public String state;
  @AuraEnabled
  public String zip;
  @AuraEnabled
  public String country;
  @AuraEnabled
  public String purpose;
}