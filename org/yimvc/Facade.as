package org.yimvc
{
	import org.yimvc.observer.Notification;
	import org.yimvc.observer.Observer;

	/**
	 * Facade是框架的管理员
	 * 
	 * <br>框架以消息(Notificatioin)为沟通的方式，消息发送都通过facade的sendNotification方法
	 * <br>Controller、Model和Service层都是Notifier的子孙，所以都具有发消息的能力
	 * <br>Model和Service都需要继承Actor，Actor也继承自Notifier
	 * <br>只有Controller才有接受消息的能力，但是需要通过Facade.registerController注册后才具备
	 *  
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Facade
	{
		protected static var instance:Facade;
		
		private var observerMap:Array;
		private var controllerMap:Array;
		
		public function Facade()
		{
			if (instance != null) throw Error('Facade Singleton already constructed!'); 
			instance = this;
			initializeFacade();
		}
		
		/**
		 * 获取Facade单例 
		 * @return Facade Facade实例
		 * 
		 */
		public static function getInstance():Facade
		{
			if (instance == null) instance = new Facade;
			return instance;
		}
		
		/**
		 * 初始化Facade 
		 */
		protected function initializeFacade():void
		{
			observerMap = new Array;
			controllerMap = new Array;
		}
		
		/**
		 * 发送消息 
		 * @param name string 消息名称
		 * @param body object 消息参数体
		 * @param type string 消息类型
		 * 
		 */
		public function sendNotification(name:String, body:Object=null, type:String=''):void
		{
			notifyObservers(new Notification(name, body, type));
		}
		
		/**
		 * 注册Controller，注册后的Controller具有接受消息的能力
		 * @param controller 控制器
		 * 
		 */
		public function registerController(controller:Controller):void
		{
			if (controllerMap[controller.getControllerName()] != null) return;
			
			controllerMap[controller.getControllerName()] = controller;
			
			var interests:Array = controller.listNotificationInterests();
			
			if (interests.length>0) {
				var observer:Observer = new Observer(controller.handleNotification, controller);
				
				for (var i:int=0; i<interests.length; i++) {
					this.registerObserver(interests[i], observer);
				}
			}
			
			controller.onRegister();
		}
		
		/**
		 * 获取Controller实例 
		 * @param controllerName string 控制器名称
		 * @return Controller
		 * 
		 */
		public function retrieveController(controllerName:String):Controller
		{
			return controllerMap[controllerName];
		}
		
		/**
		 * Controller是否已经注册 
		 * @param controllerName string 控制器名称
		 * @return bool
		 * 
		 */
		public function hasController(controllerName:String):Boolean
		{
			return controllerMap[controllerName] != null;
		}
		
		/**
		 * 删除已经注册的Controlller 
		 * @param controllerName string 控制器名称
		 * @return Controller
		 * 
		 */
		public function removeController(controllerName:String):Controller
		{
			var controller:Controller = controllerMap[controllerName] as Controller;
			
			if ( controller ) 
			{
				var interests:Array = controller.listNotificationInterests();
				for ( var i:int=0; i<interests.length; i++ ) 
				{
					removeObserver( interests[i], controller );
				}	
				
				delete controllerMap[controllerName];
				
				controller.onRemove();
			}
			return controller;
		}
		
		
		/**
		 * private methods 
		 */		
		
		/**
		 * 观察者模式实现，实现消息的监听注册和发送
		 * @param notificationName 消息名称
		 * @param observer 观察者
		 * 
		 */
		private function registerObserver(notificationName:String, observer:Observer):void
		{
			var observers:Array = observerMap[notificationName];
			if (observers) {
				observers.push(observer);
			} else {
				observerMap[notificationName] = [observer];
			}
		}
		
		/**
		 * 通知观察者 
		 * @param notification 消息体
		 * 
		 */
		private function notifyObservers(notification:Notification):void
		{
			if (observerMap[notification.getName()] != null) {
				var observers_ref:Array = observerMap[notification.getName()] as Array;
				
				var observers:Array = new Array;
				var observer:Observer;
				for (var i:int = 0; i < observers_ref.length; i++) {
					observer = observers_ref[i] as Observer;
					observers.push(observer);
				}
				
				for (i=0; i<observers.length; i++) {
					observer = observers[i] as Observer;
					observer.nofityObserver(notification);
				}
			}
		}
		
		/**
		 * 移除观察者 
		 * @param notificationName string 消息名称
		 * @param notifyContext 上下文
		 * 
		 */
		private function removeObserver(notificationName:String, notifyContext:Object):void
		{
			var observers:Array = observerMap[notificationName] as Array;
			
			for (var i:int=0; i<observers.length; i++) {
				if (Observer(observers[i]).compareNotifyContext(notifyContext)) {
					observers.splice(i, 1);
					break;
				}
			}
			if (observers.length == 0) {
				delete observerMap[notificationName];
			}
		}
	}
}