package org.yimvc.observer
{
	/**
	 * 消息体
	 * 
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Notification
	{
		private var name:String;
		private var body:Object;
		private var type:String;
		
		/**
		 * 消息体 
		 * @param name string 消息名称
		 * @param body object 消息参数体
		 * @param type string 消息类型
		 * 
		 */
		public function Notification(name:String, body:Object=null, type:String='')
		{
			this.name = name;
			this.body = body;
			this.type = type;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function setBody(body:Object):void
		{
			this.body = body;
		}
		public function getBody():Object
		{
			return this.body;
		}
		
		public function setType(type:String):void
		{
			this.type = type;
		}
		public function getType():String
		{
			return this.type;
		}
		
		public function toString():String
		{
			var msg:String = '';
			msg += 'Notification Name: ' + this.name;
			msg += ', Notification Body: ' + this.body;
			msg += ', Notification Type: ' + this.type;
			return msg;
		}
	}
}