package org.yimvc
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import org.yimvc.observer.Notifier;

	/**
	 * 继承此类的Model层只负责客户端的数据维护
	 * <br>　service层请求后的数据，直接调用model层来存储数据
	 * <br>  Model层提供获取和修改数据的接口
	 * <br>  Model send notice to controller
	 * 
	 * <p>继承此类的Service层负责与服务器端的数据交互 
	 * <br> http
	 * <br> socket
	 * <br> Service send notice to controller
	 * 
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Actor extends Notifier
	{
		private static var dict:Dictionary = new Dictionary;
		
		private var _data:Object;
		
		public function Actor()
		{
			var ref:Class = this["constructor"] as Class;
			if (dict[ref])
				throw new Error(getQualifiedClassName(this)+" is a singleton.");
			else
				dict[ref] = this;
		}
		
		/**
		 * 获取单例实例对象 
		 * @param ref 类对象
		 * @return 实例对象
		 * 
		 */
		public static function getInstance(ref:Class):*
		{
			if (dict[ref] == null)
				dict[ref] = new ref();
			
			return dict[ref];
		}
		
		/**
		 * 销毁单例对象 
		 */
		public function destory():void
		{
			var ref:Class = this["constructor"] as Class;
			delete dict[ref];
		}
		
		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			_data = value;
		}
	}
}