/*----------------------------------------------------------------------------------------------------------------------------
// Project Name..........: <<SYMFORM>>
// File..................: <<BatchForUsageEventGenerate>> 
// Version...............: <<1.0>>
// Created by............: <<Us>>
// Created Date..........: <<4-10-2012>>
// Last Modified Date....: <<4-10-2012>>
// Description...........: <<This Class contain Batch Apex job to generate usage event on TRACT with email as service resource.>>
//---------------------------------------------------------------------------------------------------------------------------*/
/*This class is no longer in use but it is global so can’t be deleted from the package.*/
 global class BatchForUsageEventGenerate implements Database.Batchable<sObject>,Database.AllowsCallouts{
 
  /*Batch Interface start Method implementation*/  
    global Database.QueryLocator start(Database.BatchableContext BC){ 
        return null;
    } 
          
    /*Batch Interface execute Method implementation*/
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    }
    
    /*Batch Interface finish Method implementation*/
    global void finish(Database.BatchableContext BC){
    }
    
   

}