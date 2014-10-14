
var GOOGLE_AUTOCOMPLETE_API_KEY = "AIzaSyC52xwGjuNVfBq4yHlQiGrlswCERkZZ16w";

// http://blog.parse.com/2013/03/19/implementing-scalable-search-on-a-nosql-backend/
var _ = require("underscore");
Parse.Cloud.beforeSave("Event", function(request, response) {
	
	var anEvent = request.object;
	
	if (anEvent.get("activity") == null) {
		response.error("activity is missing");
	} 
	else if (anEvent.get("name") == null) {
    	response.error("name is missing");
  	} 
	else if (anEvent.get("date") == null) {
		response.error("date is missing");
  	} 
	else if (anEvent.get("creator") == null) {
		response.error("creator is missing");
  	} 
	else if (anEvent.get("location") == null) {
		response.error("location is missing");
  	}
	else {
		/*
	    var toLowerCase = function(w) { return w.toLowerCase(); };

	    var words = anEvent.get("detail").split(/\b/);
	    words = _.map(words, toLowerCase);
	    var stopWords = ["the", "in", "and"];
	    words = _.filter(words, function(w) { return w.match(/^\w+$/) && ! _.contains(stopWords, w); });

	    var hashtags = anEvent.get("text").match(/#.+?\b/g);
	    hashtags = _.map(hashtags, toLowerCase);

	    anEvent.set("words", _.uniq(words));
	    anEvent.set("hashtags", _.uniq(hashtags));*/
	    response.success();
	}
});


Parse.Cloud.define("JoinEvent", function(request, response) {
	var eventQuery = new Parse.Query("Event");
	eventQuery.equalTo("objectId", request.params.eventId);
	
	eventQuery.find({
		success : function(events) {
			// TODO: Check to make sure user is not already an attendee
			var anEvent = events[0];
			var eventAttendees = user.relation("attendees");
			eventAttendees.add(Parse.User.current());
			anEvent.increment("attendeeCount");
			anEvent.save(null, {
				success : function(carpoolRequest) {
					response.success();
				},
				error :function(object, error) {
					console.error(error);
			    	response.error("There was a problem joining this event");
				}
			});
		},
		error : function(object, error) {
			console.error(error);
	    	response.error("There was a problem joining this event");
		}
	});
});


Parse.Cloud.define("LeaveEvent", function(request, response) {
	var eventQuery = new Parse.Query("Event");
	eventQuery.equalTo("objectId", request.params.eventId);
	
	eventQuery.find({
		success : function(events) {
			// TODO: Check to make sure user is attending the event
			var anEvent = events[0];
			var eventAttendees = user.relation("attendees");
			eventAttendees.remove(Parse.User.current());
			anEvent.increment("attendeeCount", -1);
			anEvent.save(null, {
				success : function(carpoolRequest) {
					response.success();
				},
				error :function(object, error) {
					console.error(error);
			    	response.error("There was a problem joining this event");
				}
			});
		},
		error : function(object, error) {
			console.error(error);
	    	response.error("There was a problem joining this event");
		}
	});
});


Parse.Cloud.define("Autocomplete", function(request, response) {
  
	var input = request.params.query;
	var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?types=geocode&input=" + input + "&key=" +  GOOGLE_AUTOCOMPLETE_API_KEY;
	url = url.replace(" ", "+");

	Parse.Cloud.httpRequest({
	  	method: "GET",
	  	url: url,
	  	success: function(httpResponse) {
	    	response.success(httpResponse.text);
	  	},
		error: function(error) {
			console.error(error);
			response.error("Failed to request autocomplete api ");
		}
	});
});


Parse.Cloud.define("UserNotificationSetting", function(request, response) {
	Parse.Cloud.useMasterKey();
	var notificationSettingsQuery = new Parse.Query("NotificationSetting");
	
	notificationSettingsQuery.find({
		success: function(notificationSettings) {
			var userNotificationSettingsQuery = new Parse.Query("UserNotificationSetting");
			userNotificationSettingsQuery.equalTo("user", Parse.User.current());
			userNotificationSettingsQuery.include("notificationSetting");
			
			userNotificationSettingsQuery.find({
				success: function(userSettings) {

					var newUserSettings = [];
					
					for (var i=0 ; i<notificationSettings.length ; i++) {
						var notificationSetting = notificationSettings[i];
						var userSettingExists = false;
						
						for (var j=0 ; j<userSettings.length ; j++) {
							var userSetting = userSettings[j];
							if (userSetting.get("notificationSetting").id == notificationSetting.id) {
								newUserSettings.push(userSetting);
								userSettingExists = true;
								break;
							}
						}
						
						if (userSettingExists == false) {
							var UserNotificationSetting = Parse.Object.extend("UserNotificationSetting");
							var userSetting = new UserNotificationSetting();
							userSetting.set("user", Parse.User.current());
							userSetting.set("notificationSetting", notificationSetting);
							userSetting.set("enabled", notificationSetting.get("defaultValue"));
							newUserSettings.push(userSetting);
						}
					}
					
					Parse.Object.saveAll(newUserSettings, {
				    	success: function(list) {
				      		response.success(newUserSettings);
				    	},
				    	error: function(error) {
				      		console.error(error);
					    	response.error("Failed to read notification settings");
				    	}
					});
				},
				error: function(object, error) {
					console.error(error);
			    	response.error("Failed to read notification settings");
				}
			});
		},
		error: function(object, error) {
			console.error(error);
	    	response.error("Failed to read notification settings");
		}
	});
});