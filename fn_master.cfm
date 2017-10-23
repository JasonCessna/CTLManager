<!---
-----------------SHEET IDS----------------
MASTER LIST:	1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24 	(sheet: MASTER)
User list: 		1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24 	(sheet: Users)
Matchup List:	1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24 	(sheet: WeeklyMatchups)
S17 Maps: 		1CkaYbVHdbUKP2_yNpd-xKkhctgdajwhOyccCaBVCgpw  

----TEAMS:
Allin:			1cJFkiL0O0KlcrpjlVmSmUdH-juVoZ65Z1eSbR93uyWk
BG:				1julvYxqCKt5wLGcl3HmwcRwLpJzHNRl095FL-YOP83c
Confed:			1C7HVn_OyE4zxSpHerTeZYbA7ksP4qLH7KrxNEP9S40Q
DLife:			1xVOP-S60t1T0FLcn-d0WI-iNr-2T9Xo1Ra0_W2HHIU8
FxB: 			1lYHINuspaLsNc5VgV7e-P1VXFkrxESZDwBi0XZ2Oeg4
GnR:			1rUbmUVEK62Pba42UVjkkw9mAbIhCglRuNBXmDD-6-I0
InGT:			1x-DVgblRmRd6ziR2a5TF-VBWiEkbteVv_ZHBvdaLWXs
LiT:			1JxqAs5m80ZK2W2JUDEcs0k9tgkV_5D3EKWr5pB0HcCk
PsiX:			1yGadogoz0o_VfepXRy-Rjz7Mq5D2UcbyUFSwtkBLZAU
PigPan:			17813GQjVvF7lHF7rcn1OYgwmxGfeWI02miRuHNEbr90
UR:				15cxJONdgXLsrz5SCGvqS5INrHdF7bpuoL4yL9vMnH7w
VG:				1_QNnn7pHldHOo3Ul2Z5tBAkjXchKQY7JNuUQpmITihc

--->



<cffunction name="changeLocation" access="remote">
<!--- write a query to get all of the locations from a DB with their code and their filepath if we want to make this dynamic --->
<cfargument name="loc" required="true" default="">
<cfswitch expression="#arguments.loc#">
	<cfcase value="capLineup">
		<cfinclude template="captain_submit_lineup.cfm">
	</cfcase>
	
	<cfdefaultcase>
		<cfinclude template="index.cfm">
	</cfdefaultcase>
</cfswitch>

</cffunction>

<cffunction name="getAccessToken"> 
	<cfargument name="code" required="false" default="" type="string"> 
	<cfset var postBody = "code=" & UrlEncodedFormat(arguments.code) & "&">
	<cfset postBody = postBody & "client_id=" & UrlEncodedFormat(application.clientid) & "&"> 
	<cfset postBody = postBody & "client_secret=" & UrlEncodedFormat(application.clientsecret) & "&"> 
	<cfset postBody = postBody & "redirect_uri=" & UrlEncodedFormat(application.callback) & "&"> 
	<cfset postBody = postBody & "grant_type=authorization_code"> 
	<cfhttp method="post" url="https://accounts.google.com/o/oauth2/token"> 
	<cfhttpparam name="Content-Type" type="header" value="application/x-www-form-urlencoded"> 
	
	<cfhttpparam type="body" value="#postBody#"> </cfhttp> <cfreturn deserializeJSON(cfhttp.filecontent.tostring())> 
	
	
 </cffunction>
 
 <!---https://developers.google.com/sheets/api/reference/rest/--->
 <cfscript>
 
	public function getUserAccess(accesstoken) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/Users");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
//this doesn't work.
	 public function getUserEmail(accesstoken,id) {
	
		var h = new http();
		h.setURL("https://people.googleapis.com/v1/people/me");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.addParam(type="path",name="resourceName", value="people/#id#");
		h.addParam(type="query",value="{
		'personFields': 'emailAddresses'}");
		h.setResolveURL(true);
		
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	public function getTeamID(accesstoken) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/MASTER!A:B");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
 public function getMasterList(accesstoken) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/MASTER");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
 public function getLineup1(accesstoken) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1Zl-gEvvjed7N5KLXHixO5HYewms_FhVAZt-LLEzUW4Y/values/roster");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	public function getWeekMatchup(accesstoken,range) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/WeeklyMatchups!#range#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	public function getWeekMaps(accesstoken,range) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1CkaYbVHdbUKP2_yNpd-xKkhctgdajwhOyccCaBVCgpw/values/#range#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	public function getTeamRoster(accesstoken,team) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/#team#/values/A:E");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	public function getWeeklyLineup(accesstoken,range) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/WeeklyLineups!#range#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	public function getWeeklyMatchup(accesstoken,range) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/WeeklyLineups!#range#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	public function getIsLocked(accesstoken,range) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/Master!#range#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	/*
	public function pushTeamRoster(accesstoken,range,player1,player2,player3,player4,player5,player6,player7) {
	
		var h = new http();
		h.setURL("https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/batchUpdate");
		h.setMethod("POST");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.addParam(type="body",value='{
		  "valueInputOption": "USER_ENTERED",
		  "data": [
			{
			  "range": "WeeklyLineups!#range#",
			  "majorDimension": "COLUMNS",
			  "values": [
				["#player1#","#player2#","#player3#","#player4#","#player5#","#player6#","#player7#"]
			  ]
			},
		  ]
		}');
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	} */

 /*
	* arrayToQuery
	* Allows us to convert an array into a single column query.
	* @author	Ryan Mueller @CreativeNotice
	* @created	10/27/2011
	* @param	{Array}		arr	Array to be converted		{required}
	* @param	{String}	colname	Name for query column	{required}	default=col1
	*/
	public Query function arrayToQuery(required array arr,required string colname='col1'){
		var qry = queryNew(arguments.colname);
		for(i=1;i <= ArrayLen(arguments.arr);i=(i+1)){
			queryAddRow(qry);
			querySetCell(qry,arguments.colname,arr[i]);
		}
		return qry;
	}
 
 </cfscript>
 
 <cffunction name="pushTeamroster">
	<cfargument name="accesstoken">
	<cfargument name="range">
	<cfargument name="player1">
	<cfargument name="player2">
	<cfargument name="player3">
	<cfargument name="player4">
	<cfargument name="player5">
	<cfargument name="player6">
	<cfargument name="player7">
	<cfset postBody = '{
                  "range": "WeeklyLineups!#arguments.range#",
		  "majorDimension": "COLUMNS",
                  "values": [	["#arguments.player1#","#arguments.player2#","#arguments.player3#","#arguments.player4#","#arguments.player5#","#arguments.player6#","#arguments.player7#"]]}'>
	<cfhttp method="put" url="https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/WeeklyLineups!#arguments.range#">
		<cfhttpparam type="header" name="Authorization" value="OAuth #arguments.accesstoken#"><cfhttpparam name="Content-Type" type="header" value="application/json"> 
		<cfhttpparam type="header" name="GData-Version" value="3">
		<cfhttpparam type="URL" name="valueInputOption" value="USER_ENTERED">
		<cfhttpparam type="body" value="#postBody#">
	</cfhttp>
<cfset response = cfhttp>
	<cfreturn cfhttp.filecontent>
 </cffunction>
 
<cffunction name="pushTeamSubmitted">
	<cfargument name="accesstoken">
	<cfargument name="range">
	<cfset postBody = '{
                  "range": "Master!#arguments.range#",
		  "majorDimension": "COLUMNS",
                  "values": [	["yes"]]}'>
	<cfhttp method="put" url="https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/Master!#arguments.range#">
		<cfhttpparam type="header" name="Authorization" value="OAuth #arguments.accesstoken#"><cfhttpparam name="Content-Type" type="header" value="application/json"> 
		<cfhttpparam type="header" name="GData-Version" value="3">
		<cfhttpparam type="URL" name="valueInputOption" value="USER_ENTERED">
		<cfhttpparam type="body" value="#postBody#">
	</cfhttp>
	<cfset response = cfhttp>
	<cfreturn cfhttp.filecontent>
</cffunction>
 
<cfoutput>
<cffunction name="setLocked">
	<cfargument name="accesstoken">
	<cfargument name="lockValue">
	<cfset postBody = '{
                  "range": "Master!C2:C13",
		  "majorDimension": "COLUMNS",
                  "values": [	["#arguments.lockValue#"]]}'>
	<cfhttp method="put" url="https://sheets.googleapis.com/v4/spreadsheets/1opwN2mjdPJ1pug9s9tovlFR8wexUn47RNU5504dsi24/values/Master!C2:C13">
		<cfhttpparam type="header" name="Authorization" value="OAuth #arguments.accesstoken#"><cfhttpparam name="Content-Type" type="header" value="application/json"> 
		<cfhttpparam type="header" name="GData-Version" value="3">
		<cfhttpparam type="URL" name="valueInputOption" value="USER_ENTERED">
		<cfhttpparam type="body" value="#postBody#">
	</cfhttp>
	<cfset response = cfhttp>
	<cfreturn cfhttp.filecontent>
 </cffunction>
</cfoutput>
 <cffunction name="getRefreshToken"> 
	<cfargument name="refresh" required="false" default="" type="string"> 
	<cfset var postBody = "client_id=" & UrlEncodedFormat(application.clientid) & "&"> 
	<cfset postBody = postBody & "client_secret=" & UrlEncodedFormat(application.clientsecret) & "&"> 
	<cfset postBody = postBody & "refresh_token=#arguments.refresh#&"> <cfset postBody = postBody & "grant_type=refresh_token"> 
	<cfhttp method="post" url="https://accounts.google.com/o/oauth2/token"> <cfhttpparam name="Content-Type" type="header" value="application/x-www-form-urlencoded"> 
	<cfhttpparam type="body" value="#postBody#"> </cfhttp> <cfreturn deserializeJSON(cfhttp.filecontent.tostring())> 
</cffunction>
