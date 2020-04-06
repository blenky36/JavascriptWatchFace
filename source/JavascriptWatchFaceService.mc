using Toybox.System;
using Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application;

class JavascriptWatchFaceService {

	var constants = new JavascriptWatchFaceConstants();
	var app = Application.getApp();
	
	var baseX = app.getProperty("baseX");
	var baseY = app.getProperty("baseY");
	var keyX = baseX + app.getProperty("keyX");
	var lineBreak = app.getProperty("lineBreak");
	
	var colors = constants.colors;
	
	function setScreenSize() {
		var settings = System.getDeviceSettings();
		
		if(settings.screenHeight == 240 && settings.screenWidth == 240) {
			app.setProperty("baseX", 50);
			app.setProperty("baseY", 20);
			app.setProperty("lineBreak", 23);
		} else if(settings.screenWidth == 250 && settings.screenHeight == 250) {
			app.setProperty("baseX", 50);
			app.setProperty("baseY", 25);
			app.setProperty("lineBreak", 24);
		} else if(settings.screenWidth == 260 && settings.screenHeight == 260) {
			app.setProperty("baseX", 55);
			app.setProperty("baseY", 30);
			app.setProperty("lineBreak", 26);
		} else {
			app.setProperty("baseX", 45);
			app.setProperty("baseY", 20);
			app.setProperty("lineBreak", 22);
		}
	
	}

	
	function colorDrawable(drawable, type) {
    	drawable.setColor(colors[app.getProperty(type + "Color")]);
    }
    
    function positionTopText(topText) {
    	var bY = app.getProperty("baseY");
 
    	topText[0].setLocation(app.getProperty("baseX"), bY);
    	topText[1].setLocation(topText[0].locX + topText[0].width, bY);
    	topText[2].setLocation(topText[1].locX + topText[1].width + 5, bY + 2);
    	topText[3].setLocation(topText[2].locX + topText[2].width + 5, bY);    	    	
    	
    }


	function showAndPositionTime(key, value, comma) {
		var timeString = getDateTime("time");
		var bY = app.getProperty("baseY");
		var kX = app.getProperty("baseX") + app.getProperty("keyX");
		var lb = app.getProperty("lineBreak");
		
        value.setText("'" + timeString + "'");
        value.setLocation(kX + key.width, bY + lb);
        
        comma.setLocation(kX + key.width + value.width + 2.5, bY + lb -4);
    }

	function showAndPositionBattery(key, value, comma) {
        var battery = System.getSystemStats().battery.toNumber();
        var bY = app.getProperty("baseY");
		var kX = app.getProperty("baseX") + app.getProperty("keyX");
		var lb = app.getProperty("lineBreak");
   
        value.setText("'" + battery + "%'");
        value.setLocation(kX + key.width, bY + (2*lb));
        
        comma.setLocation(kX + key.width + value.width + 2.5, bY + (2*lb) -4);
    }
    
    function showAndPositionDate(key, value, comma) {
        var dateString = getDateTime("date");
        var bY = app.getProperty("baseY");
		var kX = app.getProperty("baseX") + app.getProperty("keyX");
		var lb = app.getProperty("lineBreak");
       
        value.setText("'" + dateString + "'");
        value.setLocation(kX + key.width, bY + (3*lb));
        
        comma.setLocation(kX + key.width + value.width + 2.5, bY + (3*lb) -4);
        
    }
    
    function showAndPositionHR(key, value, comma) {
        var hr = Activity.getActivityInfo().currentHeartRate;
        var bY = app.getProperty("baseY");
		var kX = app.getProperty("baseX") + app.getProperty("keyX");
		var lb = app.getProperty("lineBreak");
    
        if(hr == null) {
        	hr = " - ";
       	}

        value.setText("'" + hr + "'");
        value.setLocation(kX + key.width, bY + (4*lb));
        comma.setLocation(kX + key.width + value.width + 2.5, bY + (4*lb) -4);
    }
		
	function showAndPositionStepsAndCalories(sKey, sValue, comma, cKey, cValue) {
       	var info = ActivityMonitor.getInfo();
       	var steps = info.steps;
       	var bY = app.getProperty("baseY");
		var kX = app.getProperty("baseX") + app.getProperty("keyX");
		var lb = app.getProperty("lineBreak");

        sValue.setText("'" + steps + "'");
        sValue.setLocation(kX + sKey.width, bY + (5*lb));
        
        comma.setLocation(kX + sKey.width + sValue.width + 2.5, bY + (5*lb) -4);
        
        cValue.setText("'" + info.calories + "'");
        cValue.setLocation(kX + cKey.width, bY + (6*lb));
      
    }
    
    function getDateTime(type) {
    	if(type.equals("date")) {
    		var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        	var shortYear = Lang.format("$1$", [now.year]);
        	return Lang.format("$1$/$2$/$3$", [now.day, now.month, shortYear.substring(2, 4)]);
        	
    	} else if(type.equals("time")) {
        	var clockTime = System.getClockTime();
        	return Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
    	}
    }

}
