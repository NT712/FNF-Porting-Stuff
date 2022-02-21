#if android
import extension.webview.WebView;
import android.*;
#end
import flixel.FlxBasic;
import flixel.FlxG;

class FlxVideo extends FlxBasic {
	public var finishCallback:Void->Void = null;

        #if android
        var player:WebView;
        #end

	public function new(name:String) {
		super();

		#if android
		player.onClose = function(){
        	        trace("WebView has been closed!");
	                if (finishCallback != null){
				finishCallback();
			}
		}
		player.onURLChanging = function(url:String){
	                trace("WebView is about to open: " + url);
	                if (url == 'http://exitme'){
	        	        if (finishCallback != null){
					finishCallback();
				}
			}
		}
		player.open(AndroidTools.getFileUrl(name), null, ['http://exitme']);
		#end
	}
}
