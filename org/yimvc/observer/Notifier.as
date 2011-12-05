package org.yimvc.observer
{
	import org.yimvc.Facade;

	/**
	 * 消息发送器 ，继承此类后都具有发送消息的能力
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
		 * 发送消息，兼容PureMVC的接口 ，建议使用更短的notity
		 * @param name string 消息名称
		 * @param body object 消息参数体
		 * @param type string 消息类型
		 * 
		 */
		public function sendNotification(name:String, body:Object=null, type:String=''):void
		{
			facade.sendNotification(name, body, type);
		}
		
		/**
		 * sendNotification方法的别名 ，建议使用
		 * @param name string 消息名称
		 * @param body object 消息参数体
		 * @param type string 消息类型
		 * 
		 */
		public function notify(name:String, body:Object=null, type:String=''):void
		{
			sendNotification(name, body, type);
		}
	}
}