component {

  public function init(clientid, clientsecret) {
		variables.clientid = arguments.clientid;
		variables.clientsecret = arguments.clientsecret;
		return this;
	}

	public string function generateAuthURL(redirecturl, state) {
		/*
		Scope is what you want to do with your access. Since this demo is ONLY for
		auth and user info, we have one hard coded value.
		*/
		return "https://accounts.google.com/o/oauth2/auth?" & 
				 "client_id=#urlEncodedFormat(variables.clientid)#" & 
     			 "&redirect_uri=#urlEncodedFormat(arguments.redirecturl)#" & 
				 "&scope=https://www.googleapis.com/auth/userinfo.profile email https://www.googleapis.com/auth/user.emails.read https://www.googleapis.com/auth/spreadsheets https://www.googleapis.com/auth/drive" & 
				 "&state=#urlEncodedFormat(arguments.state)#
				 &response_type=code";

	}

	public function getProfile(accesstoken) {

		var h = new http();
		h.setUrl("https://www.googleapis.com/oauth2/v1/userinfo");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	
	public function getLineup(accesstoken) {
	
		var h = new http();
		h.setUrl("https://sheets.googleapis.com/v4/spreadsheets/1Zl-gEvvjed7N5KLXHixO5HYewms_FhVAZt-LLEzUW4Y");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	/*
	I handle validating the code result from Google and automatically getting the auth token.
	I should be able to handle any bad result from Google or the user not allowing crap.
	I also validate the state.
	*/
	public struct function validateResult(code, error, remoteState, clientState) {
		var result = {};

		//If error is anything, we have an error
		if(error != "") {
			result.status = false;
			result.message = error;
			return result;
		}

		//Then, ensure states are equal
		if(trim(remoteState) != trim(clientState)) {
			
			result.status = false;
			result.message = "State values did not match. <br/ >Remote: <br />" & remoteState & "<br /> Client: <br />" & clientState;
			return result;
		}

		var token = getGoogleToken(code);

		if(structKeyExists(token, "error")) {
			result.status = false;
			result.message = token.error;
			return result;
		}
		
		result.status = true;
		result.token = token;

		return result;
	}

	//Credit: http://www.sitekickr.com/blog/http-post-oauth-coldfusion
	private function getGoogleToken(code) {
		var postBody = "code=" & UrlEncodedFormat(arguments.code) & "&";
			 postBody = postBody & "client_id=" & UrlEncodedFormat(application.clientid) & "&";
			 postBody = postBody & "client_secret=" & UrlEncodedFormat(application.clientsecret) & "&";
			 postBody = postBody & "redirect_uri=" & UrlEncodedFormat(application.callback) & "&";
			 postBody = postBody & "grant_type=authorization_code";


			var h = new http();
			h.setUrl("https://accounts.google.com/o/oauth2/token");
			h.setMethod("post");
			h.addParam(type="header",name="Content-Type",value="application/x-www-form-urlencoded");
			h.addParam(type="body",value="#postBody#");
			h.setResolveURL(true);
			var result = h.send().getPrefix();
			return deserializeJSON(result.filecontent.toString());

	}
	
	
}
