package controller
{
    import ApplicationFacade;
    
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    import model.SpriteDataModel;
    
    import org.yimvc.Controller;
    import org.yimvc.observer.Notification;
    
    import view.HelloSprite;

    /**
     * A Controller for interacting with the Stage.
     */
    public class StageController extends Controller
    {
        // Cannonical name of the Controller
        public static const NAME:String = 'StageController';

        /**
         * Constructor. 
         */
        public function StageController( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( viewComponent );
    
			// Retrieve reference to frequently consulted Proxies
			spriteDataProxy = SpriteDataModel.getInstance();
			
            // Listen for events from the view component 
            stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
            stage.addEventListener( MouseEvent.MOUSE_WHEEL, handleMouseWheel );
            
        }


        /**
         * List all notifications this Controller is interested in.
         * <P>
         * Automatically called by the framework when the controller
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ ApplicationFacade.STAGE_ADD_SPRITE
                   ];
        }

        /**
         * Handle all notifications this Controller is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
		
		public function actionStageAddSprite(note:Notification):void
		{
			var params:Array = note.getBody() as Array;
			var helloSprite:HelloSprite = new HelloSprite( spriteDataProxy.nextSpriteID, params );
			facade.registerController(new HelloSpriteController( helloSprite ));
			stage.addChild( helloSprite );
		}
		
//        override public function handleNotification( note:Notification ):void 
//        {
//            switch ( note.getName() ) {
//                
//                // Create a new HelloSprite, 
//				// Create and register its HelloSpriteController
//				// and finally add the HelloSprite to the stage
//                case ApplicationFacade.STAGE_ADD_SPRITE:
//					var params:Array = note.getBody() as Array;
//					var helloSprite:HelloSprite = new HelloSprite( spriteDataProxy.nextSpriteID, params );
//					facade.registerController(new HelloSpriteController( helloSprite ));
//					stage.addChild( helloSprite );
//                    break;
//            }
//        }

		// The user has released the mouse over the stage
        private function handleMouseUp(event:MouseEvent):void
		{
			sendNotification( ApplicationFacade.SPRITE_DROP );
		}
                    
		// The user has released the mouse over the stage
        private function handleMouseWheel(event:MouseEvent):void
		{
			sendNotification( ApplicationFacade.SPRITE_SCALE, event.delta );
		}
                    
        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Controller class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return stage the viewComponent cast to flash.display.Stage
         */
        protected function get stage():Stage
		{
            return viewComponent as Stage;
        }
		
		private var spriteDataProxy:SpriteDataModel;
    }
}