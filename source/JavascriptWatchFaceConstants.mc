using Toybox.Graphics as Gfx;

class JavascriptWatchFaceConstants {

	public var baseX = 45;
	public var baseY = 20;
	public var keyX = baseX + 20;
	public var lineBreak = 22;
	
	public var colors = [
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
	
	public var drawableSetup = [["Var", "var ", baseX - 2, baseY, "none"], 
    					 ["ObjectName", "watch", baseX + 42.5, baseY, "key"], 
    					 ["Equals", "=", baseX + 115, baseY + 2, "comma"],
    					 ["TopBracket", "{", baseX + 135, baseY, "bracket"],
    					 ["BottomBracket", "}", baseX, baseY + (7*lineBreak), "bracket"],
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

}