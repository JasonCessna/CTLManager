
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
		<cfset accessLevel = "">
		<cfset session.token = result.token>
		<cfset profile = application.google.getProfile(session.token.access_token)>
		<cfset email = profile.email>
		<cfset authList = getUserAccess(session.token.access_token)>
		<cfloop from="2" to="#ArrayLen(authList.values)#" index="i">
			<cfif authList.values[i][2] EQ email>
				<cfset accessLevel = authList.values[i][4]>
				<cfset accessTeam = authList.values[i][3]>
			</cfif>
		</cfloop>
		<center>
		<cfif accessLevel NEQ "">
		
			<cflocation url="http://www.duttles.com/captain.cfm?teamAccess=#accessTeam#&access=#hash(trim(accessLevel))#">
		<!---
			Welcome #userName# (#email#). You are currently logged in as a #accessLevel# <cfif accessLevel NEQ "ADMIN">for team #accessTeam#</cfif>.<br/>
			<cfif accessLevel EQ "ADMIN" OR accessLevel EQ "CAPTAIN">
				<a href="http://www.duttles.com/captain.cfm?teamAccess=#accessTeam#&access=#hash(trim(accessLevel))#">Captains</a><cfif accessLevel EQ "ADMIN"> - for lineups and score submissions</cfif><br/>
			</cfif>
			<cfif accessLevel EQ "ADMIN">
				<a href="http://www.duttles.com/captain.cfm?access=#hash(trim(accessLevel))#">Admins</a> - for getting auto-generated code and changing season settings.
			</cfif>
		<cfelse>
		--->
		</cfif>
		</center>

 </cfcase>
 <cfdefaultcase>
	 <cfset authurl = application.google.generateAuthUrl(application.callback, session.urltoken)>

	

	
	<cfoutput>
		<p><div align="center"><h1>
		<a href="#authurl#">LOGIN WITH GOOGLE TO CONTINUE</a></h1></div>
		</p>
		<div align="center">Note: your first time to log-in will prompt you to give this app access to drive, sheets, and your email.<br/>
							This asking so you are allowing google to use your credentials to update forms on MY end, not so we can access yours.<br/>
							To access your information (besides your email address) I would need the unique ID's for each document, which I don't have. Cheers! - Duttles</div>
	</cfoutput>
</cfdefaultcase>

</cfswitch>
<BODY>

</BODY>

</cfoutput>
</HTML>