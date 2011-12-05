package 
{
	import flash.display.MovieClip;
	import org.yimvc.helloflash.ApplicationFacade;
	
	[SWF(backgroundColor="0xCCCCCC", width="400", height="400", frameRate="30")]
	public class HelloFlash extends MovieClip
	{
		public function HelloFlash()
		{
			ApplicationFacade.getInstance().startup( this.stage );
		}
	}
}
