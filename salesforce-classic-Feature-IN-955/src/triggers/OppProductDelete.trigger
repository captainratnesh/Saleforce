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

/*******************************************************************************************************************
** Module Name   : OppProductDelete
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN             This trigger fires on the deletion of an opportunity line item.   
******************************************************************************************************************************/

trigger OppProductDelete on OpportunityLineItem (after delete) {
    OpportunityLineItem thisOldOli;
    for(OpportunityLineItem theDeltedOli:trigger.old){
        thisOldOli = theDeltedOli;
        break;
    }
    system.debug('thisOldOli::::'+thisOldOli);
    if(thisOldOli != null){
        Product2 pro = [Select id,Serialized__c from Product2 where id=:thisOldOli.Product2Id limit 1];
        integer i = 0;
        if(pro.Serialized__c==true){
            list<OpportunityLineItem> oliList = [Select id,Name,RecurringPrice__c,Price_Override__c,OneTimePrice__c,RecurringProductPriceEid__c,OpportunityId from OpportunityLineItem where OpportunityId =:thisOldOli.OpportunityId AND Price_Override__c = false];
            for(OpportunityLineItem thisOli:oliList){
                if(thisOli.RecurringProductPriceEid__c == thisOldOli.RecurringProductPriceEid__c){
                    i = i+1;
                }
            }
            system.debug('i:::::'+i);
            list<OpportunityLineItem> oppLineItemList = trigger.old;
        OppProductDeleteHelper.processTiering(i,oppLineItemList);  
        }
    }
}