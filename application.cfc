component { 
	this.name="googledocs3";
	this.sessionManagement=true; 
	this.sessiontimeout		= createtimespan(0,0,30,0);
	this.applicationtimeout	= createtimespan(0,1,0,0);
	
	public boolean function onApplicationStart() {
		application.clientid="589990717034-671kugskgj65a6tpt7rofngmh2i2bmpc.apps.googleusercontent.com";
		application.clientsecret="rZUSiH9vUxiQcCjqfNoK2iZL";
		application.callback="http://www.duttles.com/ctlmanager/index.cfm?section=callback";

        application.google = new google(application.clientid, application.clientsecret);
        return true;
    }

    public boolean function onSessionStart() {
    	session.loggedin = true;

    	return true;
    }
	
	
}



