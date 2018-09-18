package  {
	import flash.utils.getTimer;
	
	public class StopWatch {
		
		/**
		* Boolean value to tell if the stopwatch is started.
		*/
		var started:Boolean = false;
		/**
		* The number of milliseconds since the game started that the stopwatch was started
		*/
		var timeStarted:int;
		/**
		*	Not used
		*/
		public function StopWatch() {
			// constructor code
		}
		
		/**
		* starts the stopwatch
		*/
		public function start():void {
			timeStarted = flash.utils.getTimer();
			started = true;
		}
		
		/**
		* gets the time since the game started minus the time you started the stopwatch.
		*/
		public function getTime():int {
			return started ? getTimer() - timeStarted : 0;
		}

	}
	
}
