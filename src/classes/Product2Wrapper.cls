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
 * This class is a Wrapper class of Product class.
 * @author Aman Jain
 */

public class Product2Wrapper {
  @AuraEnabled
  public boolean isSelected { get; set; }
  @AuraEnabled
  public product2 prod { get; set; }
  @AuraEnabled
  public String errorMessage { get; set; }
}