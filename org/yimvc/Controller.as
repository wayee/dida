package org.yimvc
{
	import org.yimvc.observer.Notification;
	import org.yimvc.observer.Notifier;

	/**
	 * 控制器
	 * <br>执行程序的逻辑
	 * <br>连接视图，视图的代理
	 * <br>监听视图发出的事件，更新Model数据或者通过Service发送请求
	 * 
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Controller extends Notifier
	{
		public static const NAME:String = 'Controller';
		
		protected var controllerName:String;
		protected var viewComponent:Object;
		
		public function Controller(viewComponent:Object=null)
		{
			this.controllerName = NAME;
			this.viewComponent = viewComponent;
		}
		
		public function onRegister():void {}
		public function onRemove():void {}
		
		/**
		 * 监听关注的消息 
		 * @return array 消息名称列表
		 * 
		 */		
		public function listNotificationInterests():Array { return []; }
		
		/**
		 * 消息处理方法
		 * <br>反射消息到具体Controller的方法
		 * @param notification 消息体
		 * 
		 */
		public function handleNotification(notification:Notification):void 
		{
			// reflection to method
			if (notification.getName()) {
				var action:String = 'action'+notification.getName();
				if (this.hasOwnProperty(action)) {
					this[action](notification);
				}
			}
		}
		
		/**
		 * 获取视图对象 
		 * @return object
		 * 
		 */
		public function getViewComponent():Object
		{
			return this.viewComponent;
		}
		
		/**
		 * 设置视图对象 
		 * @param viewComponent 视图对象或组件
		 * 
		 */		
		public function setViewComponent(viewComponent:Object):void
		{
			this.viewComponent = viewComponent;
		}
		
		/**
		 * 获取控制器名称 
		 * @return string
		 * 
		 */
		public function getControllerName():String
		{
			return this.controllerName;
		}
		public function setControllerName(name:String):void
		{
			this.controllerName = name;
		}
	}
}