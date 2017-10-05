<!---This is for the captains to submit their weekly lineup. This will generate a string which they can copy and paste into the submission--->

<!---https://www.cdata.com/kb/tech/gsheets-jdbc-coldfusion-query.rst--->

<!DOCTYPE HYTML>
<html>

<body>
<cfoutput>
<!---
<cfhttp method="get" url="https://docs.google.com/spreadsheets/d/1MA5gSVWkl1Zs5UYexMGcX8QUE-LCdYq8e-Rt2naBRpc/edit#gid=" name="csvDataGet"  
		 columns= "Week,Team,Lineup,Received,Email"> 
		 
	
--->	 
		 <!---
https://docs.google.com/spreadsheets/d/1MA5gSVWkl1Zs5UYexMGcX8QUE-LCdYq8e-Rt2naBRpc/edit#gid=0
		--->
<!---
<cfdump var=#csvDataGet#">

<cfparam name="url.section" default="">
<cfswitch expression="#url.section#">
	<cfcase value="display">
	</cfcase>
	
	<cfdefaultcase>
		<h1>
		<form name="">
		<div id="teamSelectDiv" align="center">
			<div>Select Team</div>
			<div></div>
				
				</tr>
			</table>
	</cfdefaultcase>
</cfswitch>--->
</cfoutput>
</body>
</html>