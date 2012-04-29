package helloflash
{
	import helloflash.controller.StageController;
	
	import mm.dida.Facade;

    public class ApplicationFacade extends Facade
    {
        // Notification name constants
        public static const STAGE_ADD_SPRITE:String	= "StageAddSprite";
        public static const SPRITE_SCALE:String 	= "SpriteScale";
		public static const SPRITE_DROP:String		= "SpriteDrop"

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeFacade():void 
        {
            super.initializeFacade();			
        }
        
        public function startup( stage:Object ):void
        {
			registerController( new StageController( stage ) );
			sendNotification( STAGE_ADD_SPRITE );
        }
        
    }
}