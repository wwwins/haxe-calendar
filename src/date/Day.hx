package date;

import flash.display.Sprite;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.AntiAliasType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class Day extends Sprite {
	
	public var date:CalendarDate;
	private var txt:TextField;
	private var base:Sprite;
	private static var bWidth:UInt = 60;
	private static var bHeight:UInt = 44;
	private static var textColor:UInt = 0x767676;
	private static var bColor:UInt = 0xFFFFFF;
	private static var sColor:UInt = 0x000000;
	private static var sunColor:UInt = 0xFF6699;
	private static var sunLight:UInt = 0xFF3366;
	private static var weekColor:UInt = 0x66CC00;
	private static var satColor:UInt = 0x6699CC;
	private static var satLight:UInt = 0x3399CC;
	private static var todayColor:UInt = 0x66CC00;
	private var today:Shape;

	public function new() {
		super();
		
		draw();
	}
	
	public function init(d:CalendarDate = null, now:Bool = false):Void {
		visible = true;
		date = d;
		var type:Dynamic = Calendar.NONE;
		var holiday = null;
		if (date != null) {
			type = date.weekday;
			holiday = date.holiday;
		}
		if (holiday!=null) type = Calendar.HOLI;
		var bgColor:UInt;
		var bgAlpha:Float;
		switch (type) {
			case 0 :
				bgColor = sunColor;
				bgAlpha = 0.16;
			case 6 :
				bgColor = satColor;
				bgAlpha = 0.16;
			case Calendar.HOLI :
				bgColor = sunColor;
				bgAlpha = 0.16;
			case Calendar.NONE :
				bgColor = bColor;
				bgAlpha = 1;
			default :
				bgColor = bColor;
				bgAlpha = 1;
		}
		base.graphics.clear();
		base.graphics.beginFill(bgColor, bgAlpha);
		base.graphics.drawRect(0, 0, bWidth, bHeight);
		base.graphics.endFill();
		if (date != null && date.day > 0) txt.text = Std.string(date.day);
		today.visible = now;
	}

	private function draw():Void
	{
		base = new Sprite();
		addChild(base);
		mouseChildren = false;
		hitArea = base;
		today = new Shape();
		addChild(today);
		today.graphics.beginFill(todayColor);
		today.graphics.drawRect(0, 0, bWidth, bHeight);
		today.graphics.drawRect(1, 1, bWidth-2, bHeight-2);
		today.graphics.endFill();
		today.visible = false;
		var tf:TextFormat = new TextFormat();
		tf.size = 14;
		tf.align = TextFormatAlign.CENTER;
		txt = new TextField();
		addChild(txt);
		txt.x = -3;
		txt.y = 1;
		txt.width = 28;
		txt.height = 21;
		txt.type = TextFieldType.DYNAMIC;
		txt.selectable = false;
		txt.defaultTextFormat = tf;
		txt.textColor = textColor;
	}

}
