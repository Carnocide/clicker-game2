package {

	import flash.display.MovieClip;
	import flash.sampler.NewObjectSample;
	import flash.events.Event;
	import flash.utils.Timer;

	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		/**
		 * This array should only hold SnowObjects
		 */
		var snowflakes: Array = new Array();
		var needsToChangeWind: Boolean = false;
		public var windValue: Number = 0;
		var initialSnowflakes = 100;
		var isGameOver: Boolean = false;

		var goalVelocityX = 5; // No use creating a new class if velocity is the only part of its state that will change. (considering the scale of this game)

		var score: int = 0;

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
				if (score >= 1) {
					this.isGameOver = true;
				}

				goal.x += goalVelocityX;
			}
			else {
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

		private function changeWind(e: Event): void {
			trace("Changed Wind");
			this.needsToChangeWind = true;
			this.windValue = Math.random() * 5 - 2.5;
		} // endChangeWind
	} // end Game class

}