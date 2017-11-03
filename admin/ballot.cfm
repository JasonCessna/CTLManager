<div align="center">
<h1>Ballot Results for the Season 17 Admin Elections (November 2, 2017)</h1>
	<cfset testFile			= "ballot2.csv" >
	<cfhttp method="get" url="http://ctl.ballot/csv/#testFile#" name="csvData"  
			columns= "Timestamp,Email,Handle,FirstVote,SecondVote,ThirdVote,FourthVote"> 
	</cfhttp>

	<cfoutput>
	<cfset candidates 	= StructNew()>

	<cfquery name="qryVotes" dbtype="query">
		SELECT 	Handle,Email,FirstVote,SecondVote,ThirdVote,FourthVote
		FROM	csvData
		order by handle,email,FirstVote,SecondVote,ThirdVote,FourthVote
	</cfquery>
	<cfquery name="qryHandles" dbtype="query">
		select handle from qryVotes
	</cfquery>

	<cfquery name="qryCandidates" dbtype="query">
		SELECT DISTINCT FirstVote as candidateName FROM qryVotes
		where firstVote not in ('',' ', 'null')
	</cfquery>

	<cfloop from="1" to="#qryCandidates.recordcount#" index="x">
		<cfset candidates[QueryGetRow(qryCandidates,x).candidateName] = 0>
	</cfloop>

	<cfquery name="qryFirstVote" dbtype="query">
		select count(firstVote) as totalFirstVotes, firstVote
		from qryVotes
		GROUP BY firstVote
		order by totalFirstVotes
	</cfquery>

	<cfloop query="qryCandidates">
			<cfset canSecond[qryCandidates.candidateName] = 0>
			<cfset canSecondNew[qryCandidates.candidateName] = 0>
			<cfset canSecondNew2[qryCandidates.candidateName] = 0>
			<cfset canThird[qryCandidates.candidateName] = 0>
			<cfset canThirdNew[qryCandidates.candidateName] = 0>
			<cfset canFourth[qryCandidates.candidateName] = 0>
	</cfloop>

	<cfset eliminatedCandidate = qryFirstVote.firstVote>
	<cfset tempCandidates = StructSort(candidates, "numeric")>
	<cfloop query="qryFirstVote">
		<cfset candidates[qryFirstVote.firstVote] = qryFirstVote.totalFirstVotes>
		<cfset canFirst[qryFirstVote.firstVote] = qryFirstVote.totalFirstVotes>
	</cfloop>
	<div id="first">
		<h2>First Round of Votes:</h2>
		This is the first vote count for each candidate.<br/>
		<table cellpadding="10" style="border:1px solid black">
			<tr>
				<th>Name</th>
				<th>First Votes</th>
			</tr>
			<cfloop query="qryFirstVote">
			<tr <cfif qryFirstVote.currentRow EQ "1"> style="background-color:##e5867b" </cfif>>
				<td>#qryFirstVote.FirstVote#</td>
				<td align="center">#qryFirstVote.totalFirstVotes#</td>
			</tr>
			</cfloop>
		</table><br/>
		Eliminated candidate: #eliminatedCandidate#<br/>
	</div>
	<cfquery name="qrySecondVote" dbtype="query">
		SELECT count(secondVote) as totalSecondVotes, secondVote
		from qryVotes
		where firstVote = '#eliminatedCandidate#'
		AND secondVote <> '#eliminatedCandidate#'
		GROUP BY secondVote
		order by totalSecondVotes
	</cfquery>
	<cfloop query="qrySecondVote">
		<cfset candidates[qrySecondVote.secondVote] += qrySecondVote.totalSecondVotes>
		<cfset canSecond[qrySecondVote.secondVote] = qrySecondVote.totalSecondVotes>
	</cfloop>
	<div id="second">
		<h2>Second Round Results:</h2>
		These are the second votes counted for people who voted for #eliminatedCandidate# as their first vote.<br/>
		The new total votes are the newly counted second votes + the previous first votes for the remaining candidates.<br/>
		<table cellpadding="10" style="border:1px solid black">
			<tr>
				<th>Name</th>
				<th>First Votes</th>
				<th>Second Votes</th>
				<th>Updated Total Votes</th>
			</tr>
			<cfloop query="qrySecondVote">
				<tr <cfif qrySecondVote.currentRow EQ "1"> style="background-color:##e5867b" </cfif>>
					<td>#qrySecondVote.secondVote#</td>
					<td align="center">#canFirst[qrySecondVote.secondVote]#</td>
					<td align="center">#qrySecondVote.totalSecondVotes#</td>
					<td align="center">#candidates[qrySecondVote.secondVote]#</td>
				</tr>
			</cfloop>
		</table><br/>
		<cfset candidatesHolder = candidates>
		<cfset candidates = StructSort(candidates,"numeric")>

		<cfset eliminatedCandidate2 = candidates[2]>
		Eliminated candidate: #eliminatedCandidate2#<br/>
	</div>


	<cfquery name="qryThirdVote" dbtype="query">
		select count(thirdVote) as totalThirdVotes, thirdVote, count(secondVote) as totalSecondVotes, secondVote
		from qryVotes
		where (firstVote in ('#eliminatedCandidate#','#eliminatedCandidate2#')
		AND secondVote in ('#eliminatedCandidate#','#eliminatedCandidate2#')
		AND thirdVote NOT IN ('#eliminatedCandidate#','#eliminatedCandidate2#'))
		OR (firstVote = '#eliminatedCandidate2#'
		AND secondVote NOT IN ('#eliminatedCandidate#','#eliminatedCandidate2#'))
		GROUP BY thirdVote,secondVote
		ORDER BY totalThirdVotes desc
	</cfquery>
	<cfloop query="qryThirdVote">
		<cfif qryThirdVote.secondVote NEQ "#eliminatedCandidate#" AND qryThirdVote.secondVote NEQ "#eliminatedCandidate2#">
			<cfset candidatesHolder[qryThirdVote.secondVote] += qryThirdVote.totalSecondVotes>
			<cfset canSecondNew[qryThirdVote.secondVote] += qryThirdVote.totalSecondVotes>
		</cfif>
		<cfif qryThirdVote.secondVote EQ "#eliminatedCandidate#" OR qryThirdVote.secondVote EQ "#eliminatedCandidate2#">
			<cfif  qryThirdVote.thirdVote NEQ "#eliminatedCandidate#" AND qryThirdVote.thirdVote NEQ "#eliminatedCandidate2#">
				<cfset candidatesHolder[qryThirdVote.thirdVote] += qryThirdVote.totalThirdVotes>
				<cfset canThird[qryThirdVote.thirdVote] += qryThirdVote.totalThirdVotes>
			</cfif>
		</cfif>
	</cfloop>

	<cfset candidates = StructSort(candidatesHolder,"numeric")>
	<cfset eliminatedCandidate3 = candidates[3]>

	<cfquery name="qryDistinctThird" dbtype="query">
		select distinct secondVote as name from qryThirdVote
		where secondVote not in ('#eliminatedCandidate#','#eliminatedCandidate2#')
		UNION
		select distinct thirdVote as name from qryThirdVote
		where thirdVote not in ('#eliminatedCandidate#','#eliminatedCandidate2#')
	</cfquery>
	<div id="third">
		<h2>Third Round Results:</h2>
		These are the second votes counted for people who voted for #eliminatedCandidate2# as their first vote<br/>
		and the third votes counted for people who voted for #eliminatedCandidate# as their first vote and #eliminatedCandidate2# as their second vote.<br/>
		The new total votes are the newly counted second votes + third votes + the previous first and second votes for the remaining candidates.<br/>
		<table cellpadding="10" style="border:1px solid black">
			<tr>
				<th>Name</th>
				<th>First Votes</th>
				<th>Second Votes (previous)</th>
				<th>Second Votes (new)</th>
				<th>Third Votes</th>
				<th>Updated Total Votes</th>
			</tr>
			
			<cfloop query="qryDistinctThird">
				<cfif qryDistinctThird.name NEQ eliminatedCandidate AND qryDistinctThird.name NEQ eliminatedCandidate2>
					<tr <cfif qryDistinctThird.currentRow EQ "1"> style="background-color:##e5867b" </cfif>>
						<td>#qryDistinctThird.name#</td>
						<td align="center">#canFirst[qryDistinctThird.name]#</td>
						<td align="center">#canSecond[qryDistinctThird.name]#</td>
						<td align="center">#canSecondNew[qryDistinctThird.name]#</td>
						<td align="center">#canThird[qryDistinctThird.name]#</td>
						<td align="center">#candidatesHolder[qryDistinctThird.name]#</td>
					</tr>
				</cfif>
			</cfloop>
		</table><br/>
		Eliminated candidate: #eliminatedCandidate3#<br/>
	</div>
	<cfloop from="1" to="#arrayLen(candidates)#" index="i">
		<cfif candidates[i] NEQ "#eliminatedCandidate#" AND candidates[i] NEQ "#eliminatedCandidate2#" AND candidates[i] NEQ "#eliminatedCandidate3#"> 
			<cfset winner = candidates[i]>
		</cfif>
	</cfloop>

	<cfquery name="qryFourthVote" dbtype="query">
		select count(FourthVote) as totalFourthVotes, fourthVote, count(thirdVote) as totalThirdVotes, thirdVote, count(secondVote) as totalSecondVotes, secondVote
		from qryVotes
		WHERE (firstVote in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		AND secondVote in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		AND thirdVote IN ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		AND fourthVote NOT IN ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#'))
		OR (firstVote in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		AND secondVote in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		AND thirdVote NOT IN ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#'))
		OR (firstVote = '#eliminatedCandidate3#'
		AND secondVote NOT IN ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#'))
		GROUP BY fourthVote,thirdVote,secondVote
		ORDER BY totalFourthVotes desc
	</cfquery>

	<cfquery name="qryDistinctFourth" dbtype="query">
		select distinct secondVote as name from qryFourthVote
		where secondVote not in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		UNION
		select distinct thirdVote as name from qryFourthVote
		where thirdVote not in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
		UNION
		select distinct fourthVote as name from qryFourthVote
		where fourthVote not in ('#eliminatedCandidate#','#eliminatedCandidate2#','#eliminatedCandidate3#')
	</cfquery>

	<cfloop query="qryFourthVote">
		<cfif qryFourthVote.secondVote NEQ "#eliminatedCandidate#" AND qryFourthVote.secondVote NEQ "#eliminatedCandidate2#" AND qryFourthVote.secondVote NEQ "#eliminatedCandidate3#">
			<cfset candidatesHolder[qryFourthVote.secondVote] += qryFourthVote.totalSecondVotes>
			<cfset canSecond[qryFourthVote.secondVote] += qryFourthVote.totalSecondVotes>
			<cfset canSecondNew2[qryFourthVote.secondVote] += qryFourthVote.totalSecondVotes>
		</cfif>
		<cfif qryFourthVote.secondVote EQ "#eliminatedCandidate#" OR qryFourthVote.secondVote EQ "#eliminatedCandidate2#" OR qryFourthVote.secondVote EQ "#eliminatedCandidate3#">
			<cfif  qryFourthVote.thirdVote NEQ "#eliminatedCandidate#" AND qryFourthVote.thirdVote NEQ "#eliminatedCandidate2#" AND qryFourthVote.thirdVote NEQ "#eliminatedCandidate3#">
				<cfset candidatesHolder[qryFourthVote.thirdVote] += qryFourthVote.totalThirdVotes>
				<cfset canThirdNew[qryFourthVote.thirdVote] += qryFourthVote.totalThirdVotes>
			</cfif>
		</cfif>
		<cfif qryFourthVote.thirdVote EQ "#eliminatedCandidate#" OR qryFourthVote.thirdVote EQ "#eliminatedCandidate2#" OR qryFourthVote.thirdVote EQ "#eliminatedCandidate3#">
			<cfif  qryFourthVote.fourthVote NEQ "#eliminatedCandidate#" AND qryFourthVote.fourthVote NEQ "#eliminatedCandidate2#" AND qryFourthVote.fourthVote NEQ "#eliminatedCandidate3#">
				<cfset candidatesHolder[qryFourthVote.fourthVote] += qryFourthVote.totalFourthVotes>
				<cfset canFourth[qryFourthVote.fourthVote] += qryFourthVote.totalFourthVotes>
			</cfif>
		</cfif>
	</cfloop>
	<div id="fourth">
		<h2>Fourth Round Results:</h2>
		These are the second votes counted for people who voted for #eliminatedCandidate3# as their first vote,<br/>
		the third votes counted for people who voted for #eliminatedCandidate2# or #eliminatedCandidate# as their first vote, <br/>
		and #eliminatedCandidate3# or #eliminatedCandidate2# as their second vote respectively.<br/>
		The new total votes are the newly counted second votes + third votes + fourth votes + the previous first, second, and third votes for the remaining candidates.<br/>
		<table cellpadding="10" style="border:1px solid black">
			<tr>
				<th>Name</th>
				<th>First Votes</th>
				<th>Second Votes (previous)</th>
				<th>Second Votes (new)</th>
				<th>Third Votes (previous)</th>
				<th>Third Votes (new)</th>
				<th>Fourth Votes</th>
				<th>Updated Total Votes</th>
			</tr>
			
			<cfloop query="qryDistinctFourth">
				<cfif qryDistinctFourth.name NEQ eliminatedCandidate AND qryDistinctFourth.name NEQ eliminatedCandidate2>
					<tr <cfif qryDistinctFourth.currentRow EQ "1"> style="background-color:##98dd4d" </cfif>>
						<td>#qryDistinctFourth.name#</td>
						<td align="center">#canFirst[qryDistinctFourth.name]#</td>
						<td align="center">#canSecond[qryDistinctFourth.name]#</td>
						<td align="center">#canSecondNew[qryDistinctFourth.name]#</td>
						<td align="center">#canThird[qryDistinctFourth.name]#</td>
						<td align="center">#canThirdNew[qryDistinctFourth.name]#</td>
						<td align="center">#canFourth[qryDistinctFourth.name]#</td>
						<td align="center">#candidatesHolder[qryDistinctFourth.name]#</td>
					</tr>
				</cfif>
			</cfloop>
		</table><br/>
		<h1>CONGRATULATIONS TO THE WINNER OF THE ELECTION AND NEW ADMIN #winner# !!!</h1>
		<h2>We are happy to apologize for the next six months of your life.</h2>
	</div>
<button name="btnOne" id="btnOne" onclick="firstClick();">Show First Round Results</button>
<button name="btnTwo" id="btnTwo" onclick="secondClick();">Show Second Round Results</button>
<button name="btnThree" id="btnThree" onclick="thirdClick();">Show Third Round Results</button>
<button name="btnFour" id="btnFour" onclick="fourthClick();">Show Final Round Results</button>
</div>

<script>
	window.onload = function() {
		document.getElementById("first").style.display = 'none';
		document.getElementById("second").style.display = 'none';
		document.getElementById("third").style.display = 'none';
		document.getElementById("fourth").style.display = 'none';
	}
	firstClick = function() {
		document.getElementById("first").style.display = 'initial';
		document.getElementById("btnOne").style.display = 'none';
	}
	secondClick = function() {
		document.getElementById("second").style.display = 'initial';
		document.getElementById("btnTwo").style.display = 'none';
	}
	thirdClick = function() {
		document.getElementById("third").style.display = 'initial';
		document.getElementById("btnThree").style.display = 'none';
	}
	fourthClick = function() {
		document.getElementById("fourth").style.display = 'initial';
		document.getElementById("btnFour").style.display = 'none';
	}

</script>

</cfoutput>
<cfabort>

