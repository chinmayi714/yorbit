<cfif isdefined("action") and action is "updateName">
	<cfquery name="updateName" datasource="#siteDataSource#">
		update tcPic set mapName = '#nameIn#' where refnum = #mapIn#
	</cfquery>
<cfabort>	
</cfif>

<cfif isdefined("action") and action is "removeMap">
	<cfquery name="remove" datasource="#siteDataSource#">
		delete from tcPic where refnum = #mapIn#
	</cfquery>
</cfif>

<cfquery datasource="#siteDataSource#" name="getData">
	select * from tcPic where user = #session.user#
</cfquery>

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>App</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="/favicon.ico">
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>

    </head>
    <body>
        <!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <header>
            <div class="container">
                <div class="logo">
                    <a href="/">
                        <img src="/images/logo.png" alt="Yorb.it" title="Yorb.it Logo" />
                    </a>
                </div>
                <div class="navigation-button" id="trigger-overlay">
                    <img src="/images/menu_button.png" />
                </div>
            </div>
        </header>
        <div class="overlay overlay-door">
            <div class="close_button">
                <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
            </div>
            <nav class="navigation">
                <ul>					
                    <li><a href="mapCreate.cfm">Add your own earth art</a></li>
                    <li><a href="/">Log out</a></li>
					<li><a href="/">How Does it Work</a></li>
                </ul>
            </nav>
        </div>
		
<div id="mapListContent">
<table border="0" width="900px" cellpadding="5" cellspacing="0" align="center">
<tr><td>Earth Art Name</td><td>Created</td><td></td></tr>

<cfif getData.recordcount is 0>
<tr><td colspan="3">No Earth Art Created</td></tr>
</cfif>

<cfoutput query="getData">
<cfset urlLink = "http://54.186.209.124/viewMap.cfm?mapIn=#refnum#">
<tr>
<td>
<cfif mapName is not "">
	<input type="text" name="#getData.currentrow#NameIn" value="#mapName#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
<cfelse>
	<input type="text" name="#getData.currentrow#NameIn" value="#dateformat(created,'yy-m-d')# . #timeformat(created,'h:mm t')#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
</cfif>

</td>
<td>#dateformat(created,"m/d/yy")# @ #timeformat(created,"h:mm t")#</td>
<td><a href="maplist.cfm?action=removeMap&mapIn=#refnum#"  onClick="return confirm('Are you sure you want to DELETE Map: #mapName# ?');">Remove</a> 
<a href="http://yorb.it/viewArt.cfm?mapIn=#refnum#">View Art</a>
</td></tr>
</cfoutput>

<!--- <cfoutput><tr><td colspan="3"><a href="screen1.cfm" target="_self">Create Earth Art</a></td></tr></cfoutput> --->
<!--- 
<tr><td colspan="3" align="right"><a href="maplist.cfm?logout=true">Log Out</a></td></tr> --->

</table>
<span id="hidSpan" style="visability:hidden;"></span>
		
		</div>


        <script src="../scripts/vendor.js"></script>



        <script src="../scripts/scripts.js"></script>
</body>
</html>
