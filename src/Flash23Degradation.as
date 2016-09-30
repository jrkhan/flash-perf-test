package
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.events.Event;
	
	public class Flash23Degradation extends Sprite
	{
		public static const RUNS:int = 20;
		public static const INVOCATIONS_PER_FRAME:int = 200000000;
		
		public var tf:TextField = new TextField();
		public var timer:Timer = new Timer(0);
		
		public function Flash23Degradation() {
			this.addChild(tf);
			tf.width = 400;
			tf.height = 2000;
			
			tf.text = 'Starting tests: ';
			runTests();
		}
		
		public var currentDepth:int = -1;
		public var maxDepth:int = int.MAX_VALUE;
		public var iterationsPerFrame:int;
		
		public function runTests():void {
			var before:int, after:int;
			var error:Boolean = false;
			var remaining:int = RUNS;
			iterationsPerFrame = 1; 
			
			tf.text = '\n Running tests (this may take a while) max depth is near ' + maxDepth;
			timer.addEventListener(TimerEvent.TIMER, function(e:Event){

				before = getTimer();
				
				for (var i:int = 0; i < iterationsPerFrame; i++ ) {
					try {
						currentDepth = -1;
						error = false;
						recursiveMethod(maxDepth);
					} catch(e:Error) {
						error = true;
						remaining = RUNS;
						maxDepth = currentDepth;
						iterationsPerFrame = INVOCATIONS_PER_FRAME/maxDepth;
						tf.text = '\n Running tests (this may take a while) max depth is near ' + maxDepth;
						break;
					}
				}

				if ( !error ) {
					after = getTimer();
					remaining--;
					tf.text += '\n' + String(after - before);
					if ( remaining == 0 ) {
						timer.stop();
						tf.text += '\n' +  'Tests complete';
					}
				}
			});
			
			timer.start();
		}
		
		public function recursiveMethod(i:int):void {
			currentDepth++;
			if ( i > 0 ) {
				 recursiveMethod(--i);
			}
		}

	}
}


