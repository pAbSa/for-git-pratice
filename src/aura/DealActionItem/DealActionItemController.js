/**
 * Created by horc on 4/12/2019.
 */

({
    acceptDeal: function(component, event, helper) {
        component.set("v.status", "Accepted");
        var status = component.get("v.status");
       var dealID = component.get("v.deal").Id;
        console.log("status : " + status);
            var createEvent = component.getEvent("updateDealAction");
                    createEvent.setParams({
                    "deal": dealID,
                    "status": status
                    });

                    createEvent.fire();

var action = component.get("c.debug");
            action.setParams({
                                "something": "accept logged"
                            });
            action.setCallback(this, function(response){
                       var state = response.getState();
                        if (state === "SUCCESS"){
                            component.set("v.accept", true);
                                        component.set("v.reject", true);
                             console.log("accept success");
                        } else {
                            console.log("failed");
                        }
                    });
                    $A.enqueueAction(action);
        },

    rejectDeal: function(component, event, helper) {

         component.set("v.status", "Rejected");
                var status = component.get("v.status");
               var dealID = component.get("v.deal").Id;
                console.log("status : " + status);
                    var createEvent = component.getEvent("updateDealAction");
                            createEvent.setParams({
                            "deal": dealID,
                            "status": status
                            });

                            createEvent.fire();


            var action = component.get("c.debug");
            action.setParams({
                                "something": "reject logged"
                            });
            action.setCallback(this, function(response){
                       var state = response.getState();
                        if (state === "SUCCESS"){
                            component.set("v.accept", true);
                                        component.set("v.reject", true);
                             console.log("reject success");
                        } else {
                            console.log("failed");
                        }
                    });
                    $A.enqueueAction(action);
            },

});