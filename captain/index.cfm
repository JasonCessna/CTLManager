<!---This is for the captains to submit their weekly lineup and match scores. This will generate a string which they can copy and paste into the submission--->
<!DOCTYPE HYTML>
<html>
<meta name="google-site-verification" content="FBl7sa3wilJzJq-3DiHnHrhMQhsfxvUfaO0EUJmhydo" />
<body>
<cfoutput>
<!----- 
-------
BEGIN HEADER
-------
 ----->
 
 <!--- include functions --->
<cfinclude template="../fn_master.cfm">

<!--- define structure for alpha positions in the MASTER SHEET's weekly lineup sheet --->
<cfset alpha = structNew()>
<cfset alpha["lineup1"] = "C">
<cfset alpha["score1"] = "D">
<cfset alpha["lineup2"] = "E">
<cfset alpha["score2"] = "F">
<cfset alpha["lineup3"] = "G">
<cfset alpha["score3"] = "H">
<cfset alpha["lineup4"] = "I">
<cfset alpha["score4"] = "J">
<cfset alpha["lineup5"] = "K">
<cfset alpha["score5"] = "L">
<cfset alpha["lineup6"] = "M">
<cfset alpha["score6"] = "N">
<cfset alpha["lineup7"] = "O">
<cfset alpha["score7"] = "P">
<cfset alpha["lineup8"] = "Q">
<cfset alpha["score8"] = "R">
<cfset alpha["lineup9"] = "S">
<cfset alpha["score9"] = "T">
<cfset alpha["lineup10"] = "U">
<cfset alpha["score10"] = "V">
<cfset alpha["lineup10"] = "W">
<cfset alpha["score10"] = "X">
<cfset alpha["lineup11"] = "Y">
<cfset alpha["score11"] = "AA">
<cfset alpha["lineup12"] = "AB">
<cfset alpha["score12"] = "AC">
<cfset alpha["lineup13"] = "AD">
<cfset alpha["score13"] = "AE">
<cfset alpha["matchup1"] = "B">
<cfset alpha["matchup2"] = "C">
<cfset alpha["matchup3"] = "D">
<cfset alpha["matchup4"] = "E">
<cfset alpha["matchup5"] = "F">
<cfset alpha["matchup6"] = "G">
<cfset alpha["matchup7"] = "H">
<cfset alpha["matchup8"] = "I">
<cfset alpha["matchup9"] = "J">
<cfset alpha["matchup10"] = "K">
<cfset alpha["matchup11"] = "L">
<cfset alpha["matchup12"] = "M">
<cfset alpha["matchup13"] = "N">

<!--- set structure for Race and Team images --->
<cfset structIMG = structNew()>
<cfset structIMG["All-Inspiration"] 	= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-all-in.png">
<cfset structIMG["Guns and Roaches"] 	= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-GunsandRoacheslogo_std.png">
<cfset structIMG["Born Gosu"] 		 	= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-menu.png">
<cfset structIMG["The Confederation"] 	= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-ConFed.png">
<cfset structIMG["Formless Bearsloths"]	= "http://files.enjin.com.s3.amazonaws.com/217407/FxBLogo.png">
<cfset structIMG["Team UnRivaled"] 		= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-UR_menu.png">
<cfset structIMG["LiT Esports"] 		= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-LiT+Small.png">
<cfset structIMG["Daily Life"] 			= "https://s3.amazonaws.com/files.enjin.com/217407/DailyLife3.png">
<cfset structIMG["Valhalla"] 			= "http://files.enjin.com.s3.amazonaws.com/217407/modules/menu/24852745-ctlval.png">
<cfset structIMG["Psionic Aftermath"] 	= "http://files.enjin.com/217407/psiaftermathvertlogo.png">
<cfset structIMG["Taste The Bacon"] 	= "https://s3.amazonaws.com/files.enjin.com/217407/TasteTheBacon.png">
<cfset structIMG["Validity Gaming"] 	= "https://s3.amazonaws.com/files.enjin.com/217407/ValidG.png">
<cfset structIMG["Insight Gaming"]  	= "https://s3.amazonaws.com/files.enjin.com/217407/InsightGaming.png">
<cfset structIMG["Protoss"]				= "http://i.imgur.com/lY0rg.png">
<cfset structIMG["Zerg"]				= "http://i.imgur.com/HRNlj.png">
<cfset structIMG["Terran"]				= "http://i.imgur.com/PZaHh.png">
<cfset structIMG["Random"]				= "http://i.imgur.com/y6wDt.png">
<!--- set structure for Font Colors per team --->
<cfset structCOLOR = structNew()>
<cfset structCOLOR["All-Inspiration"] 		= "aa0000">
<cfset structCOLOR["Guns and Roaches"] 		= "0af3f0">
<cfset structCOLOR["Born Gosu"] 		 	= "ff0000">
<cfset structCOLOR["The Confederation"] 	= "ff0000">
<cfset structCOLOR["Formless Bearsloths"]	= "8811b6">
<cfset structCOLOR["Team UnRivaled"] 		= "2742cd">
<cfset structCOLOR["LiT Esports"] 			= "2790cd">
<cfset structCOLOR["Daily Life"] 			= "ff67aa">
<cfset structCOLOR["Valhalla"] 				= "00FFFF">
<cfset structCOLOR["Psionic Aftermath"]		= "8B0000">
<cfset structCOLOR["Taste The Bacon"] 		= "F8C2B1">
<cfset structCOLOR["Validity Gaming"] 		= "05fea8">
<cfset structCOLOR["Insight Gaming"]  		= "622D75">

<!--- set the range for which map pool to pick from --->
<cfif isDefined('form.week') AND isDefined('form.team')>
	<cfif form.week eq "1">
		<cfset range="B2:B8">
	<cfelseif form.week eq "2">
		<cfset range="E2:E8">
	<cfelseif form.week eq "3">
		<cfset range="H2:H8">
	<cfelseif form.week eq "4">
		<cfset range="K2:K8">
	<cfelseif form.week eq "5">
		<cfset range="B12:B18">
	<cfelseif form.week eq "6">
		<cfset range="E12:E18">
	<cfelseif form.week eq "7">
		<cfset range="H12:H18">
	<cfelseif form.week eq "8">
		<cfset range="K12:K18">
	<cfelseif form.week eq "9">
		<cfset range="B22:B28">
	<cfelseif form.week eq "10">
		<cfset range="E22:E28">
	<cfelseif form.week eq "11">
		<cfset range="H22:H28">
	<cfelseif form.week eq "12">
		<cfset range="K22:K28">
	<cfelseif form.week eq "13">
		<cfset range="N22:N28">
	</cfif>
	<!--- get map rotation for week selected --->
	<cfset weekMaps = getWeekMaps(session.token.access_token,range)>

	<!--- set ranks for map location --->
	<cfset aryMapSlot = ArrayNew(2)>
	<cfset aryMapSlot[1][1] = "Gold">
	<cfset aryMapSlot[2][1] = "Platinum">
	<cfset aryMapSlot[3][1] = "Platinum">
	<cfset aryMapSlot[4][1] = "Diamond 2/3">
	<cfset aryMapSlot[5][1] = "Diamond">
	<cfset aryMapSlot[6][1] = "Diamond">
	<cfset aryMapSlot[7][1] = "Master">
	<!--- define structure for ranks and give them values --->
	<cfset structRanks = structNew()>
	<cfset structRanks["Bronze"] = 1>
	<cfset structRanks["Silver"] = 1>
	<cfset structRanks["Gold"] = 1>
	<cfset structRanks["Plat"] = 2>
	<cfset structRanks["Platinum"] = 2>
	<cfset structRanks["Diamond"] = 3>
	<cfset structRanks["Diamond 2/3"] = 3>
	<cfset structRanks["Diamond2/3"] = 3>
	<cfset structRanks["Diamond 3"] = 3>
	<cfset structRanks["Diamond3"] = 3>
	<cfset structRanks["Diamond 2"] = 3>
	<cfset structRanks["Diamond2"] = 3>
	<cfset structRanks["Diamond 1"] = 4>
	<cfset structRanks["Diamond1"] = 4>
	<cfset structRanks["Master"] = 5>
	<cfset structRanks["Masters"] = 5>
	<cfset structRanks["Master 3"] = 5>
	<cfset structRanks["Masters 3"] = 5>
	<cfset structRanks["Masters3"] = 5>
	<cfset structRanks["Master3"] = 5>
	<cfset structRanks["Master 2"] = 5>
	<cfset structRanks["Masters 2"] = 5>
	<cfset structRanks["Masters2"] = 5>
	<cfset structRanks["Master2"] = 5>
	<cfset structRanks["Master 1"] = 6>
	<cfset structRanks["GM"] = 8>
	<cfset structRanks["Grand Master"] = 8>

	<cfset diffDia23 = 0>
	<cfset diaList = "Diamond 2/3">
	<cfset diaList = listAppend(diaList,"Diamond 2", ",")>
	<cfset diaList = listAppend(diaList,"Diamond 1", ",")>
	<cfset diaList = listAppend(diaList, "Diamond1", ",")>
	<cfset diaList = listAppend(diaList,"Diamond2/3", ",")>
	<cfset diaList = listAppend(diaList,"Diamond3", ",")>
	<cfset diaList = listAppend(diaList,"Diamond 3", ",")>
	<cfset diaList = listAppend(diaList,"Diamond 3", ",")>
	<cfset diaList = listAppend(diaList,"Diamond1", ",")>

	<!--- set map for map location --->
	<cfset aryMapSlot[1][2] = weekMaps.values[1][1]>
	<cfset aryMapSlot[2][2] = weekMaps.values[2][1]>
	<cfset aryMapSlot[3][2] = weekMaps.values[3][1]>
	<cfset aryMapSlot[4][2] = weekMaps.values[4][1]>
	<cfset aryMapSlot[5][2] = weekMaps.values[5][1]>
	<cfset aryMapSlot[6][2] = weekMaps.values[6][1]>
	<cfset aryMapSlot[7][2] = weekMaps.values[7][1]>
	
	<!--- get total team list --->
	<cfset teamList = getTeamID(session.token.access_token)>
	<!--- get specificied team from list --->
	<cfloop from="1" to="#ArrayLen(teamList.values)#" index="i">
		<cfif form.team EQ teamList.values[i][1]>
			<cfset teamID = teamList.values[i][2]>
				<cfset teamLocation = ((i - 2) * 7) + 2>
				<cfset teamMatchupLocation = i>
		</cfif>
	</cfloop>
	<!--- set range for 'get' and 'submit' from the MASTER SHEET's weekly lineups --->
	<cfset getLineupRange 	= alpha["lineup#form.week#"]  & toString(teamLocation) & ":" & alpha["lineup#form.week#"] & toString((teamLocation + 6))>
	<cfset submitLineupRage = alpha["lineup#form.week#"]  & toString(teamLocation)>
	<cfset getScoreRange 	= alpha["lineup#form.week#"]  & toString(teamLocation) & ":" & alpha["score#form.week#"] & toString((teamLocation + 6))>
	<cfset submitScoreRange = alpha["score#form.week#"]   & toString(teamLocation)>
	<cfset getMatchupRange 	= alpha["matchup#form.week#"] & toString(teamMatchupLocation)>
	<cfset roster			= getTeamRoster(session.token.access_token, teamID)>
	
	<!--- get differeciation value for diamond slot (1 = diff, 0 = none) --->
	<cfloop from="2" to="#ArrayLen(roster.values)#" index="i">
		<cfif ListContains(diaList,"#roster.values[i][4]#", ",")>
			<cfset diffDia23 = 1>
		</cfif>
	</cfloop>
	<!--- set rank restrictions for slot --->
	<cfset aryMapSlot[1][3] = 1>
	<cfset aryMapSlot[2][3] = 2>
	<cfset aryMapSlot[3][3] = 2>
	<!--- determine if team differenciates between diamond ranks --->
	<cfif diffDia23 EQ 0>
		<cfset aryMapSlot[4][3] = 3>
		<cfset aryMapSlot[5][3] = 3>
		<cfset aryMapSlot[6][3] = 3>
	<cfelse>
		<cfset aryMapSlot[4][3] = 3>
		<cfset aryMapSlot[5][3] = 4>
		<cfset aryMapSlot[6][3] = 4>
	</cfif>
	<cfset aryMapSlot[7][3] = 5>
	
	<!--- define struct and fill with roster values for dynamic player name calls --->
	<cfset player = StructNew()>
	<cfloop from="1" to="#ArrayLen(roster.values)#" index="i">
		<cfset player["name#roster.values[i][2]#"] = roster.values[i][1]>
		<cfset player["tag#roster.values[i][2]#"] = roster.values[i][2]>
		<cfset player["url#roster.values[i][2]#"] = roster.values[i][3]>
		<cfset player["rank#roster.values[i][2]#"] = roster.values[i][4]>
	</cfloop>
</cfif>

<!--- define section for recursive call --->
<cfparam name="url.section" default="">
<cfif isDefined('form.submit')>
	<cfif isDefined('form.type')>
		<cfset url.section = "#form.type#">
	</cfif>
</cfif>

<!----- 
-------
END HEADER
-------
 ----->
 
 <!----- 
-------
BEGIN MAIN
-------
 ----->
<cfswitch expression="#url.section#">
 <!------------------------
	--------------------------
			LINEUPS
	--------------------------
	------------------------->
	<cfcase value="lineup">
	<cfset weekLineup = getWeeklyLineup(session.token.access_token,getLineupRange)>
		<cfset structPlayer = StructNew()>
		<cfif isDefined('weekLineup.values')>
			<cfloop from="1" to="7" index="i">
				<cfset structPlayer["name#i#"] 	= ListGetAt(weekLineup.values[i][1], 1, '|')>
				<cfset structPlayer["tag#i#"] 	= ListGetAt(weekLineup.values[i][1], 2, '|')>
				<cfset structPlayer["URL#i#"] 	= ListGetAt(weekLineup.values[i][1], 3, '|')>
				<cfset structPlayer["rank#i#"]	= ListGetAt(weekLineup.values[i][1], 4, '|')>
				<cfset structPlayer["race#i#"] 	= ListGetAt(weekLineup.values[i][1], 5, '|')>
			</cfloop>
		</cfif>
		<cfform name="frmTemplate" method="POST" action="http://ctl.manage.org/captain/?section=display">
			<div align="center">
				<h1>Create Template For #form.team#'s Week #form.week# Lineup</h1>
				<table width="60%" cellpadding="5">
					<tr class="uborder">
						<th>League</th>
						<th>Player</th>
						<th>Map</th>
					</tr>
					<cfloop from="1" to="7" index="i">
					<cfif i EQ "1">
					<cfset bg="##d6c31d"> <cfset text="black">
					<cfelseif i EQ "2" OR i EQ "3">
					<cfset bg="##9b9b96"> <cfset text="black">
					<cfelseif i EQ "4" OR i EQ "5" OR i EQ "6">
					<cfset bg="##5f8eaf"> <cfset text="white">
					<cfelseif i EQ "7">
					<cfset bg="##2ebedb"> <cfset text="black">
					</cfif>
					<tr style="background-color:#bg#;color:#text#;" height="25px">
						<td align="center">#aryMapSlot[i][1]#</td>
						<td align="center">
						<!---select dropdown for player list--->
						<select id="player#i#" name="player#i#"style="width:60%; text-align:center;color:black;background-color:white;dropdown-content{background-color=#bg#};"<!---onchange="#setTag(roster.values[x][3])#" ---> >
						<cfif StructKeyExists(structPlayer,"name#i#")>
							<cfif structPlayer["name#i#"] NEQ "Forfeit">
								<option value="#structPlayer['name' & i]#|#structPlayer['tag' & i]#|#structPlayer['url' & i]#|#structPlayer['rank' & i]#|#structPlayer['race' & i]#" selected="selected">
								#structPlayer['name' & i]#</option>
							</cfif>
						</cfif>
						<option value="Forfeit" select="selected">Forfeit</option>
							<cfloop to="2" from="#ArrayLen(roster.values)#" index="x" step="-1">
								<cfif StructKeyExists(structRanks,roster.values[x][4])>
									<cfif structRanks["#roster.values[x][4]#"] LTE aryMapSlot[i][3]>
										<option value="#roster.values[x][1]#|#roster.values[x][2]#|#roster.values[x][3]#|#roster.values[x][4]#|#roster.values[x][5]#" style="text-align:center">#roster.values[x][4]# - #roster.values[x][1]# (#left(roster.values[x][5],1)#)</option>
									</cfif>
								</cfif>
							</cfloop>
						</select>
						</td>
						<td align="center">#aryMapSlot[i][2]#</td>
					</tr>
					</cfloop>
				</table>
				<input type="submit" name="lineupSubmit" id="lineupSubmit" value="SUBMIT" style="width:100px;">
				<input type="hidden" name="submitLineupRage" id="submitLineupRage" value="#submitLineupRage#">
				<input type="hidden" name="week" value="#form.week#">
				<input type="hidden" name="team" value="#form.team#">
				<input type="hidden" name="type" value="display">
			</div>
		</cfform >
	</cfcase>
	<!------------------------
	--------------------------
			SCORES
	--------------------------
	------------------------->
	<cfcase value="scores">
		<cfset weekLineup = getWeeklyLineup(session.token.access_token,getScoreRange)>
		<cfdump var="#weekLineup#">
		<cfset structPlayer = StructNew()>
		<cfif isDefined('weekLineup.values')>
			<cfloop from="1" to="7" index="i">
				<cfset structPlayer["name#ListGetAt(weekLineup.values[i][1], 2, '|')#"] = ListGetAt(weekLineup.values[i][1], 1, '|')>
				<cfif ArrayIsDefined(weekLineup.values[i],2)>
					<cfset structPlayer["score#ListGetAt(weekLineup.values[i][1], 2, '|')#"] = weekLineup.values[i][2]>
				<cfelse>
					<cfset structPlayer["score#ListGetAt(weekLineup.values[i][1], 2, '|')#"] = 0>
				</cfif>
			</cfloop>
			<cfform name="frmTemplate" method="POST" action="http://ctl.manage.org/captain/?section=display">
				<div align="center">
					<h1>Create Template For #form.team#'s Week #form.week# Lineup</h1><br />
					<h3><i>Scores are for total map score. Select 1 for a win and 0 for a loss.</i></h3>
					<table width="60%" cellpadding="5">
						<tr class="uborder">
							<th>League</th>
							<th>Player</th>
							<th>Score</th>
							<th>Map</th>
						</tr>
						
							<cfloop from="1" to="9" index="i">
								<cfif i EQ "1">
									<cfset bg="##d6c31d"> <cfset text="black">
								<cfelseif i EQ "2" OR i EQ "3">
									<cfset bg="##9b9b96"> <cfset text="black">
								<cfelseif i EQ "4" OR i EQ "5" OR i EQ "6">
									<cfset bg="##5f8eaf"> <cfset text="white">
								<cfelseif i EQ "7" OR i EQ "8" OR i EQ "9">
									<cfset bg="##2ebedb"> <cfset text="black">
								</cfif>
								<tr style="background-color:#bg#;color:#text#;" height="25px">
									
									<td align="center">
										<cfif i GTE 7>
											#aryMapSlot[7][1]#
										<cfelse>
											#aryMapSlot[i][1]#
										</cfif>
									</td>
									<td align="center">
										<cfif i GTE 7>
											#structPlayer["name" & ListGetAt(weekLineup.values[7][1], 2, '|')]#
										<cfelse>
											#structPlayer["name" & ListGetAt(weekLineup.values[i][1], 2, '|')]#
										</cfif>
									</td>
									<td align="center">
										<cfif i GTE 7>
											<cfif listlen(structPlayer["score" & ListGetAt(weekLineup.values[7][1], 2, '|')], ",") GT 0>
												<input type="number" name="score#i#" id="score#i#" value="#right(ListGetAt(structPlayer['score' & ListGetAt(weekLineup.values[7][1], 2, '|')], (i % 7) + 1, ','),1)#">
											<cfelse>
												<input type="number" name="score#i#" id="score#i#" value="0">
											</cfif>
										<cfelse>
											<input type="number" name="score#i#" id="score#i#" value="#structPlayer["score" & ListGetAt(weekLineup.values[i][1], 2, '|')]#">
										</cfif>
									</td>
									<td align="center">
										<cfif i LT 8>
											#aryMapSlot[i][2]#
											<input type="hidden" name="map#i#" value="#aryMapSlot[i][2]#" id="map#i#">
										<cfelse>
											
											<select name="map#i#" id="map#i#" required="required">
												<cfif listlen(structPlayer["score" & ListGetAt(weekLineup.values[7][1], 2, '|')], ",") GT 0>
													<option value="#ListGetAt(ListGetAt(structPlayer['score' & ListGetAt(weekLineup.values[7][1], 2, '|')], (i % 7) + 1, ','),1,'|')#" selected="selected">
													#ListGetAt(ListGetAt(structPlayer['score' & ListGetAt(weekLineup.values[7][1], 2, '|')], (i % 7) + 1, ','),1,'|')#</option>
												</cfif>
												<cfloop from="1" to="7" index="y">
													<option value="#aryMapSlot[y][2]#">#aryMapSlot[y][2]#</option>
												</cfloop>
											
											</select>
										</cfif>
									</td>
								</tr>
							</cfloop>
					</table>
					<input type="submit" name="scoresSubmit" id="scoresSubmit" value="SUBMIT" style="width:100px;">
					<input type="hidden" name="submitLineupRage" id="submitLineupRage" value="#submitLineupRage#">
					<input type="hidden" name="week" value="#form.week#">
					<input type="hidden" name="team" value="#form.team#">
					<input type="hidden" name="type" value="display">
					<input type="hidden" name="submitScoreRange" value="#submitScoreRange#">
				</div>
			</cfform >
		<cfelse>
		<h1>No roster submitted. Please submit a lineup before editing scores.</h1>
		</cfif>
	</cfcase>
	<!------------------------
	--------------------------
			DISPLAY
	--------------------------
	------------------------->
	<cfcase value="display">
		<cfif isDefined('form.lineupSubmit')>
			<cfset push = pushTeamRoster(session.token.access_token,form.submitLineupRage,form.player1,form.player2,form.player3,form.player4,form.player5,form.player6,form.player7)>
			Lineup updated.
		</cfif>
		<cfif isDefined('form.scoresSubmit')>
			<cfset masterScores ="">
			<cfloop from="7" to="9" index="i">
				<cfset masterScores = listAppend(masterScores, "#form['map' & i]#", ",") >
				<cfset masterScores = listAppend(masterScores, "#form['score' & i]#", "|") >
			</cfloop>
			<cfset listdeleteat(masterScores, 1, ",")>
			<cfset push = pushTeamRoster(session.token.access_token,form.submitScoreRange,form.score1,form.score2,form.score3,form.score4,form.score5,form.score6,masterScores )>
			Scores updated succesfully
		</cfif>
		
		<cfset weekResults1 	= getWeeklyLineup(session.token.access_token,getScoreRange)>
		<!--- display results? --->
	
	</cfcase>
	<!------------------------
	--------------------------
			SELECTION 
	--------------------------
	------------------------->
	<cfdefaultcase>
		<cfform name="frmTemplate" method="POST" action="http://ctl.manage.org/captain/">
		<div align="center">
			<h1>Create Template For Lineup Submission</h1>
			<div id="weekSelectDiv" align="center">
				
				<div>Select Week</div>
				<div>
					<select name="week" id="week" align="center">
						<option value="1">Week 1</option>
						<option value="2">Week 2</option>
						<option value="3">Week 3</option>
						<option value="4">Week 4</option>
						<option value="5">Week 5</option>
						<option value="6">Week 6</option>
						<option value="7">Week 7</option>
						<option value="8">Week 8</option>
						<option value="9">Week 9</option>
						<option value="10">Week 10</option>
						<option value="11">Round of 6</option>
						<option value="12">Semi-Finals</option>
						<option value="13">Finals</option>
					</select>
				</div>
			</div>
				<div>
					<input type="radio" id="lineup" name="type" value="lineup" required="true">Submit / Edit Weekly Lineup
					<input type="radio" id="scores" name="type" value="scores">Submit / Edit Weekly Match Scores
					<input type="radio" id="display" name="type" value="display">View Matchup And Results
				</div>
			</div>
			<div><input type="submit" name="submit" id="submit" value="SUBMIT"></div>
		</div>
		</cfform>
	</cfdefaultcase>
</cfswitch>
</cfoutput>
</body>
</html>