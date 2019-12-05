/**
 * Created by horc on 27/11/2019.
 */

public with sharing class UtilityCustomTools {
    //creating a list with dummy objects, in order to reuse dealAction.checkValueOnFieldAction();
    public static List<Deal_Action__c> getDummyObjectsList(Integer size) {
        List<Deal_Action__c> oldDealActions = new List<Deal_Action__c>();
        Deal_Action__c dummyObject = new Deal_Action__c();
        for (Integer i = 0; i < size; i++) {
            oldDealActions.add(dummyObject);
        }
        return oldDealActions;
    }
}