package mm.dida
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mm.dida.observer.Notifier;

	/**
	 * A base Class of Model and Service.
	 * 
	 * <p>The Model - provides a means to access and manipulate application data. 
	 * It extends the Actor Class to provide controlled access to a data object.
	 * </p>
	 * 
	 * <p>The Service - provides a means to interact with Server-Side. It also 
	 * extends the Actor Class to provide send request to Server-Side and manipulate 
	 * model to update data.
	 * </p>
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
		 * Gets the singleton instance.
		 */
		public static function getInstance(ref:Class):*
		{
			if (dict[ref] == null)
				dict[ref] = new ref();
			
			return dict[ref];
		}
		
		/**
		 * Destroy the singleton instance.
		 */
		public function destroy():void
		{
			var ref:Class = this["constructor"] as Class;
			delete dict[ref];
		}
		
		/**
		 * Sets/gets the data property. 
		 */		
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