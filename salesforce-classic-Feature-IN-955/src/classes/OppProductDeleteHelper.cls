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
 * This class is the helper class for the OppProductDelete trigger.
 * @author AMAN JAIN
 */

public class OppProductDeleteHelper {
  public static void processTiering(
    Integer count,
    list<OpportunityLineItem> thisOli
  ) {
    Product2 pro = [
      SELECT id, Name, Price_Information__c, Serialized__c
      FROM Product2
      WHERE id = :thisOli[0].Product2ID
      LIMIT 1
    ];
    decimal recPrice;
    decimal oneTPrice;
    list<ProductPriceWrapper> listProductPrice = (list<ProductPriceWrapper>) JSON.deserialize(
      pro.Price_Information__c,
      list<ProductPriceWrapper>.class
    );
    for (ProductPriceWrapper priceWrap : listProductPrice) {
      if (
        priceWrap.priceType == 'Recurring' &&
        thisOli[0].RecurringProductPriceEid__c == priceWrap.eid
      ) {
        for (ProductPriceRangeWrapper priceRange : priceWrap.priceRangesList) {
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < count &&
              priceRange.quantityEndRange >= count
            ) {
              recPrice = priceRange.price;
              break;
            }
          } else {
            if (priceRange.quantityBeginRange < count) {
              recPrice = priceRange.price;
              break;
            }
          }
        }
      }
      if (
        (priceWrap.priceType == 'OneTime' ||
        priceWrap.priceType == 'one-time') &&
        thisOli[0].priceList_Eid__c == priceWrap.priceListEid
      ) {
        for (ProductPriceRangeWrapper priceRange : priceWrap.priceRangesList) {
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < count &&
              priceRange.quantityEndRange >= count
            ) {
              oneTPrice = priceRange.price;
              break;
            }
          } else {
            if (priceRange.quantityBeginRange < count) {
              oneTPrice = priceRange.price;
              break;
            }
          }
        }
      }
    }
    list<OpportunityLineItem> oliList = [
      SELECT
        id,
        Name,
        UnitPrice,
        TotalPrice,
        Quantity,
        RecurringProductPriceEid__c,
        OpportunityId
      FROM OpportunityLineItem
      WHERE
        RecurringProductPriceEid__c = :thisOli[0].RecurringProductPriceEid__c
        AND OpportunityId = :thisOli[0].OpportunityId
        AND Price_Override__c = FALSE
    ];
    for (OpportunityLineItem changeOliPrice : oliList) {
      if (recPrice != null && oneTPrice != null) {
        changeOliPrice.UnitPrice = oneTPrice + recPrice;
      } else if (recPrice == null && oneTPrice != null) {
        changeOliPrice.UnitPrice = oneTPrice;
      } else if (recPrice != null && oneTPrice == null) {
        changeOliPrice.UnitPrice = recPrice;
      }
    }
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'OpportunityLineItem',
        'Name,UnitPrice,TotalPrice,Quantity,RecurringProductPriceEid__c,OpportunityId',
        'Update'
      )
    ) {
      update oliList;
    }
  }
}