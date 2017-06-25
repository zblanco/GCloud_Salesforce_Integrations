public with sharing class GoogleCloudStorageController {
    
    private static final String CLOUD_STORAGE_BASE_SCOPE = 'https://www.googleapis.com/auth/';
    private static final String readOnlyURI              = 'devstorage.read_only';
    private static final String readWriteURI             = 'devstorage.read_write';
    private static final String fullControlURI           = 'devstorage.full_control';
    private static final String cloudPlatformReadOnlyURI = 'cloud-platform.read-only';
    private static final String cloudPlatformURI         = 'cloud-platform';

    // private static Schema.DescribeSObjectResult[] cloudStorageItemDescResult = Schema.describeSobjects();

    // Add error handling
    @AuraEnabled
    public static String getAccessToken(String actionType) {
        
        String scope = getScopeForAction(actionType);
        String token = GoogleAuthHandler.getAccessToken(scope);
        return token;
    }

    /*@AuraEnabled
    public static Cloud_Storage_Item__c[] getStorageItemsDB(
        Id parentRecord, String parentObjectApiName) {

        //cloudStorageItemSchemaDescription = 

        String queryString = 'SELECT Id, Name, Status__c, Type__c, File_Type__c, Parent_Folder__c FROM Cloud_Storage_Item__c';
        queryString += 'WHERE ';


        return [SELECT Id, Name, 
                       Status__c, Type__c,
                       File_Type__c, Download_URL__c
                FROM   Cloud_Storage_Item__c];
    }*/

    @AuraEnabled
    public static List<Cloud_Storage_Item__c> getStorageItemsDB() {

        //cloudStorageItemSchemaDescription = 

        /*String queryString = 'SELECT Id, Name, Status__c, Type__c, File_Type__c, Parent_Folder__c FROM Cloud_Storage_Item__c';
        queryString += 'WHERE ';*/


        return [SELECT Id, Name, 
                       Status__c, Type__c,
                       File_Type__c, Download_URL__c
                FROM   Cloud_Storage_Item__c];
    }

    @AuraEnabled
    public static String getTemporaryDownloadLink(Id storageItemId) {

        return '';
    }

    // This smells
    private static String getScopeForAction(String actionType) {

        actionType = actionType.toLowerCase();

        String base = CLOUD_STORAGE_BASE_SCOPE;
        String scope;

        if (actionType == 'readonly') {
            scope = base + readOnlyURI;
        }
        else if (actionType == 'readwrite') {
            scope = base + readWriteURI;
        }
        else if (actionType == 'fullcontrol') {
            scope = base + fullControlURI;
        }
        else if (actionType == 'cloudplatformreadonly') {
            scope = base + cloudPlatformReadOnlyURI;
        }
        else if (actionType == 'cloudplatform') {
            scope = base + cloudPlatformURI;
        }
        else {
            System.debug('Unexpected actionType:: ' + actionType);
        }

        return scope;
    }
}