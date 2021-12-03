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
 * This Wrapper class is used to carry the Activity Event information to the account detail lightning component.
 * @author Aman Jain
 */

public class ActivityEventsWrapper {
  @AuraEnabled
  public List<ActivityUsagesWrapper> getevents { get; set; }
  @AuraEnabled
  public Integer size { get; set; }
}