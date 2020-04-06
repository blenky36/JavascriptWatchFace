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
    					 ["ObjectName", "watch", baseX, baseY, "key"], 
    					 ["Equals", "=", baseX, baseY + 2, "comma"],
    					 ["TopBracket", "{", baseX, baseY, "bracket"],
    					 ["BottomBracket", "}", baseX, (baseY - 2) + (7*lineBreak), "bracket"],
    					 ["TimeKey", "time: ", keyX, baseY + lineBreak, "key"],
    					 ["BatteryKey", "batt: ", keyX, baseY + (2*lineBreak), "key"],
    					 ["DateKey", "date: ", keyX, baseY + (3*lineBreak), "key"],
    					 ["HRKey", "hr: ", keyX, baseY + (4*lineBreak), "key"],
    					 ["StepsKey", "steps: ", keyX, baseY + (5*lineBreak), "key"],
    					 ["CaloriesKey", "kcal: ", keyX, baseY + (6*lineBreak), "key"],
    					 ["TimeComma", ",", baseX, baseY + (2*lineBreak), "comma"],
    					 ["DateComma", ",", baseX, baseY + (2*lineBreak), "comma"],
    					 ["BatteryComma", ",", baseX, baseY + (2*lineBreak), "comma"],
    					 ["HRComma", ",", baseX, baseY + (4*lineBreak), "comma"],
    					 ["StepsComma", ",", baseX, baseY + (5*lineBreak), "comma"]
    					];

}