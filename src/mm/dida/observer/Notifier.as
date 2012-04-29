package mm.dida.observer
{
	import mm.dida.Facade;

	/**
	 * Notification notifier for sending notification
	 * 
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Notifier
	{
		protected var facade:Facade = Facade.getInstance();
		
		public function Notifier()
		{
		}
		
		/**
		 * send notification, recommend using shorter method notify
		 * 
		 * @param name string notification name
		 * @param body object notification body
		 * @param type string notification type
		 * 
		 */
		public function sendNotification(name:String, body:Object=null, type:String=''):void
		{
			facade.sendNotification(name, body, type);
		}
		
		/**
		 * sendNotification method alias
		 * 
		 * @param name string notification name
		 * @param body object notification body
		 * @param type string notification type
		 * 
		 */
		public function notify(name:String, body:Object=null, type:String=''):void
		{
			sendNotification(name, body, type);
		}
	}
}