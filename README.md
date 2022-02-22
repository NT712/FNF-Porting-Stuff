# FNF-Porting-Stuff
The Things im using when i port a mod to android

# This methot is focused for psych engine mods ports so if you want to port anoder mods with it you have to moddfy some code

## Instructions:

1. You Need to install AndroidTools, Extension-Webview and to replace the linc_luajit

To Install Them You Need To Open Command prompt/PowerShell And To Tipe
```cmd
haxelib git AndroidTools https://github.com/jigsaw-4277821/AndroidTools.git

haxelib git extension-webview https://github.com/jigsaw-4277821/extension-webview.git

haxelib remove linc_luajit

haxelib git linc_luajit https://github.com/jigsaw-4277821/linc_luajit.git

```

2. Download the repository code and paste it in your source code folder

3. You Need to add in project.xml those things

On This Line
```xml
	<!--Mobile-specific-->
	<window if="mobile" orientation="landscape" fullscreen="true" width="0" height="0" resizable="false"/>

```

Replace It With
```xml
	<!--Mobile-specific-->
	<window if="mobile" orientation="landscape" fullscreen="true" width="1280" height="720" resizable="false"/>

```

On Those Lines
```xml
	<!-- PSYCH ENGINE CUSTOMIZATION -->
	<define name="MODS_ALLOWED" if="desktop"/>
	<define name="LUA_ALLOWED" if="windows"/>
	<define name="ACHIEVEMENTS_ALLOWED" />
	<define name="VIDEOS_ALLOWED" if="web || desktop" unless="32bits"/>
	<define name="PSYCH_WATERMARKS"/> <!-- DELETE THIS TO REMOVE WATERMARKS ON TITLE SCREEN -->

```

Replace It With
```xml
	<!-- PSYCH ENGINE CUSTOMIZATION -->
	<define name="MODS_ALLOWED" if="desktop || android"/>
	<define name="LUA_ALLOWED" if="windows || android"/>
	<define name="ACHIEVEMENTS_ALLOWED" />
	<define name="VIDEOS_ALLOWED" if="web || desktop || android" unless="32bits"/>
	<define name="PSYCH_WATERMARKS"/> <!-- DELETE THIS TO REMOVE WATERMARKS ON TITLE SCREEN -->

```

Than, After the Libraries, or where the packeges are located
```xml
	<haxelib name="faxe" if='switch'/>
	<!--<haxelib name="polymod"/> -->
	<haxelib name="discord_rpc" if="desktop"/>

```
add
```xml
    <haxelib name="extension-webview" if="android"/>
    <haxelib name="AndroidTools" if="android"/>

    <config:android permission="android.permission.READ_EXTERNAL_STORAGE" if="android"/>
    <config:android permission="android.permission.WRITE_EXTERNAL_STORAGE" if="android"/>

```

4. Setup the Controls.hx

after those lines
```haxe
   	import flixel.input.actions.FlxActionSet;
	import flixel.input.keyboard.FlxKey;

```
add

```haxe
	#if android
	import flixel.group.FlxGroup;
	import ui.Hitbox;
	import ui.FlxVirtualPad;
	import flixel.ui.FlxButton;
	#end

```

before those lines
```haxe
	override function update()
	{
		super.update();
	}

```

add
```haxe
	#if android
	public var trackedinputsUI:Array<FlxActionInput> = [];
	public var trackedinputsNOTES:Array<FlxActionInput> = [];	

	public function addbuttonuNOTES(action:FlxActionDigital, button:FlxButton, state:FlxInputState) 
	{
		var input = new FlxActionInputDigitalIFlxInput(button, state);
		trackedinputsNOTES.push(input);
		
		action.add(input);
	}

	public function addbuttonuUI(action:FlxActionDigital, button:FlxButton, state:FlxInputState) {
		var input = new FlxActionInputDigitalIFlxInput(button, state);
		trackedinputsUI.push(input);
		
		action.add(input);
	}

	public function setHitBox(hitbox:Hitbox) 
	{
		inline forEachBound(Control.NOTE_UP, (action, state) -> addbuttonuNOTES(action, hitbox.buttonUp, state));
		inline forEachBound(Control.NOTE_DOWN, (action, state) -> addbuttonuNOTES(action, hitbox.buttonDown, state));
		inline forEachBound(Control.NOTE_LEFT, (action, state) -> addbuttonuNOTES(action, hitbox.buttonLeft, state));
		inline forEachBound(Control.NOTE_RIGHT, (action, state) -> addbuttonuNOTES(action, hitbox.buttonRight, state));	
	}
	
	public function setVirtualPadUI(virtualPad:FlxVirtualPad, ?DPad:FlxDPadMode, ?Action:FlxActionMode) 
	{
		if (DPad == null)
			DPad = NONE;
		if (Action == null)
			Action = NONE;
		
		switch (DPad)
		{
			case UP_DOWN:
				inline forEachBound(Control.UI_UP, (action, state) -> addbuttonuUI(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.UI_DOWN, (action, state) -> addbuttonuUI(action, virtualPad.buttonDown, state));
			case LEFT_RIGHT:
				inline forEachBound(Control.UI_LEFT, (action, state) -> addbuttonuUI(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.UI_RIGHT, (action, state) -> addbuttonuUI(action, virtualPad.buttonRight, state));
			case UP_LEFT_RIGHT:
				inline forEachBound(Control.UI_UP, (action, state) -> addbuttonuUI(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.UI_LEFT, (action, state) -> addbuttonuUI(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.UI_RIGHT, (action, state) -> addbuttonuUI(action, virtualPad.buttonRight, state));
			case FULL | RIGHT_FULL:
				inline forEachBound(Control.UI_UP, (action, state) -> addbuttonuUI(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.UI_DOWN, (action, state) -> addbuttonuUI(action, virtualPad.buttonDown, state));
				inline forEachBound(Control.UI_LEFT, (action, state) -> addbuttonuUI(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.UI_RIGHT, (action, state) -> addbuttonuUI(action, virtualPad.buttonRight, state));
			case NONE:
		}

		switch (Action)
		{
			case A:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
            case B:
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));
			case D:
                //nothing				
			case A_B:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));
			case A_B_C:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));					
			case A_B_E:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));	
			case A_B_X_Y:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));		
			case A_B_C_X_Y:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuUI(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuUI(action, virtualPad.buttonB, state));	
            case A_B_C_X_Y_Z:
                //nothing
            case FULL:
                //nothing
			case NONE:
		}
	}

	public function setVirtualPadNOTES(virtualPad:FlxVirtualPad, ?DPad:FlxDPadMode, ?Action:FlxActionMode) 
	{
		if (DPad == null)
			DPad = NONE;
		if (Action == null)
			Action = NONE;
		
		switch (DPad)
		{
			case UP_DOWN:
				inline forEachBound(Control.NOTE_UP, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.NOTE_DOWN, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonDown, state));
			case LEFT_RIGHT:
				inline forEachBound(Control.NOTE_LEFT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.NOTE_RIGHT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonRight, state));
			case UP_LEFT_RIGHT:
				inline forEachBound(Control.NOTE_UP, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.NOTE_LEFT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.NOTE_RIGHT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonRight, state));
			case FULL | RIGHT_FULL:
				inline forEachBound(Control.NOTE_UP, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonUp, state));
				inline forEachBound(Control.NOTE_DOWN, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonDown, state));
				inline forEachBound(Control.NOTE_LEFT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonLeft, state));
				inline forEachBound(Control.NOTE_RIGHT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonRight, state));
			case NONE:
		}

		switch (Action)
		{
			case A:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
            case B:
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));
			case D:
                //nothing							
			case A_B:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));
			case A_B_C:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));				
			case A_B_E:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));
			case A_B_X_Y:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));
			case A_B_C_X_Y:
				inline forEachBound(Control.ACCEPT, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonA, state));
				inline forEachBound(Control.BACK, (action, state) -> addbuttonuNOTES(action, virtualPad.buttonB, state));			
            case A_B_C_X_Y_Z:
                //nothing
            case FULL:
                //nothing                
			case NONE:
		}
	}
	

	public function removeFlxInput(Tinputs) {
		for (action in this.digitalActions)
		{
			var i = action.inputs.length;
			
			while (i-- > 0)
			{
				var input = action.inputs[i];

				var x = Tinputs.length;
				while (x-- > 0)
					if (Tinputs[x] == input)
						action.remove(input);
			}
		}
	}	
	#end
```

and instead of those lines
```haxe
	public function bindKeys(control:Control, keys:Array<FlxKey>)
	{
		var copyKeys:Array<FlxKey> = keys.copy();
		for (i in 0...copyKeys.length) {
			if(i == NONE) copyKeys.remove(i);
		}

		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, state) -> addKeys(action, copyKeys, state));
		#else
		forEachBound(control, function(action, state) addKeys(action, copyKeys, state));
		#end
	}

	public function unbindKeys(control:Control, keys:Array<FlxKey>)
	{
		var copyKeys:Array<FlxKey> = keys.copy();
		for (i in 0...copyKeys.length) {
			if(i == NONE) copyKeys.remove(i);
		}

		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, _) -> removeKeys(action, copyKeys));
		#else
		forEachBound(control, function(action, _) removeKeys(action, copyKeys));
		#end
	}

```

add
```haxe
    #if !android
	public function bindKeys(control:Control, keys:Array<FlxKey>)
	{
		var copyKeys:Array<FlxKey> = keys.copy();
		for (i in 0...copyKeys.length) {
			if(i == NONE) copyKeys.remove(i);
		}

		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, state) -> addKeys(action, copyKeys, state));
		#else
		forEachBound(control, function(action, state) addKeys(action, copyKeys, state));
		#end
	}

	public function unbindKeys(control:Control, keys:Array<FlxKey>)
	{
		var copyKeys:Array<FlxKey> = keys.copy();
		for (i in 0...copyKeys.length) {
			if(i == NONE) copyKeys.remove(i);
		}

		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, _) -> removeKeys(action, copyKeys));
		#else
		forEachBound(control, function(action, _) removeKeys(action, copyKeys));
		#end
	}
	
	#else

	public function bindKeys(control:Control, keys:Array<FlxKey>)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, state) -> addKeys(action, keys, state));
		#else
		forEachBound(control, function(action, state) addKeys(action, keys, state));
		#end	
	}

	public function unbindKeys(control:Control, keys:Array<FlxKey>)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, _) -> removeKeys(action, keys));
		#else
		forEachBound(control, function(action, _) removeKeys(action, keys));
		#end		
	}	
	#end
```

5. Setup MusicBeatState.hx

in the lines you import things add
```haxe
#if android
import flixel.input.actions.FlxActionInput;
import android.AndroidControls.AndroidControlsSetup;
import android.FlxVirtualPad;
#end
```

after those lines
```haxe
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
```

add
```haxe
	#if android
	var _virtualpad:FlxVirtualPad;
	var androidc:AndroidControls;
	var trackedinputsUI:Array<FlxActionInput> = [];
	var trackedinputsNOTES:Array<FlxActionInput> = [];
	#end
	
	#if android
	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action);
		_virtualpad.alpha = 0.75;
		add(_virtualpad);
		controls.setVirtualPadUI(_virtualpad, DPad, Action);
		trackedinputsUI = controls.trackedinputsUI;
		controls.trackedinputsUI = [];
	}
	#else
	public function addVirtualPad(?DPad, ?Action)
	#end

	public function addAndroidControls() {
		#if android
        androidc = new AndroidControls();

		switch (androidc.mode)
		{
			case VIRTUALPAD_RIGHT | VIRTUALPAD_LEFT | VIRTUALPAD_CUSTOM:
				controls.setVirtualPadNOTES(androidc._virtualPad, FULL, NONE);
			case HITBOX:
				controls.setHitBoxNOTES(androidc._hitbox);
			default:
		}

		trackedinputsNOTES = controls.trackedinputsNOTES;
		controls.trackedinputsNOTES = [];

		var camcontrol = new flixel.FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		androidc.cameras = [camcontrol];

		androidc.visible = false;

		add(androidc);
		#end
	}

    public function addPadCamera() {
		#if android
		var camcontrol = new flixel.FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
		#end
	}
	
	override function destroy() {
		#if android
		controls.removeFlxInput(trackedinputsUI);
		controls.removeFlxInput(trackedinputsNOTES);	
		#end	
		
		super.destroy();
	}
```

6. Setup MusicBeatSubstate.hx

in the lines you import things add
```haxe
#if android
import flixel.input.actions.FlxActionInput;
import android.AndroidControls.AndroidControlsSetup;
import android.FlxVirtualPad;
#end
```

after those lines
```haxe
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
```

add
```haxe
	#if android
	var _virtualpad:FlxVirtualPad;
	var trackedinputsUI:Array<FlxActionInput> = [];
	var trackedinputsNOTES:Array<FlxActionInput> = [];
	#end
	
	#if android
	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action);
		_virtualpad.alpha = 0.75;
		add(_virtualpad);
		controls.setVirtualPadUI(_virtualpad, DPad, Action);
		trackedinputsUI = controls.trackedinputsUI;
		controls.trackedinputsUI = [];
	}
	#else
	public function addVirtualPad(?DPad, ?Action)
	#end

    public function addPadCamera() {
		#if android
		var camcontrol = new flixel.FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
		#end
	}
	
	override function destroy() {
		#if android
		controls.removeFlxInput(trackedinputsUI);
		controls.removeFlxInput(trackedinputsNOTES);	
		#end	
		
		super.destroy();
	}
```

And Somehow you finised to add the android controls to your psych engine copy

now on every state/substate add
```haxe
	addVirtualPad(FULL, A_B);

	//if you want it to have a camera
	addPadCamera()

	//in states, those needs to be added before super.create();
	//in substates, in fuction new at the last line add those

	//on Playstate.hx after all
	//obj.camera = ...
	//add
	addAndroidControls();

	//to make the controls visible the code is
	#if android
	androidc.visible = true;
	#end

	//to make the controls invisible the cose is
	#if android
	androidc.visible = false;
	#end
```

7. Prevent the Android BACK Button

in TitleState.hx

after
```haxe
	override public function create():Void
	{
```

add
```haxe
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
```

8. Set An action to the BACK Button

you can set one with
```haxe
		#if android FlxG.android.justReleased.BACK #end
```

9. sys.FileSystem and sys.io.File

this is not working in your game storage but on phone storage will work with this

```haxe
		SUtil.getPath() + 
```
this will make the game to use the phone storage
but you will have to add one thing in Your source

in Main.hx before 
```haxe
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
```

add 
```haxe
		SUtil.doTheCheck();
```
this will chack for android storage permisions and for the assets/mods directory

10. On Crash Application Alert

on project.xml add
```xml
	<!-- Akways enable Null Object Reference check -->
	<haxedef name="HXCPP_CHECK_POINTER" if="release" />
	<haxedef name="HXCPP_STACK_LINE" if="release" />
```

on Main.hx after
```haxe
 	public function new()
	{
		super();
```	
add
```haxe
 	SUtil.gameCrashCheck();
```	

11. Video Cutscenes

before those imports
on FlxVideo.hx after
```haxe
	#else
	import openfl.events.Event;
	import vlc.VlcBitmap;
	#end
```	
add
```haxe
	#elseif android
	import extension.webview.WebView;
	import android.AndroidTools;
```	

next, before those lines add
```haxe
	#elseif desktop
	// by Polybius, check out PolyEngine! https://github.com/polybiusproxy/PolyEngine
```	
add
```haxe
	#elseif android
	WebView.onClose = function(){
		trace("WebView has been closed!");
		if (finishCallback != null){
			finishCallback();
		}
	}
	WebView.onURLChanging = function(url:String){
		trace("WebView is about to open: " + url);
		if (url == 'http://exitme/'){
			if (finishCallback != null){
				finishCallback();
			}
		}
	}
	WebView.open(AndroidTools.getFileUrl(name), null, ['http://exitme/']);
```	
this will use .html file to play a video

to play a video in this format you need the html file, the video(recomanded .mp4) and a blank png

the html shoud be like this
```html
<html>
    <body style="background-color: black;">
        <video style="position: fixed; top: 0; left: 0; width: 100%; height: 100%;" audiobuffer="true" autoplay="true" poster="blank.png" preload="auto" id="player">
            <source src="video.mp4" type="video/mp4"></source>
        </video>
    </body>
</html>

<script type='text/javascript'>
    document.getElementById('player').addEventListener('ended', myHandler, false);
    function myHandler(e) {
        document.location.href='http://exitme/';
    }
</script>
```	

This will work only in you phone storage only!!

## Credits:
* Saw (M.A. JIGSAW) me - doing the rest code, utils and anoder things
* luckydog7 - original code for android controls
