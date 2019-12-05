/**
 * Created by horc on 25/11/2019.
 */

public with sharing class CalculateSumOfDealsOfDifferentObject {

    Map<String, Map<String, Integer>> objectAcceptanceAndRejectionMap = new Map<String, Map<String, Integer>>();

    public CalculateSumOfDealsOfDifferentObject(String objectType, List<String> objects) {
        AggregateResult[] sumOfAcceptanceOrRejectionsOfEachContact = Database.query(
                'SELECT ' + objectType + ', Action__c,  COUNT(Id) sumOfAcceptanceOrRejection' +
                        ' FROM Deal_Action__c' +
                        ' WHERE ' + objectType + ' IN :objects' +
                        ' GROUP BY ' + objectType + ', Action__c'
        );

        String objectID = '';
        Map<String, Integer> actionFieldTypeAndTheirCountReturn;

        for (AggregateResult ar : sumOfAcceptanceOrRejectionsOfEachContact) {
            if (ar.get('Action__c') != null) {
                if (!objectID.equals(String.valueOf(ar.get(objectType)))) {
                    objectID = String.valueOf(ar.get(objectType));
                    actionFieldTypeAndTheirCountReturn = new Map<String, Integer>();
                }

                if (objectAcceptanceAndRejectionMap.get(objectID)==null) {
                    actionFieldTypeAndTheirCountReturn.put(String.valueOf(ar.get('Action__c')), Integer.valueOf(ar.get('sumOfAcceptanceOrRejection')));
                    objectAcceptanceAndRejectionMap.put(String.valueOf(ar.get(objectType)), actionFieldTypeAndTheirCountReturn);

                } else {
                    objectAcceptanceAndRejectionMap.get(objectID).put(String.valueOf(ar.get('Action__c')), Integer.valueOf(ar.get('sumOfAcceptanceOrRejection')));
                }
            }
        }
    }

    public Map<String, Integer> getSumOfDeals(String objectID) {
        return objectAcceptanceAndRejectionMap.get(objectID);
    }

}