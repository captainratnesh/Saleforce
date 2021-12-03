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
 * This Wrapper is used to carry the Market Place information to the lightning component.
 * @author Aman Jain
 */

public with sharing class MarketPlaceWrapper {
  @AuraEnabled
  public String mplaceId;
  @AuraEnabled
  public String name;
  @AuraEnabled
  public String description;
  @AuraEnabled
  public Date fromDate;
}