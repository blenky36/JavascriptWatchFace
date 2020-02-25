using Toybox.System;
using Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application;

class JavascriptWatchFaceService {

	var constants = new JavascriptWatchFaceConstants();
	
	var baseX = constants.baseX;
	var baseY = constants.baseY;
	var keyX = constants.keyX;
	var lineBreak = constants.lineBreak;
	
	var colors = constants.colors;
	
	function colorDrawable(drawable, type) {
    	drawable.setColor(colors[Application.getApp().getProperty(type + "Color")]);
    }


	function showAndPositionTime(value, comma) {
    	// Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        value.setText("'" + timeString + "'");
        value.setLocation(baseX + 80, baseY + lineBreak);
        if(timeString.length() == 4) {
        	comma.setLocation(baseX + 140, baseY + lineBreak);
        } else {
        	comma.setLocation(baseX + 150, baseY + lineBreak);        
        }
        
        
    }

	function showAndPositionBattery(value, comma) {
    	// Get and show the current battery
        var battery = System.getSystemStats().battery.toNumber();
        value.setText("'" + battery + "%'");
        value.setLocation(baseX + 75, baseY + (2*lineBreak));
        if (battery < 10) {
        	comma.setLocation(baseX + 120, baseY + (2*lineBreak));
        } else if (battery == 100) {
        	comma.setLocation(baseX + 145, baseY + (2*lineBreak));
        }
       
    }
    
    function showAndPositionDate(value, comma) {
    	// Get and show the current date
        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var shortYear = Lang.format("$1$", [now.year]);
        var dateString = Lang.format("$1$/$2$/$3$", [now.day, now.month, shortYear.substring(2, 4)]);
       
        value.setText("'" + dateString + "'");
        value.setLocation(baseX + 80, baseY + (3*lineBreak));
        if(dateString.length() == 7) {
        	comma.setLocation(baseX + 175, baseY + (3*lineBreak));
        } else if(dateString.length() == 8) {
        	comma.setLocation(baseX + 185, baseY + (3*lineBreak));        
        } else {
        	comma.setLocation(baseX + 165, baseY + (3*lineBreak));
        }
        
    }
		
	function showAndPositionStepsAndCalories(sValue, comma, cValue) {
    	// Get and show the current steps and calories
       	var info = ActivityMonitor.getInfo();
       	
   
        sValue.setText("'" + info.steps + "'");
        sValue.setLocation(baseX + 90, baseY + (5*lineBreak));
       
        if(info.steps.toString().length() == 1) {
        	comma.setLocation(baseX + 115, baseY + (5*lineBreak));
        } else if(info.steps.toString().length() == 2) {
        	comma.setLocation(baseX + 130, baseY + (5*lineBreak));
        } else if(info.steps.toString().length() == 3) {
        	comma.setLocation(baseX + 140, baseY + (5*lineBreak));
        } else if(info.steps.toString().length() == 4) {
        	comma.setLocation(baseX + 155, baseY + (5*lineBreak));
        } else if(info.steps.toString().length() == 5) {
        	comma.setLocation(baseX + 165, baseY + (5*lineBreak));        
        }
        
        cValue.setText("'" + info.calories + "'");
        cValue.setLocation(baseX + 75, baseY + (6*lineBreak));
      
    }
    
     function showAndPositionHR(value, comma) {
    	// Get and show the current heart rate
        var hr = Activity.getActivityInfo().currentHeartRate;

        if(hr == null) {
        	hr = " - ";
        	comma.setLocation(baseX + 85, baseY + (4*lineBreak));
        } else if(hr.toString().length() == 1) {
        	comma.setLocation(baseX + 85, baseY + (4*lineBreak));
        } else if(hr.toString().length() == 2) {
        	comma.setLocation(baseX + 95, baseY + (4*lineBreak));
        } else {
        	comma.setLocation(baseX + 105, baseY + (4*lineBreak));
        }
        value.setText("'" + hr + "'");
        value.setLocation(baseX + 55, baseY + (4*lineBreak));
        
    }

}
