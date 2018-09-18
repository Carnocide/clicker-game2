package {

	import flash.display.MovieClip;
	import flash.sampler.NewObjectSample;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.MouseEvent;

	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		/**
		 * This array should only hold SnowObjects
		 */
		var snowflakes: Array = new Array();
		/**
		* Boolean value to turn on the wind the next game loop
		*/
		var needsToChangeWind: Boolean = false;
		/**
		* The direction and speed of the wind
		*/
		public var windValue: Number = 0;
		/**
		* Number of snowflakes at the start
		*/
		var initialSnowflakes = 100;
		/**
		* flag for game over state
		*/
		var isGameOver: Boolean = false;
		/**
		* The speed and direction of the goal platform.
		*/
		var goalVelocityX = 5; // No use creating a new class if velocity is the only part of its state that will change. (considering the scale of this game)
		/**
		* number of points
		*/
		var score: int = 0;

		/**
		* For tracking time
		*/
		var gameTimer: StopWatch = new StopWatch;
		/**
		 * The number of frames to wait before spawning a new SnowObject
		 */
		var delaySpawn: int = (initialSnowflakes / 60);
		/**
		 * This is the where we setup the game.
		 */
		public function Game() {
			for (var i = 0; i < initialSnowflakes; i++) {
				var s: SnowObject = new SnowObject(this);

				this.addChild(s);
				snowflakes.push(s);
				//snowflakes.push(s);

			}
			gameOver.visible = false;
			resetButton.visible = false;
			gameTimer.start();
			addEventListener(Event.ENTER_FRAME, gameLoop);
			addEventListener("CHANGE_WIND", changeWind);
			resetButton.addEventListener(MouseEvent.MOUSE_DOWN, resetGame);
		} // end Game Constructor

		/**
		 * This is the main loop of the game
		 * It is called every frame
		 * @param e The enter frame event object that triggered this event
		 */
		private function gameLoop(e: Event): void {
			if (!this.isGameOver) {
				this.spawnSnowObject();

				timeText.text = "Time: " + gameTimer.getTime();
				// TODO: update everything
				if (goal.x < goal.width / 2 || goal.x > stage.stageWidth - goal.width / 2) {
					this.goalVelocityX *= -1;
				}
				this.updateSnowflakes();
				if (score >= 10) {
					this.isGameOver = true;
				}

				goal.x += goalVelocityX;
			} else {
				gameOver.visible = true;
				resetButton.visible = true;

			}



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
				if (this.needsToChangeWind) {
					snowflakes[i].velocityX = this.windValue
				}
				snowflakes[i].update();
				if (snowflakes[i].hasBeenClicked && (snowflakes[i].y + (snowflakes[i].height / 2)) >= this.stage.stageHeight - snowflakes[i].velocityY && (snowflakes[i].x + (snowflakes[i].width / 2) <= (goal.x + goal.width / 2) && (snowflakes[i].x + (snowflakes[i].width / 2) >= (goal.x - goal.width / 2)))) {
					trace("Colision");
					snowflakes[i].isDead = true;
					score++;
					trace(score);
					this.goalVelocityX -= 0.3;

				} // end collision check
				count.text = "Count: " + this.score.toString();
				if (snowflakes[i].isDead) {
					//remove it

					//remove event listeners

					snowflakes[i].dispose(); // remove from scenegraph
					//nullify any variables pointing to it
					// if the variable is an array, remove the object from the array

					this.removeChild(snowflakes[i]);
					snowflakes.splice(i, 1);
				} // end if
			} // end for
		} // end updateSnowflakes

		/**
		*	Resets the game
		* @param e the event handler object
		*/ 
		private function resetGame(e: Event): void {
			resetButton.visible = false;
			gameOver.visible = false;
			score = 0;
			this.isGameOver = false;
			for (var i = 0; i < snowflakes.length; i++) {
				snowflakes[i].y = 0;
				this.windValue = 0;
			}
			gameTimer.start();


		}
		
		/**
		* Function for changing the wind, sets direction and speed.
		* @param e the event handler object
		*/
		private function changeWind(e: Event): void {
			trace("Changed Wind");
			this.needsToChangeWind = true;
			this.windValue = Math.random() * 5 - 2.5;
		} // endChangeWind
	} // end Game class

}