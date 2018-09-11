package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class SnowObject extends MovieClip {
		/** 
		* Determines the rate at which the snow falls
		*/
		var velocityY:Number;
		
		/**
		* Tracks if the snow is dead. If it is dead, it is destroyed. Somber
		*/
		var isDead:Boolean = false;
		
		/**
		* This is the constructor for the SnowObject.
		* It instantiates any variables if necessary and is run when the object is created
		*/
		public function SnowObject(game:Game) {
			// constructor code
			this.x = Math.random() * game.stage.stageWidth; //stage width
			this.y = -50; //stage height;
			this.scaleX = Math.random() * .2 + .1; // .1 to .3
			this.scaleY = scaleX;
			this.velocityY = Math.random() * 3 + 1;
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleClick)
		}
		
		/**
		* This updates the state of the SnowObject
		*/
		public function update():void {
			this.y += this.velocityY;
			
			if (this.y > this.stage.stageHeight + (this.height / 2))
			{
				this.isDead = true;
				
			}
		}
		
		/**
		* Randomly changes the size of the snowflake when clicked
		*/
		private function handleClick(e:MouseEvent):void {
			this.scaleX = Math.random() * .2 + .5// 10 to 20
			this.scaleY = this.scaleX;
		}
		
		/**
		*	Removes the event listeners attached to this SnowObject
		*/ 
		public function dispose():void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
		}
	}
	
}
