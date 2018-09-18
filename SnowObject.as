package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.ColorTransform;


	public class SnowObject extends MovieClip {
		/** 
		 * Determines the rate at which the snow falls
		 */
		var velocityY: Number;
		public var velocityX: Number;

		/**
		 * Tracks if the snow is dead. If it is dead, it is destroyed. Somber
		 */
		var isDead: Boolean = false;
		public var hasBeenClicked: Boolean = false;

		/**
		 * This is the constructor for the SnowObject.
		 * It instantiates any variables if necessary and is run when the object is created
		 */
		public function SnowObject(game: Game) {
			// constructor code
			this.x = Math.random() * game.stage.stageWidth * 2 - (game.stage.stageWidth / 2); //stage width
			this.y = -50; //stage height;
			this.scaleX = Math.random() * .2 + .1; // .1 to .3
			this.scaleY = scaleX;
			this.velocityY = Math.random() * 4 + 2;
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleClick)
			this.velocityX = game.windValue;
		}

		/**
		 * This updates the state of the SnowObject
		 */
		public function update(): void {
			if (this.hasBeenClicked) {
				this.velocityX = 0;
			}
			this.y += this.velocityY;
			this.x += this.velocityX;

			if (this.y > this.stage.stageHeight + (this.height / 2)) {
				this.isDead = true;

			}

		}

		/**
		 * Randomly changes the size of the snowflake when clicked
		 */
		private function handleClick(e: MouseEvent): void {
			this.scaleX = Math.random() * .2 + .5 // 10 to 20
			this.scaleY = this.scaleX;
			var cf = new ColorTransform();
			cf.color = 0x468284;
			this.transform.colorTransform = cf;
			this.hasBeenClicked = true;
			this.dispatchEvent(new Event("CHANGE_WIND", true, false));
			this.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}

		/**
		 * Exposes the velocityX parameter, called from the game class and should be the same for all snow flakes
		 */
		public function setVelocityX(value: Number): void {
			this.velocityX = value;
		} // end setVelocityX

		/**
		 *	Removes the event listeners attached to this SnowObject
		 */
		public function dispose(): void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);

		}
	}

}