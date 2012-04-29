package helloflash.view
{
    import flash.events.*;
    import flash.geom.Rectangle;
	import flash.utils.Timer;
    import flash.display.Sprite;
	import flash.events.TimerEvent;
	
    public class HelloSprite extends Sprite {
		
		// Event name to tell Mediator to create a new sprite
		public static const SPRITE_DIVIDE:String = "spriteDivide";
		
		// id, size and color 
		public var id:String;
		public var size:uint = 75;
        public var color:uint = 0x0000FF;
		
		// boundaries
		public var xBound:uint = 400;
		public var yBound:uint = 400;
		
		// xy Location
		public var xLoc:uint = 175;
		public var yLoc:uint = 30;
		
		// xy Vector 		
		public var xVec:int = +3;
		public var yVec:int = -2;

		// This sprite's update timer
		private var timer:Timer;
		
		// the visible object
		private var child:Sprite;

		/**
		 * Constructor
		 * 
		 * Accepts the unique ID for this sprite, as well as its 
		 * other parameters xy location, vector, size and color
		 */
        public function HelloSprite( id:String, params:Array=null ) {
			this.id = id;
			if (params != null) {
				xLoc=params[0];
				yLoc=params[1];
				xVec=params[2];
				yVec=params[3];
				size=params[4];
				color=params[5];
			}
			draw();
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER, updatePosition);
			timer.start();
        }

		// User has pressed the mouse
        private function handleMouseDown(event:MouseEvent):void {
			timer.reset();
			child.startDrag();
			child.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
        }

		// User has released the mouse
        private function handleMouseUp(event:MouseEvent=null):void {
			dropSprite();
        }

		// drop the sprite 
		public function dropSprite():void
		{
			child.stopDrag();
			child.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			timer.start();
		}

		// Called only when dragging
		private function handleMouseMove(event:MouseEvent):void
		{
			if(child.x < xLoc) {
				xVec=-(Math.abs(xVec));
			} else if (child.x > xLoc) {
				xVec=Math.abs(xVec);
			}
			
			if(child.y < yLoc) {
				yVec=-(Math.abs(yVec));
			} else if (child.y > yLoc) {
				yVec=Math.abs(yVec);
			}
			
			xLoc=child.x;
			yLoc=child.y;
			dispatchEvent(new Event(SPRITE_DIVIDE));
		}

		// Update position based on vector and bounds
		public function updatePosition(event:Event):void
		{
			// update the x and y location based on x and vectors
			// then bounds check. Scale down when hitting a wall.
			// finally, update the acutal position of the sprite
			// with the newly calculated values.
			xLoc = xLoc + xVec;
			if ((xLoc +size) >= xBound) {
				xVec = -(xVec);
				scaleSprite(-5);
			} else if (xLoc <= 0) {
				xVec = -(xVec);
				xLoc = 0;
				scaleSprite(-5);
			}
			yLoc = yLoc + yVec;
			if ((yLoc + size) >= yBound) {
				yVec = -(yVec);
				scaleSprite(-5);
			} else if (yLoc <= 0) {
				yVec = -(yVec);
				yLoc = 0;
				scaleSprite(-5);
			}
			child.x = xLoc;
			child.y = yLoc;
		}
			
		// scale the sprite 
		public function scaleSprite(delta:Number):void
		{
			size+=(delta);
			if (size <= 5) size = 5;
			if (size >= 150) size = 5;
			draw();
		}
		
		public function get newSpriteState():Array
		{
			return [ xLoc, 
					 yLoc, 
					 -(xVec), 
					 -(yVec),
					 size,
					 color
					];	
		}
		
		// Create the actual sprite to display
        public function draw():void {
			if (child !=null) removeChild(child);
			child = new Sprite();
			child.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			child.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			child.graphics.clear();				
            child.graphics.beginFill(color);
            child.graphics.drawRect(0, 0, size, size);
            child.graphics.endFill();
			child.alpha = .25;
			child.x = xLoc;
			child.y = yLoc;
            addChild(child);
        }
    }
}