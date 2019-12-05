/**
 * Created by horc on 3/12/2019.
 */

({
    doInit: function(component, event, helper){
            var action = component.get("c.getAllAvailableDeals");
            action.setParams({
                "dateOfToday": $A.localizationService.formatDate(new Date(), "YYYY-MM-DD")
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    component.set("v.deals", response.getReturnValue());
                }
                else {
                    console.log("Failed with state: " + state);
                }
            });

            $A.enqueueAction(action);
        },

        handleUpdateDealAction: function(component, event, helper) {
                var deal = event.getParam("deal");
                var action = event.getParam("status");
                var contactID = component.get("v.recordId");
                console.log("deal :" + deal);
                console.log("action :" + action);
                console.log(JSON.stringify(deal) + ":" + JSON.stringify(action));
                var dealAction = { 'sobjectType': 'Deal_Action__c',
                                                              'Action__c': action,
                                                              'Contact__c': contactID,
                                                              'Deal__c': deal,
                                                              'Deal_Date__c' :  $A.localizationService.formatDate(new Date(), "YYYY-MM-DD")
                                                              };

                var action = component.get("c.saveDealAction");
                console.log("Analyse the dealAction object properties 7: " + JSON.stringify(dealAction));
                action.setParams({
                    "dealAction":dealAction
                });
                action.setCallback(this, function(response){
                   var state = response.getState();
                    if (state === "SUCCESS"){
                           console.log("deal action record is successfully created in database.");
                        //todo: create a pop up message to notify user over the successful transaction with database.
                    } else {
                        console.log("deal action record failed to save.");
                    }
                });
                $A.enqueueAction(action);

            },

});