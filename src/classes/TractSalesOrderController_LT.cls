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
 * This class is the Controller to handle the order detail module.
 * @author Aman Jain
 */

public class TractSalesOrderController_LT {
  @AuraEnabled
  public static GTVSalesOrderDetailWrapper salesOrderList(string oppId) {
    /**
     *Method to get the Sales Order details.
     *@param oppId Opportunity ID
     *@return orderDetailWrapper
     */
    TRACT_Setup__c tract = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Active__c,
        TRACT_URL2_0__c,
        OrderStatus__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    GTVSalesOrderDetailWrapper orderDetailWrapper = new GTVSalesOrderDetailWrapper();
    if (oppId != null) {
      opportunity thisOpp = [
        SELECT
          Id,
          Name,
          account.id,
          Tract_Sales_Order__c,
          account.Currency_Type__c,
          account.Tract_Billing_Account__c
        FROM Opportunity
        WHERE id = :oppId
        LIMIT 1
      ];
      if (thisOpp.Tract_Sales_Order__c != null) {
        APIDataService dataService = GTVDataService.getService();
        orderDetailWrapper = dataService.getOrderItemList(
          thisOpp.Tract_Sales_Order__c,
          thisOpp.account.Currency_Type__c
        );
        orderDetailWrapper.checkOrder = true;
      }
      String tractUrl;
      if (tract.Api_Version__c == 'API Version 2.0') {
        tractUrl = tract.TRACT_URL2_0__c.replace('api', 'ui');
        tractUrl = tractUrl.remove('/billing/2');
        String orderNum = thisOpp.Tract_Sales_Order__c;
        String accno = thisOpp.account.Tract_Billing_Account__c;
        tractUrl =
          tractUrl +
          '/accounts/' +
          accno +
          '/orders/' +
          orderNum +
          '/orderItems';
      } else {
        tractUrl = tract.TRACT_URL__c;
        tractUrl = tractUrl.substring(0, tractUrl.indexof('com') + 3);
        String orderNum = thisOpp.Tract_Sales_Order__c;
        tractUrl = tractUrl + '/t/w/salesOrder/salesOrderNumber/' + orderNum;
      }
      orderDetailWrapper.tractUrl = tractUrl;
    }
    return orderDetailWrapper;
  }

  public class SalesOrderWrapper {
    @AuraEnabled
    public string tractUrl { get; set; }
    @AuraEnabled
    public Decimal taxShow { get; set; }
    @AuraEnabled
    public Decimal taxTotalShow { get; set; }
    @AuraEnabled
    public Decimal priceShowFinal { get; set; }
    @AuraEnabled
    public String taxShow1 { get; set; }
    @AuraEnabled
    public String taxTotalShow1 { get; set; }
    @AuraEnabled
    public String priceShowFinal1 { get; set; }
    @AuraEnabled
    public List<ProductShowWrapper> productShowWrapper { get; set; }
    @AuraEnabled
    public boolean checkOrder { get; set; }
  }

  public class ProductShowWrapper {
    @AuraEnabled
    public string productName { get; set; }
    @AuraEnabled
    public string shortDescription { get; set; }
    @AuraEnabled
    public string agreementName { get; set; }
    @AuraEnabled
    public string endAction { get; set; }
    @AuraEnabled
    public string agreementPeriod { get; set; }
    @AuraEnabled
    public string agreementEndDate { get; set; }
    @AuraEnabled
    public boolean shortDesc { get; set; }
    @AuraEnabled
    public boolean agreementCheck { get; set; }
    @AuraEnabled
    public boolean appliedTo { get; set; }
    @AuraEnabled
    public String appliedToName { get; set; }
    @AuraEnabled
    public String orderItemEid { get; set; }
    @AuraEnabled
    public boolean serviceVar { get; set; }
    @AuraEnabled
    public list<String> serviceValue { get; set; }
    @AuraEnabled
    public String price { get; set; }
    @AuraEnabled
    public Integer quantity { get; set; }
    @AuraEnabled
    public String total { get; set; }
    @AuraEnabled
    public String recurringPrice { get; set; }
    @AuraEnabled
    public String unitPrice { get; set; }
    @AuraEnabled
    public Decimal taxAmount { get; set; }
    @AuraEnabled
    public Decimal totalOrderAmount { get; set; }
    @AuraEnabled
    public boolean orderItem { get; set; }
    @AuraEnabled
    public TRACT_Setup__c tract { get; set; }
    @AuraEnabled
    public Account thisAccount { get; set; }
    @AuraEnabled
    public String terrorMessage { get; set; }
    @AuraEnabled
    public Decimal priceShow { get; set; }
    @AuraEnabled
    public Decimal taxShow { get; set; }
    @AuraEnabled
    public Decimal taxTotalShow { get; set; }
    @AuraEnabled
    public Decimal priceShowFinal { get; set; }
    @AuraEnabled
    public String tractUrl { get; set; }
    @AuraEnabled
    public opportunity thisOpp { get; set; }
  }
}