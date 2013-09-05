package date;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

/**
 * port from project-nya(http://www.project-nya.jp/modules/weblog/details.php?blog_id=1043)
 * @author flashisobar
 */
class CalendarWidget extends Sprite
{

	static private var calendar:Array<CalendarDate>;
	
	private static var max:UInt = 37;
	private static var hHeight:UInt = 20;
	private static var wHeight:UInt = 12;
	private static var bWidth:UInt = 60;
	private static var bHeight:UInt = 44;

	private var year:UInt;
	private var month:UInt;
	private var todayDate:String;
	
	private var dayList:Array<Day>;
	

	public function new() 
	{
		super();
		
		this.addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		todayDate = DateTools.format(Date.now(), "%Y%m%d");
		year = Date.now().getFullYear();
		month = Date.now().getMonth() + 1;
		
		trace("init");
		initDays();
		createWeekTitle();
	}
	
	/**
	 * 先建立所有日期
	 */
	private function initDays():Void {
		dayList = new Array();
		var day:Day;
		for (n in 0...max) {
			day = new Day();
			addChild(day);
			dayList.push(day);
			day.x = (bWidth + 1)*(n%7) + 1;
			day.y = (bHeight + 1) * Math.floor(n / 7) + hHeight + wHeight + 2;
		}
	}
	
	/**
	 * create title: Sun--Mon--Tue--Wed--Thu--Fri--Sat
	 */
	private function createWeekTitle():Void {
		var weekdays = Calendar.weekdays;

		for (n in 0...weekdays.length) {
			var base:Shape = new Shape();
			addChild(base);
			base.graphics.beginFill(0xCCCCCC);
			base.graphics.drawRect(0, 0, bWidth, wHeight);
			base.graphics.endFill();
			base.x = (bWidth + 1)*n + 1;
			base.y = hHeight + 1;
			var txt:TextField = new TextField();
			addChild(txt);
			txt.x = (bWidth + 1)*n + 11;
			txt.y = hHeight - 1;
			txt.width = 40;
			txt.height = 17;
			txt.selectable = false;
			txt.textColor = 0x888888;
			txt.text = Std.string(weekdays[n]);
		}
	}
	
	private function manage(y:UInt, m:UInt):Void {
		year += y;
		month += m;
		if (month > 12) {
			year += 1;
			month = 1;
		}
		if (month < 1) {
			year -= 1;
			month = 12;
		}
		create(year, month);
	}
	
	public function prevYear():Void {
		manage(-1, 0);
	}

	public function prevMonth():Void {
		manage(0, -1);
	}

	public function setToday():Void {
		year = Date.now().getFullYear();
		month = Date.now().getMonth() + 1;

		create(year, month);
	}
	
	public function nextMonth():Void {
		manage(0, 1);
	}
	
	public function nextYear():Void {
		manage(1, 0);
	}
	
	/**
	 * 
	 * @param	year
	 * @param	month
	 */
	public function create(year:UInt, month:UInt) 
	{
		trace("now:"+year+"/"+month);
		calendar = Calendar.create(year, month);
		
		// 2013年9月3日: CalendarDate = calendar[3];
		var first:UInt = calendar[1].weekday; // 2013年9月1日
		trace("星期" + first);
		
		var d:Int;
		var day:Day;
		var date:CalendarDate;
		for (n in 0...max) 
		{
			d = n - first + 1;
			day = dayList[n];
			day.visible = false;
			if (d > 0) {
				date = calendar[d];
				if (date != null)
				{
					if (date.toString() == todayDate) {
						day.init(date, true);
					}
					else {
						day.init(date);
					}
				}
			}
		}
	}
	
	override public function toString():String {
		return year+"年"+month+"月";
	}	
	
}