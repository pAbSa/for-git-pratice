/**
 * Created by horc on 4/12/2019.
 */

public with sharing class DebugController {


    @AuraEnabled
    public static void debug(String something) {
        System.debug('something : ' + something);
    }

}