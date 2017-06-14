public with sharing class GoogleSpeechAPI {
	
	private final static String SPEECH_ENDPOINT = 'https://speech.googleapis.com/v1/speech:recognize';
	private final static String SPEECH_SCOPE	= 'https://www.googleapis.com/auth/cloud-platform';
	
	private final static String bodyTest = '{"config": {"encoding":"FLAC","sampleRateHertz": 16000,"languageCode": "en-US"},"audio": {"uri":"gs://cloud-samples-tests/speech/brooklyn.flac"}}';

	public static void sendAudio(String payloadUrl) {

		HttpRequest speechAPIRequest = buildSpeechCallout(payloadUrl);

		HttpResponse speechAPIResponse = sendSpeechCallout(speechAPIRequest);
	}

	private static HttpRequest buildSpeechCallout(String payloadUrl) {
		
		HttpRequest req = new HttpRequest();

		req.setMethod('POST');
		req.setEndpoint(SPEECH_ENDPOINT);

		String accessToken = GoogleAuthHandler.getAccessToken(SPEECH_SCOPE);
		
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Authorization', 'Bearer ' + accessToken);

		req.setBody(buildBody(payloadUrl));

		return req;
	}

	private static HttpResponse sendSpeechCallout(HttpRequest speechRequest) {

		HTTP http = new Http();
		HttpResponse res;

		try {
			res = http.send(speechRequest);
		} catch (Exception e) {
			System.debug(e);
		}

		if (res.getStatusCode() != 200) {
			
			System.debug('Unexpected Status Code from Response: ' 
				+ res.getStatusCode() + ' ' + res.getStatus());

		} else {
			System.debug(res.getBody());
		}

		return res;
	}

	private static Map<String, String> getParsedResponse(String JSONResponse) {
		
		Map<String, String> parsedResponse = new Map<String, String>();

		// Do JSON parsing stuff

		return parsedResponse;
	}

	private static String buildBody(String payloadUrl) {
		
		String body = bodyTest;

		return body;
	}

}