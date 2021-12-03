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
 * This class is used to show drop-down list in lightning components.
 * @author AMAN JAIN
 */

public class SelectOption {
  @AuraEnabled
  public String label { get; set; }
  @AuraEnabled
  public String value { get; set; }
  public SelectOption(String value, String label) {
    this.value = value;
    this.label = label;
  }
  public string getValue() {
    return value;
  }
  public string getLabel() {
    return label;
  }
}