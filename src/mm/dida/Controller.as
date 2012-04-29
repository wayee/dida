package mm.dida
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mm.dida.observer.Notification;
	import mm.dida.observer.Notifier;

	/**
	 * The Controller - represents a means by which UI elements can manipulate 
	 * <br>the model and serivce. Controllers are specific implementations 
	 * <br>that determine how the application responds to user input. For example, 
	 * <br>controllers can do validation checks on user input and decide if 
	 * <br>application data needs to be updated.
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
			addListeners();
		}
		
		public function onRegister():void {}
		public function onRemove():void {}
		
		protected function onViewCreateComplete(e:Event):void {}
		protected function onViewRemoveComplete(e:Event):void {}
		
		/**
		 * Listening the notification 
		 * 
		 * @return array notification name list
		 * 
		 */		
		public function listNotificationInterests():Array { return []; }
		
		/**
		 * handle the notifacation.
		 * <br>Relection to the action methods of controller.
		 * 
		 * @param notification notification object
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
		 * Sets/gets View Component
		 */
		public function getViewComponent():Object
		{
			return this.viewComponent;
		}
		public function setViewComponent(viewComponent:Object):void
		{
			removeListeners();
			this.viewComponent = viewComponent;
			addListeners();
		}
		
		/**
		 * Sets/gets controller name
		 */
		public function getControllerName():String
		{
			return this.controllerName;
		}
		public function setControllerName(name:String):void
		{
			this.controllerName = name;
		}
		
		/**
		 * Adds/removes listeners 
		 */		
		public function addListeners():void
		{
			if (this.viewComponent) {
				IEventDispatcher(this.viewComponent).addEventListener(Event.ADDED_TO_STAGE, onViewCreateComplete, false, 0, true);
				IEventDispatcher(this.viewComponent).addEventListener(Event.ADDED_TO_STAGE, onViewRemoveComplete, false, 0, true);
			}
		}
		public function removeListeners():void
		{
			if (this.viewComponent) {
				IEventDispatcher(this.viewComponent).removeEventListener(Event.ADDED_TO_STAGE, onViewCreateComplete);
				IEventDispatcher(this.viewComponent).removeEventListener(Event.ADDED_TO_STAGE, onViewRemoveComplete);
			}
		}
		
	}
}