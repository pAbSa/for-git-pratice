/**
 * Created by horc on 21/11/2019.
 */

trigger DealAction on Deal_Action__c (before insert , before update , before delete , after insert, after update , after delete , after undelete ) {

    if (Trigger.isBefore) {

    } else if (Trigger.isAfter) {

        if (Trigger.isInsert) {
            DealAction dealAction = new DealAction();
            dealAction.checkValueOnActionField(UtilityCustomTools.getDummyObjectsList(Trigger.new.size()), Trigger.new);
        } else if (Trigger.isUpdate) {
            DealAction dealAction = new DealAction();
            dealAction.checkValueOnActionField(Trigger.old, Trigger.new);
            dealAction.checkValueOnContactField(Trigger.old, Trigger.new);
            dealAction.checkValueOnDealField(Trigger.old, Trigger.new);
        } else if (Trigger.isDelete) {
            DealAction dealAction = new DealAction();
            dealAction.updateRelatedContactFields(Trigger.old);
            dealAction.updateRelatedDealFields(Trigger.old);
        } else if (Trigger.isUndelete) {
            DealAction dealAction = new DealAction();
            dealAction.updateRelatedContactFields(Trigger.new);
            dealAction.updateRelatedDealFields(Trigger.new);
        }

    }


}