# FNF-Porting-Stuff
The Things im using when i port a mod to android

# This methot is focused for psych engine mods ports so if you want to port anoder mods with it you have to moddfy some code

## Installation:

1. You Need to install AndroidTools And Extensioon-Webview

To Install Them You Need To Open Command prompt/PowerShell And To Tipe
```cmd
haxelib git AndroidTools https://github.com/jigsaw-4277821/AndroidTools.git

haxelib git extension-webview https://github.com/jigsaw-4277821/extension-webview.git

```

2. Download the repository code and paste it in your source code folder

3. You Need to add in project.xml those thing

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

before those lines add
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

5. comeing soon :)