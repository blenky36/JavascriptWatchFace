using Toybox.Graphics as Gfx;
using Toybox.Application;

class JavascriptWatchFaceConstants {

	public var baseX = Application.getApp().getProperty("baseX");
	public var baseY = Application.getApp().getProperty("baseY");	
	public var keyX = baseX + Application.getApp().getProperty("keyX");
	public var lineBreak = Application.getApp().getProperty("lineBreak");
	
	public const colors = [
		Gfx.COLOR_BLACK, //0
		Gfx.COLOR_WHITE, //1
		Gfx.COLOR_LT_GRAY, //2
		Gfx.COLOR_DK_BLUE, //3
		Gfx.COLOR_BLUE, //4
		Gfx.COLOR_ORANGE, //5
		Gfx.COLOR_YELLOW, //6
		Gfx.COLOR_RED, //7
		Gfx.COLOR_GREEN, //8
		Gfx.COLOR_PURPLE, //9
		Gfx.COLOR_PINK, //10
	];
	
	//   [ ID, text, x, y, type, relative_position ]
	public var drawableSetup = [["Var", "var ", baseX, baseY, "none"], 
    					 ["ObjectName", "watch", baseX + 40, baseY, "obj"], 
    					 ["Equals", "=", baseX + 110, baseY + 2, "comma"],
    					 ["TopBracket", "{", baseX + 125, baseY, "bracket"],
    					 ["BottomBracket", "}", baseX + 2, (baseY - 4) + (7*lineBreak), "bracket"],
    					 ["TimeKey", "time: ", keyX, baseY + lineBreak, "obj"],
    					 ["BatteryKey", "batt: ", keyX, baseY + (2*lineBreak), "obj"],
    					 ["DateKey", "date: ", keyX, baseY + (3*lineBreak), "obj"],
    					 ["HRKey", "hr: ", keyX, baseY + (4*lineBreak), "obj"],
    					 ["StepsKey", "steps: ", keyX, baseY + (5*lineBreak), "obj"],
    					 ["CaloriesKey", "kcal: ", keyX, baseY + (6*lineBreak), "obj"],
    					 ["TimeComma", ",", -100, baseY + (2*lineBreak), "comma"],
    					 ["DateComma", ",", -100, baseY + (2*lineBreak), "comma"],
    					 ["BatteryComma", ",", -100, baseY + (2*lineBreak), "comma"],
    					 ["HRComma", ",", -100, baseY + (4*lineBreak), "comma"],
    					 ["StepsComma", ",", -100, baseY + (5*lineBreak), "comma"]
    					];

}