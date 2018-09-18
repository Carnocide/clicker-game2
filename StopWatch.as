package  {
	import flash.utils.getTimer;
	
	public class StopWatch {
		
		var started:Boolean = false;
		var timeStarted:int;

		public function StopWatch() {
			// constructor code
		}
		
		public function start():void {
			timeStarted = flash.utils.getTimer();
			started = true;
		}
		
		public function getTime():int {
			return started ? getTimer() - timeStarted : 0;
		}

	}
	
}
