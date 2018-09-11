package {

	import flash.display.MovieClip;
	import flash.sampler.NewObjectSample;
	import flash.events.Event;

	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		/**
		 * This array should only hold SnowObjects
		 */
		var snowflakes: Array = new Array();


		/**
		 * The number of frames to wait before spawning a new SnowObject
		 */
		var delaySpawn: int = 10;
		/**
		 * This is the where we setup the game.
		 */
		public function Game() {
			for (var i = 0; i < 10; i++) {
				var s: SnowObject = new SnowObject(this);

				this.addChild(s);
				snowflakes.push(s);
				//snowflakes.push(s);

			}

			addEventListener(Event.ENTER_FRAME, gameLoop);
		} // end Game Constructor

		/**
		 * This is the main loop of the game
		 * It is called every frame
		 * @param e The enter frame event object that triggered this event
		 */
		private function gameLoop(e: Event): void {
			this.spawnSnowObject();
			// TODO: update everything

			this.updateSnowflakes();


		} // end gameLoop
		
		
		/**
		* Spawns snow based on delaySpawn
		* Sets the delaySpawn based on a random number between 10 and 20;
		*/
		private function spawnSnowObject() {
			// spawn more snow 
			this.delaySpawn--;
			if (this.delaySpawn <= 0) {
				var s: SnowObject = new SnowObject(this);
				this.addChild(s);
				snowflakes.push(s);
				this.delaySpawn = Math.random() * 10 + 10;
			} // end if
		} // end spawnSnowObject
		
		/** 
		* iterates backward through the snowflakes collection and updates the reference
		*/
		private function updateSnowflakes() {
			for (var i = snowflakes.length - 1; i >= 0; i--) {
				snowflakes[i].update();
				if (snowflakes[i].isDead) {
					//remove it

					//remove event listeners

					snowflakes[i].dispose();// remove from scenegraph
					//nullify any variables pointing to it
					// if the variable is an array, remove the object from the array

					this.removeChild(snowflakes[i]);
					snowflakes.splice(i, 1);
				} // end if
			} // end for
		}// end updateSnowflakes
	} // end Game class

}