package ;

import date.CalendarWidget;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;


/**
 * port from project-nya(http://www.project-nya.jp/modules/weblog/details.php?blog_id=1043)
 * @author flashisobar
 */
class Main extends Sprite
{
	var widget:CalendarWidget;
	var titleText:TextField;
	
	public function new() {
		super();
		
		this.addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		// prev month
		var btnPrev:Sprite = new Sprite();
		btnPrev.graphics.clear();
		btnPrev.graphics.beginFill(0xABCDEF);
		btnPrev.graphics.drawRoundRect(0, 0, 30, 20, 10);
		btnPrev.graphics.endFill();
		btnPrev.x = 110;
		var tf1:TextField = createTextField("<<<", 12, 0x888888);
		btnPrev.addChild(tf1);
		addChild(btnPrev);
		
		// title
		var title:Sprite = new Sprite();
		title.graphics.clear();
		title.graphics.beginFill(0xABCDEF);
		title.graphics.drawRoundRect(0, 0, 80, 20, 10);
		title.graphics.endFill();
		title.x = 110 + 60;
		titleText = createTextField("2013年12月", 12, 0x888888);
		title.addChild(titleText);
		addChild(title);
		
		// next month
		var btnNext:Sprite = new Sprite();
		btnNext.graphics.clear();
		btnNext.graphics.beginFill(0xABCDEF);
		btnNext.graphics.drawRoundRect(0, 0, 30, 20, 10);
		btnNext.graphics.endFill();
		btnNext.x = 110 + 160;
		var tf:TextField = createTextField(">>>", 12, 0x888888);
		btnNext.addChild(tf);
		addChild(btnNext);
		
		btnNext.addEventListener(MouseEvent.CLICK, handleNext);
		btnPrev.addEventListener(MouseEvent.CLICK, handlePrev);

		// start create calendar
		widget = new CalendarWidget();

		widget.x = 0;
		widget.y = 10;
		addChild(widget);

		widget.setToday();
		titleText.text = widget.toString();

	}
	
	private function handlePrev(e:MouseEvent):Void 
	{
		widget.prevMonth();
		titleText.text = widget.toString();
	}
	
	private function handleNext(e:MouseEvent):Void 
	{
		widget.nextMonth();
		titleText.text = widget.toString();
	}
	
	private function createTextField(__text:String, __textSize:Int, __color:Int):TextField 
	{
			var format:TextFormat = new TextFormat("Arial", __textSize, __color, true);
			var tf:TextField = new TextField();
			tf.autoSize = flash.text.TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = format;
			tf.wordWrap = true;
			tf.multiline = true;
			tf.width = 900;
			tf.text = __text;
			tf.selectable = false;
			
			return tf;
	}
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point

		Lib.current.addChild(new Main());

	}

	
}

