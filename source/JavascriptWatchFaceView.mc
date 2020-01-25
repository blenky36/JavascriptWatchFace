using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Application.Properties as props;
using Toybox.Graphics as Gfx;

class JavascriptWatchFaceView extends WatchUi.WatchFace {

	var keyColor = Gfx.COLOR_BLACK;
	var valuesColor = Gfx.COLOR_WHITE;
	var commaColor = Gfx.COLOR_BLACK;
	
	var baseX = 45;
	var baseY = 20;
	var keyX = baseX + 20;
	var lineBreak = 22;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.WatchFace(dc));
    	
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	var drawables = [["Let", "var ", baseX - 2, baseY, "none"], 
    					 ["ObjectName", "watch", baseX + 42.5, baseY, "key"], 
    					 ["Equals", "=", baseX + 115, baseY + 2, "comma"],
    					 ["TopBracket", "{", baseX + 135, baseY, "comma"],
    					 ["BottomBracket", "}", baseX, baseY + (7*lineBreak), "comma"],
    					 ["TimeKey", "time: ", keyX, baseY + lineBreak, "key"],
    					 ["BatteryKey", "batt: ", keyX, baseY + (2*lineBreak), "key"],
    					 ["DateKey", "date: ", keyX, baseY + (3*lineBreak), "key"],
    					 ["HRKey", "hr: ", keyX, baseY + (4*lineBreak), "key"],
    					 ["StepsKey", "steps: ", keyX, baseY + (5*lineBreak), "key"],
    					 ["CaloriesKey", "kcal: ", keyX, baseY + (6*lineBreak), "key"],
    					 ["TimeComma", ",", baseX + 165, baseY + (2*lineBreak), "comma"],
    					 ["DateComma", ",", baseX + 170, baseY + (2*lineBreak), "comma"],
    					 ["BatteryComma", ",", baseX + 130, baseY + (2*lineBreak), "comma"],
    					 ["HRComma", ",", baseX + 120, baseY + (4*lineBreak), "comma"],
    					 ["StepsComma", ",", baseX + 125, baseY + (5*lineBreak), "comma"],
    					];

		for(var i = 0; i < drawables.size(); i++) {
			var view = View.findDrawableById(drawables[i][0]);
			view.setText(drawables[i][1]);
			view.setLocation(drawables[i][2], drawables[i][3]);		
			if(drawables[i][4].equals("key")) {
				view.setColor(keyColor);
			} else if(drawables[i][4].equals("comma")) {
				view.setColor(commaColor);
			}
		}
		
    }

    // Update the view
    function onUpdate(dc) {
    	var timeValue = View.findDrawableById("TimeValue");
        var dateValue = View.findDrawableById("DateValue");
        var batteryValue = View.findDrawableById("BatteryValue");
        var stepsValue = View.findDrawableById("StepsValue");
        var caloriesValue = View.findDrawableById("CaloriesValue");
        var hrValue = View.findDrawableById("HRValue");
        
        var timeComma = View.findDrawableById("TimeComma");
        var batteryComma = View.findDrawableById("BatteryComma");
        var dateComma = View.findDrawableById("DateComma");
        var hrComma = View.findDrawableById("HRComma");
        var stepsComma = View.findDrawableById("StepsComma");
        
        showAndPositionTime(timeValue, timeComma);
        showAndPositionBattery(batteryValue, batteryComma);
        showAndPositionDate(dateValue, dateComma);
        showAndPositionHR(hrValue, hrComma);
        showAndPositionStepsAndCalories(stepsValue, stepsComma, caloriesValue);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
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
    
    
     

}
