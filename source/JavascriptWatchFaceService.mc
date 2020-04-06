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
	var charLength = constants.charLength.toNumber();
	
	var colors = constants.colors;
	
	function setScreenSize() {
		System.println("Setting Screen Size...");
		var settings = System.getDeviceSettings();
		var size = "large";
		System.println("Height: " + settings.screenHeight);
		System.println("Width: " + settings.screenWidth);
		
		if(settings.screenWidth == 250 && settings.screenHeight == 250) {
			Application.getApp().setProperty("baseX", 50);
			Application.getApp().setProperty("baseY", 25);
			Application.getApp().setProperty("lineBreak", 24);
		} else if(settings.screenWidth == 260 && settings.screenHeight == 260) {
			Application.getApp().setProperty("baseX", 55);
			Application.getApp().setProperty("baseY", 30);
			Application.getApp().setProperty("lineBreak", 26);
		} else if(settings.screenHeight < 220 && settings.screenWidth < 220) {
			Application.getApp().setProperty("charLength", "8");
			size = "small";	
		}
		Application.getApp().setProperty("screenSize", size);	
		System.println("Screen Size set to: " + size);
		System.println("Screen size setting is: " + Application.getApp().getProperty("screenSize"));
		return size;
	}

	
	function colorDrawable(drawable, type) {
    	drawable.setColor(colors[Application.getApp().getProperty(type + "Color")]);
    }


	function showAndPositionTime(value, comma, size) {
		var timeString = getDateTime("time");
		
		var xValues = [60, 120];
		handleScreenSize(xValues, size);
        value.setText("'" + timeString + "'");
        value.setLocation(keyX + xValues[0], baseY + lineBreak);
        
        if(timeString.length() == 4) {
        	comma.setLocation(keyX + xValues[1], baseY + lineBreak);
        } else {
        	comma.setLocation(keyX + xValues[1] + (1*charLength), baseY + lineBreak);        
        }
        
        
    }

	function showAndPositionBattery(value, comma, size) {
        var battery = System.getSystemStats().battery.toNumber();
        
		var xValues = [55, 100];
		handleScreenSize(xValues, size); 
        value.setText("'" + battery + "%'");
        value.setLocation(keyX + xValues[0], baseY + (2*lineBreak));
        
        if(battery < 10) {
        	comma.setLocation(keyX + xValues[1], baseY + (2*lineBreak));        	
        } else if (battery >= 10 && battery != 100) {
        	comma.setLocation(keyX + xValues[1] + (1*charLength), baseY + (2*lineBreak));
        } else if (battery == 100) {
        	comma.setLocation(keyX + xValues[1] + (2.5*charLength), baseY + (2*lineBreak));
        }
       
    }
    
    function showAndPositionDate(value, comma, size) {
        var dateString = getDateTime("date");
       
		var xValues = [60, 145];  
		handleScreenSize(xValues, size);   
        value.setText("'" + dateString + "'");
        value.setLocation(keyX + xValues[0], baseY + (3*lineBreak));
        
        if(dateString.length() == 7) {
        	comma.setLocation(keyX + xValues[1] + (0.9*charLength), baseY + (3*lineBreak));
        } else if(dateString.length() == 8) {
        	comma.setLocation(keyX + xValues[1] + (2*charLength), baseY + (3*lineBreak));        
        } else {
        	comma.setLocation(keyX + xValues[1], baseY + (3*lineBreak));
        }
        
    }
    
    function showAndPositionHR(value, comma, size) {
        var hr = Activity.getActivityInfo().currentHeartRate;
        
        var xValues = [35, 65];
     	handleScreenSize(xValues, size); 
    
        if(hr == null) {
        	hr = " - ";
        	comma.setLocation(keyX + xValues[1] + (0.5*charLength), baseY + (4*lineBreak));
        } else if(hr.toString().length() == 1) {
        	comma.setLocation(keyX + xValues[1] - (0.5*charLength), baseY + (4*lineBreak));
        } else if(hr.toString().length() == 2) {
        	comma.setLocation(keyX + xValues[1] + (1*charLength), baseY + (4*lineBreak));
        } else {
        	comma.setLocation(keyX + xValues[1] + (2.5*charLength), baseY + (4*lineBreak));
        }
        value.setText("'" + hr + "'");
        value.setLocation(keyX + xValues[0], baseY + (4*lineBreak));
    }
		
	function showAndPositionStepsAndCalories(sValue, comma, cValue, size) {
    	// Get and show the current steps and calories
       	var info = ActivityMonitor.getInfo();
       	var steps = info.steps;
       	var sxValues = [70];
       	var cxValues = [55];
       	handleScreenSize(sxValues, size);
       	handleScreenSize(cxValues, size);

        sValue.setText("'" + steps + "'");
        sValue.setLocation(keyX + sxValues[0], baseY + (5*lineBreak));
        
        cValue.setText("'" + info.calories + "'");
        cValue.setLocation(keyX + cxValues[0], baseY + (6*lineBreak));
        if(steps.toString().length() == 1) {
        	comma.setLocation(keyX + sxValues[0] + (2.5*charLength), baseY + (5*lineBreak));
        } else if(steps.toString().length() == 2) {
        	comma.setLocation(keyX + sxValues[0] + (4*charLength), baseY + (5*lineBreak));
        } else if(steps.toString().length() == 3) {
        	comma.setLocation(keyX + sxValues[0] + (5*charLength), baseY + (5*lineBreak));
        } else if(steps.toString().length() == 4) {
        	comma.setLocation(keyX + sxValues[0] + (6.5*charLength), baseY + (5*lineBreak));
        } else if(steps.toString().length() == 5) {
        	comma.setLocation(keyX + sxValues[0] + (8*charLength), baseY + (5*lineBreak));        
        }
      
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
    
    function handleScreenSize(array, size) {
 		System.println("Screen Size: " + size);
    	if(size.equals("small")) {
	    	array[0] = array[0] - 10;
	    	if(array.size() > 1) {
	    		array[1] = array[1] - 20;	    	
	    	}
	    }
    }

}
