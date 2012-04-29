package mm.dida
{
	import flash.utils.Dictionary;
	
	import mm.dida.observer.Notification;
	import mm.dida.observer.Observer;

	/**
	 * Facade is a manager of the framework.
	 * 
	 * @author Andy Cai (huayicai@gmail.com)
	 * 
	 */
	public class Facade
	{
		protected static var instance:Facade;
		
		private var observerMap:Dictionary;
		private var controllerMap:Dictionary;
		
		public function Facade()
		{
			if (instance != null) throw Error('Facade Singleton already constructed!'); 
			instance = this;
			initializeFacade();
		}
		
		/**
		 * Gets the Facade singleton instance. 
		 */
		public static function getInstance():Facade
		{
			if (instance == null) instance = new Facade;
			return instance;
		}
		
		/**
		 * Initializing Facade.
		 */
		protected function initializeFacade():void
		{
			observerMap = new Dictionary;
			controllerMap = new Dictionary;
		}
		
		/**
		 * Observer pattern, register a observer
		 * 
		 * @param notificationName string notification name
		 * @param observer a Observer object
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
		 * notify the Observers
		 * 
		 * @param notification string notification name
		 * 
		 */
		private function notifyObservers(notification:Notification):void
		{
			if (observerMap[notification.getName()] != null) {
				var observers:Array = observerMap[notification.getName()] as Array;
				var len:int = observers.length;
				var observer:Observer;
				for (var i:int = 0; i < len; i++) {
					observer = observers[i] as Observer;
					observer.nofityObserver(notification);
				}
			}
		}
		
		/**
		 * remove the Observer.
		 * 
		 * @param notificationName string notification name
		 * @param notifyContext Observer context
		 * 
		 */
		private function removeObserver(notificationName:String, notifyContext:Object):void
		{
			var observers:Array = observerMap[notificationName] as Array;
			var len:int = observers.length;
			for (var i:int=0; i<len; i++) {
				if (Observer(observers[i]).compareNotifyContext(notifyContext)) {
					observers.splice(i, 1);
					break;
				}
			}
			if (observers.length == 0) {
				delete observerMap[notificationName];
			}
		}
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * send notification.
		 * 
		 * @param name string notification name
		 * @param body object notification body object
		 * @param type string notification type
		 * 
		 */
		public function sendNotification(name:String, body:Object=null, type:String=''):void
		{
			notifyObservers(new Notification(name, body, type));
		}
		
		/**
		 * register the controller
		 */
		public function registerController(controller:Controller):void
		{
			if (controllerMap[controller.getControllerName()] != null) return;
			
			controllerMap[controller.getControllerName()] = controller;
			
			var interests:Array = controller.listNotificationInterests();
			
			if (interests.length>0) {
				var observer:Observer = new Observer(controller.handleNotification, controller);
				
				var len:int = interests.length;
				for (var i:int=0; i<len; i++) {
					this.registerObserver(interests[i], observer);
				}
			}
			
			controller.onRegister();
		}
		
		/**
		 * Gets teh Controller instance by controller name.
		 * 
		 * @param controllerName string controller name
		 * @return Controller
		 * 
		 */
		public function retrieveController(controllerName:String):Controller
		{
			return controllerMap[controllerName];
		}
		
		/**
		 * Controller whether registered.
		 *  
		 * @param controllerName string controller name
		 * @return bool
		 * 
		 */
		public function hasController(controllerName:String):Boolean
		{
			return controllerMap[controllerName] != null;
		}
		
		/**
		 * Remove the registered Controlller 
		 * 
		 * @param controllerName string controller name
		 * @return Controller
		 * 
		 */
		public function removeController(controllerName:String):Controller
		{
			var controller:Controller = controllerMap[controllerName] as Controller;
			
			if ( controller ) 
			{
				var interests:Array = controller.listNotificationInterests();
				var len:int = interests.length;
				for ( var i:int=0; i<len; i++ ) 
				{
					removeObserver( interests[i], controller );
				}	
				
				delete controllerMap[controllerName];
				
				controller.onRemove();
			}
			return controller;
		}
	}
}