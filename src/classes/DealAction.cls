/**
 * Created by horc on 22/11/2019.
 */

public with sharing class DealAction {
    private String test = 'test';
    public void updateRelatedContactFields(List<Deal_Action__c> oldDealActions) {
        List<String> contactIdList = new List<String>();
        for (Deal_Action__c dealAction : oldDealActions) {
            if (dealAction.Contact__c != null) {
                contactIdList.add(dealAction.Contact__c);
            }
        }
        if (!contactIdList.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Contact', contactIdList);
        }
    }

    public void updateRelatedDealFields(List<Deal_Action__c> oldDealActions) {
        List<String> DealIdList = new List<String>();
        for (Deal_Action__c dealAction : oldDealActions) {
            if (dealAction.Deal__c != null) {
                DealIdList.add(dealAction.Deal__c);
            }
        }
        if (!DealIdList.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Deal__c', DealIdList);
        }
    }

    public void checkValueOnContactField(List<Deal_Action__c> oldDealActions, List<Deal_Action__c> newDealActions) {
        List<String> oldAndNewContactsIdList = new List<String>();
        for (Integer i = 0; i < oldDealActions.size(); i++) {
            if (oldDealActions.get(i).Contact__c != null && newDealActions.get(i).Contact__c != null) {
                if (!oldDealActions.get(i).Contact__c.equals(newDealActions.get(i).Contact__c)) {
                    if (oldDealActions.get(i).Contact__c != null) {
                        oldAndNewContactsIdList.add(oldDealActions.get(i).Contact__c);
                    }
                    if (newDealActions.get(i).Contact__c != null) {
                        oldAndNewContactsIdList.add(newDealActions.get(i).Contact__c);
                    }
                }
            } else if ((oldDealActions.get(i).Contact__c != null && newDealActions.get(i).Contact__c == null)
                    || (oldDealActions.get(i).Contact__c == null && newDealActions.get(i).Contact__c != null)) {

            }
        }
        if (!oldAndNewContactsIdList.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Contact', oldAndNewContactsIdList);
        }
    }

    public void checkValueOnDealField(List<Deal_Action__c> oldDealActions, List<Deal_Action__c> newDealActions) {
        List<String> oldAndNewDealsIdList = new List<String>();
        for (Integer i = 0; i < oldDealActions.size(); i++) {
            if (oldDealActions.get(i).Deal__c != null && newDealActions.get(i).Deal__c != null) {
                if (!oldDealActions.get(i).Deal__c.equals(newDealActions.get(i).Deal__c)) {
                    if (oldDealActions.get(i).Deal__c != null) {
                        oldAndNewDealsIdList.add(oldDealActions.get(i).Deal__c);
                    }
                    if (newDealActions.get(i).Deal__c != null) {
                        oldAndNewDealsIdList.add(newDealActions.get(i).Deal__c);
                    }
                }
            } else if ((oldDealActions.get(i).Deal__c != null && newDealActions.get(i).Deal__c == null)
                    || (oldDealActions.get(i).Deal__c == null && newDealActions.get(i).Deal__c != null)) {
                if (oldDealActions.get(i).Deal__c != null) {
                    oldAndNewDealsIdList.add(oldDealActions.get(i).Deal__c);
                }
                if (newDealActions.get(i).Deal__c != null) {
                    oldAndNewDealsIdList.add(newDealActions.get(i).Deal__c);
                }
            }
        }
        if (!oldAndNewDealsIdList.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Deal__c', oldAndNewDealsIdList);
        }
    }

    public void checkValueOnActionField(List<Deal_Action__c> oldDealActions, List<Deal_Action__c> newDealActions) {
        List<String> contactsToUpdateAcceptanceFieldAndRejectionField = new List<String>();
        List<String> dealsToUpdateAcceptanceFieldAndRejectionField = new List<String>();
        for (Integer i = 0; i < newDealActions.size(); i++) {
            if (oldDealActions.get(i).Action__c != null && newDealActions.get(i).Action__c != null) {
                if (!(oldDealActions.get(i).Action__c).equals(newDealActions.get(i).Action__c)) {
                    if (newDealActions.get(i).Contact__c != null) {
                        contactsToUpdateAcceptanceFieldAndRejectionField.add(newDealActions.get(i).Contact__c);
                    }
                    if (newDealActions.get(i).Deal__c != null) {
                        dealsToUpdateAcceptanceFieldAndRejectionField.add(newDealActions.get(i).Deal__c);
                    }
                }
            } else if ((oldDealActions.get(i).Action__c != null && newDealActions.get(i).Action__c == null)
                    || (oldDealActions.get(i).Action__c == null && newDealActions.get(i).Action__c != null)) {
                if (newDealActions.get(i).Contact__c != null) {
                    contactsToUpdateAcceptanceFieldAndRejectionField.add(newDealActions.get(i).Contact__c);
                }
                if (newDealActions.get(i).Deal__c != null) {
                    dealsToUpdateAcceptanceFieldAndRejectionField.add(newDealActions.get(i).Deal__c);
                }
            }
        }
        if (!contactsToUpdateAcceptanceFieldAndRejectionField.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Contact__c', contactsToUpdateAcceptanceFieldAndRejectionField);
        }
        if (!dealsToUpdateAcceptanceFieldAndRejectionField.isEmpty()) {
            UpdateObject updateObject = new UpdateObject();
            updateObject.updateFieldAcceptanceAndRejection('Deal__c', dealsToUpdateAcceptanceFieldAndRejectionField);
        }
    }

}