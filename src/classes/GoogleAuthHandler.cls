// Goal: Make re-usable for any G-Cloud authentication
public class GoogleAuthHandler {

	private final static String AUTH_ENDPOINT = 'https://www.googleapis.com/oauth2/v4/token';
	private final static String CACHE_ACCESS_TOKEN_KEY = 'googleCloudAccessToken';

	public static String getAccessToken(String scope) {

		// Platform Cache has no capacity in dev orgs, so a new token is fetched every time
		if (Cache.Org.contains(CACHE_ACCESS_TOKEN_KEY)) {
			
			System.debug('## Getting AccessToken from cache');

			String cachedAccessToken = (String) Cache.Org.get(CACHE_ACCESS_TOKEN_KEY);
			return cachedAccessToken;

		} else {
			
			String token = fetchNewAccessToken(scope);
	        return token;
		}
	}

	private static String fetchNewAccessToken(String scope) {

		System.debug('## No cached access token exists, fetching a new one');

		Auth.JWT jwt 			     = new Auth.JWT();
		GoogleCloud__c credentials   = GoogleCloud__c.getOrgDefaults();
		String serviceAccountEmail   = credentials.ServiceAccountEmailAddress__c;
		Map<String, Object> claimMap = buildClaimMap(scope);

		jwt.setIss(serviceAccountEmail);
		jwt.setAud(AUTH_ENDPOINT);
		jwt.setAdditionalClaims(claimMap);

		// 'google_cloud' cert created using java keytool converting p12 to jks
		Auth.JWS jws = new Auth.JWS(jwt, 'google_cloud');

		// may throw a Auth.JWTBearerTokenExchange.​JWTBearerTokenExchangeException​
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(AUTH_ENDPOINT, jws);

        String token = bearer.getAccessToken();

        cacheAccessToken(token);

        return token;
	}

	private static Map<String, Object> buildClaimMap(String scope) {

		Map<String, Object> claimMap = new Map<String, Object>();

		String issueTime 	  = getIssueTime();
		String expirationTime = getExpirationTime(issueTime);

		claimMap.put('scope', scope);
		claimMap.put('iat',   issueTime);
		claimMap.put('exp',   expirationTime);

		return claimMap;
	}

	private static String getExpirationTime (String issueTime) {
		
		Long longIssueTime = Long.valueOf(issueTime);
		String expTime 	   = String.valueOf(longIssueTime - 3600); // Hour expiration time
		return expTime;
	}

	private static String getIssueTime () {
		
		Long timeSince = System.now().getTime();
		String iatTime = String.valueOf(timeSince);
		return iatTime;
	}

	private static void cacheAccessToken(String accessToken) {
	    Cache.Org.put(CACHE_ACCESS_TOKEN_KEY, accessToken, 3600 - 30);
	}

	public static Boolean clearAccessToken() {
	    return Cache.Org.remove(CACHE_ACCESS_TOKEN_KEY);
	}


}