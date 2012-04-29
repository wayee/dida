package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import helloflash.ApplicationFacade;
	
	[SWF(backgroundColor="0xCCCCCC", width="400", height="400", frameRate="30")]
	public class HelloFlash extends MovieClip
	{
		public function HelloFlash()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(event:Event=null):void
		{
			ApplicationFacade.getInstance().startup( this.stage );
		}
	}
}
