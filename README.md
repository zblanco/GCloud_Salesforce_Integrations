# Salesforce & Google Cloud Integration Examples

The goal is to build basic demos here that utilize Google Cloud Services in Salesforce. This is mostly for practicing REST/API integrations, but also to make it easier for anyone else to integrate Salesforce with Google's Cloud. This will primarily focus around application integrations, rather than things like SSO, Calendar, or Gmail. I'll be building all of this with the intention that set up on the Google side is minimized, and no middle-man applications are used unless absolutely necessary.

## Priorities/Roadmap: 
1. [Authentication](https://cloud.google.com/docs/authentication/): **IN-PROGRESS**
	* Handle all authentication concerns for 80% of scenarios with Google Services
	* This class or set of classes will be a WIP as more integration examples are built
	* Mostly API Keys or Service Accounts + Stored Certificates authentication methods will be used
	* Will use Auth.JWT/JWS classes when possible as there aren't very many online examples
	* Utilize caching of tokens (although developer orgs have no cache space :( )
2. [Speech API](https://cloud.google.com/speech/docs/): **IN-PROGRESS**
	* Can juggle between recognize and longrunningrecognize usage depending on audio 
	* May set up a hook to an external service to convert audio or get audio metadata as it must be referenced in the request body
	* Want this clean enough that it can be easily used to transcribe voicemails/phone calls etc.
3. [Cloud Storage](https://cloud.google.com/storage/docs/): **NOT STARTED**
	* If possible, utilize the Node.js SDK as a static resource for use in Lightning/Javascript
	* Will mostly revolve around building Lightning components that supply a UI for file storage
	* The file storage UI will be re-used and built on to use other services such as Vision and Speech
	* I'm a total noob at Lightning, so the UI will probably be only for guiding the rest of the development
4. [Vision API](https://cloud.google.com/vision/docs/): **NOT STARTED**
	* I'd like to use this to identify photo uploads to the Cloud Storage
	* I'll look into doing indexing or adding search criteria to the photos for easier searching