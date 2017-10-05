component { 
	this.name="googledocs3";
	this.sessionManagement=true; 

	public boolean function onApplicationStart() {
		application.clientid="589990717034-671kugskgj65a6tpt7rofngmh2i2bmpc.apps.googleusercontent.com";
		application.clientsecret="rZUSiH9vUxiQcCjqfNoK2iZL";
		application.callback="http://ctl.manage.org/?section=callback";

        application.google = new google(application.clientid, application.clientsecret);
        return true;
    }

    public boolean function onSessionStart() {
    	session.loggedin = true;

    	return true;
    }
	
	
}

