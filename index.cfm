
<!DOCTYPE HTML>
<cfinclude template="fn_master.cfm">
<cfparam name="url.section" default="">
<cfparam name="url.code" default="">
<HTML>
<cfoutput>

<HEAD>
<meta name="google-site-verification" content="FBl7sa3wilJzJq-3DiHnHrhMQhsfxvUfaO0EUJmhydo" />
</HEAD>
<cfinclude template="google.cfc">
 <cfswitch expression="#url.section#">
 
 <cfcase value="callback">
 
		<cfparam name="url.code" default="">
		<cfparam name="url.state" default="">
		<cfparam name="url.error" default="">
	
		<cfset result = application.google.validateResult(url.code, url.error, url.state, session.urltoken)>

		
		<cfif not result.status>
		  <!--- Imagine a nicer error here. --->
			<cfoutput>
				<h1>Error!</h1>
				#result.message#
			</cfoutput>
		</cfif>
		<cfset session.token = result.token>
		<cfset profile = getProfile(session.token.access_token)>
		<cfset email = profile.email>
		<cfset authList = getUserAccess(session.token.access_token)>
		<cfloop from="2" to="#ArrayLen(authList.values)#" index="i">
			<cfif authList.values[i][2] EQ email>
				<cfset accessLevel = authList.values[i][4]>
				<cfset accessTeam = authList.values[i][3]>
			</cfif>
		</cfloop>
		<cfdump var="#accessLevel# #hash(accessLevel)# #accessTeam#">
		<!---
		<cfset email = getUserEmail(session.token.access_token)>
		<cfdump var="#email#">--->
			<center>
			<cfif accessLevel EQ "ADMIN" OR accessLevel EQ "CAPTAIN">
				<a href="http://duttles.com/ctlmanager/captain/index.cfm?teamAccess=#hash(trim(accessTeam))#&access=#hash(trim(accessLevel))#">Captains</a>
			</cfif>
			<cfif accessLevel EQ "ADMIN">
				<a href="http://duttles.com/ctlmanager/admin/index.cfm?access=#hash(trim(accessLevel))#">Admins</a>
			</cfif>
			</center>
			

 </cfcase>
 <cfdefaultcase>
	 <cfset authurl = application.google.generateAuthUrl(application.callback, session.urltoken)>

	

	
	<cfoutput>
		<p><div align="center"><h1>
		<a href="#authurl#">LOGIN TO CONTINUE</a></h1></div>
		</p>
	</cfoutput>
</cfdefaultcase>

</cfswitch>
<BODY>
<!---<div id="captain">
<input type="button" onclick="" 		name="lineups" 	id="lineups" 	value="TEAM LINEUPS GENERATOR">
</div>
<div id="admin">
<input type="button" onclick="location.href='admin_create_season_template.cfm'" name="maps" 	id="maps"		value="SEASON MAP ORDER GENERATOR">
</div>--->
</BODY>

</cfoutput>
</HTML>