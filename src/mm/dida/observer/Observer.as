package mm.dida.observer
{
	/**
	 * Observer object
	 *  
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Observer
	{
		private var notify:Function;
		private var context:Object;
		
		public function Observer(notifyMethod:Function, notifyContext:Object)
		{
			setNotifyMethod(notifyMethod);
			setNotifyContext(notifyContext);
		}
		
		/**
		 * a good news for you
		 * @param notification notification object
		 * 
		 */
		public function nofityObserver(notification:Notification):void
		{
			this.getNotifyMethod().apply(this.getNotifyContext(), [notification]);
		}
		
		
		///////////////////////////////////
		// setter/getters
		///////////////////////////////////
		
		/**
		 * Sets/gets nofity method
		 */
		public function setNotifyMethod(notifyMethod:Function):void
		{
			this.notify = notifyMethod;
		}
		public function getNotifyMethod():Function
		{
			return this.notify;
		}
		
		/**
		 * Sets/gets notify context
		 */
		public function setNotifyContext(notifyContext:Object):void
		{
			this.context = notifyContext;
		}
		public function getNotifyContext():Object
		{
			return this.context;
		}
		
		/**
		 * compare whether the same context
		 * 
		 * @param object context object
		 * @return bool
		 * 
		 */
		public function compareNotifyContext(object:Object):Boolean
		{
			return object === this.context;
		}
	}
}