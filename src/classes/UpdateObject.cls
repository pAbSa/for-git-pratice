/**
 * Created by horc on 25/11/2019.
 */

public with sharing class UpdateObject {

    public void updateFieldAcceptanceAndRejection(String objectType, List<String> listOfObjectID) {

        CalculateSumOfDealsOfDifferentObject calculateSumOfDeals = new CalculateSumOfDealsOfDifferentObject(objectType, listOfObjectID);
        List<sObject> objects = new List<sObject>();

        String objectTypeForContact = 'Contact';
        if (objectType.equals('Contact__c')) {
            objectType = objectTypeForContact;
        }

        for (sObject objectToUpdate : Database.query('SELECT Id FROM ' + objectType + ' WHERE Id IN :listOfObjectID')) {
            if (objectToUpdate instanceof Contact) {
                if (calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Accepted') != null) {
                    ((Contact) objectToUpdate).Deals_Accepted__c = calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Accepted');
                }
                if (calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Rejected') != null) {
                    ((Contact) objectToUpdate).Deals_Rejected__c = calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Rejected');
                }
            } else if (objectToUpdate instanceof Deal__c) {
                if (calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Accepted') != null) {
                    ((Deal__c) objectToUpdate).Acceptances__c = calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Accepted');
                }
                if (calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Rejected') != null) {
                    ((Deal__c) objectToUpdate).Rejections__c = calculateSumOfDeals.getSumOfDeals(objectToUpdate.Id).get('Rejected');
                }
            } else {
                System.debug('choice is out of default range, UpdateContact.updateFieldDealsAcceptedOrRejected().');
            }
            objects.add(objectToUpdate);
        }
        update objects;
    }
}