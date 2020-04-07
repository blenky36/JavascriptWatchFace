using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Application;
using Toybox.WatchUi;


class JavascriptWatchFaceView extends WatchUi.WatchFace {
	
	var watchService = new JavascriptWatchFaceService();
	var constants = new JavascriptWatchFaceConstants();
	
	var baseX = constants.baseX;
	var baseY = constants.baseY;
	var keyX = constants.keyX;
	var lineBreak = constants.lineBreak;
	
	
	var colors = constants.colors;
	
	var objColor = colors[1];
	var valueColor = colors[1];
	var commaColor = colors[1];
	var bracketColor = colors[1];

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.WatchFace(dc));
    	self.setKeyValues();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	var drawables = self.constants.drawableSetup;
    	self.setupDrawables(drawables);
    }

    // Update the view
    function onUpdate(dc) {
 		self.positionAndColorResources();
	
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
    
    function positionAndColorResources() {
    	self.watchService.setScreenSize();

        var keys = [View.findDrawableById("TimeKey"), View.findDrawableById("DateKey"),
        	View.findDrawableById("BatteryKey"), View.findDrawableById("StepsKey"),
        	View.findDrawableById("CaloriesKey"), View.findDrawableById("HRKey")];
        
        var values = [View.findDrawableById("TimeValue"), View.findDrawableById("DateValue"),
         	View.findDrawableById("BatteryValue"), View.findDrawableById("StepsValue"),
         	View.findDrawableById("CaloriesValue"), View.findDrawableById("HRValue")];
         	
        var commas = [View.findDrawableById("TimeComma"), View.findDrawableById("DateComma"),
        	View.findDrawableById("BatteryComma"), View.findDrawableById("StepsComma"), 
        	View.findDrawableById("HRComma"), View.findDrawableById("Equals")];
        	
  		var topBracket = View.findDrawableById("TopBracket");
        	
       	var brackets = [topBracket, View.findDrawableById("BottomBracket")];
       	
       	var topText = [View.findDrawableById("Var"), View.findDrawableById("ObjectName"),
       	View.findDrawableById("Equals"), topBracket];
     
        self.watchService.positionTopText(topText);
        self.watchService.showAndPositionTime(keys[0], values[0], commas[0]);
        self.watchService.showAndPositionDate(keys[1], values[1], commas[1]);
        self.watchService.showAndPositionBattery(keys[2], values[2], commas[2]);
        self.watchService.showAndPositionStepsAndCalories(keys[3], values[3], commas[3], keys[4], values[4]);
        self.watchService.showAndPositionHR(keys[5], values[5], commas[4]);
        
        
        for(var i = 0; i < 6; i++) {
        	self.watchService.colorDrawable(commas[i], "comma");
        	self.watchService.colorDrawable(values[i], "value");
        	self.watchService.colorDrawable(keys[i], "obj");
        }
        
        for(var i = 0; i < brackets.size(); i++) {
        	self.watchService.colorDrawable(brackets[i], "bracket");
        }
        
        self.watchService.colorDrawable(View.findDrawableById("ObjectName"), "obj");
        self.watchService.colorDrawable(View.findDrawableById("Var"), "var");
    
    }
    
    
    function setupDrawables(drawables) {
 
    	for(var i = 0; i < drawables.size(); i++) {
			var drawable = View.findDrawableById(drawables[i][0]);
			drawable.setText(drawables[i][1]);
			drawable.setLocation(drawables[i][2], drawables[i][3]);
										
			if(drawables[i][4].equals("obj")) {
				drawable.setColor(objColor);
			} else if(drawables[i][4].equals("comma")) {
				drawable.setColor(commaColor);
			} else if(drawables[i][4].equals("bracket")) {
				drawable.setColor(bracketColor);
			}
			
		}
    }
    
    function setKeyValues() {
    	var app = Application.getApp();
    	objColor = colors[app.getProperty("objColor")];
    	valueColor = colors[app.getProperty("valueColor")];
    	bracketColor = colors[app.getProperty("bracketColor")];
        commaColor = colors[app.getProperty("commaColor")];
              
    }
     

}
