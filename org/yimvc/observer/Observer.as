package org.yimvc.observer
{
	/**
	 * 观察者对象
	 * <br>观察者模式中的观察者，当你注册成为观察者并关注某个微博(微博控？)后
	 * <br>人家已有新的微博就通知你，简单吧，还不懂就去注册个微博吧
	 * <br>关注我试试：http://www.weibo.com/huayicai/
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
		 * 有好消息通知你
		 * @param notification 消息体
		 * 
		 */
		public function nofityObserver(notification:Notification):void
		{
			this.getNotifyMethod().apply(this.getNotifyContext(), [notification]);
		}
		
		/**
		 * get/set 观察者的通知方法 
		 */
		public function getNotifyMethod():Function
		{
			return this.notify;
		}
		public function setNotifyMethod(notifyMethod:Function):void
		{
			this.notify = notifyMethod;
		}
		
		/**
		 * get/set 观察者通知方法的上下文 
		 */
		public function getNotifyContext():Object
		{
			return this.context;
		}
		public function setNotifyContext(notifyContext:Object):void
		{
			this.context = notifyContext;
		}
		
		/**
		 * 与当前观察者通知方法对比，是不是同一个观察者 
		 * @param object 上下文对象
		 * @return bool
		 * 
		 */
		public function compareNotifyContext(object:Object):Boolean
		{
			return object === this.context;
		}
	}
}