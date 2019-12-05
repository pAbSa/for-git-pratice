/**
 * Created by horc on 21/11/2019.
 */

public with sharing class DealViewerController {

    @AuraEnabled
    public static List<Deal__c> getAllAvailableDeals(Date dateOfToday){
        return [SELECT Id, Name, Acceptances__c, Rejections__c,
                Max_Acceptances__c, Valid_Through__c, Available_Deals__c
        FROM Deal__c WHERE Valid_Through__c > :dateOfToday AND Available_Deals__c > 0];
    }


    @AuraEnabled
    public static List<Deal__c> getAllDealsOfThisContact(String contactID){
        List<String> dealsID = new List<String>();
        for (Deal_Action__c dealAction:[SELECT Deal__c FROM Deal_Action__c WHERE Contact__c = :contactID]){
            dealsID.add(dealAction.Deal__c);
        }
        return getDeals(dealsID);
    }

    private static List<Deal__c> getDeals(List<String> dealsID){
        return [SELECT Id, Name, Acceptances__c, Rejections__c,
                Max_Acceptances__c, Valid_Through__c
        FROM Deal__c WHERE Id IN :dealsID];
    }

    @AuraEnabled
    public static Deal__c saveDeal(Deal__c deal) {
        upsert deal;
        return deal;
    }

    @AuraEnabled
    public static Deal_Action__c saveDealAction(Deal_Action__c dealAction) {
        upsert dealAction;
        return dealAction;
    }

}