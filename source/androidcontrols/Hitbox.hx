package androidcontrols;

import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Hitbox extends FlxSpriteGroup
{
	var sizex:Float = 320;
	var alphaTween:FlxTween = null;
		
	public var hitbox:FlxSpriteGroup;
	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	
	public function new()
	{
		super();

		var hitbox_hint:FlxSprite = new FlxSprite().loadGraphic(Paths.image('androidcontrols/hitbox_hint'));
		hitbox_hint.alpha = 0.4;
		add(hitbox_hint);

		hitbox = new FlxSpriteGroup();
		hitbox.add(add(buttonLeft = createhitbox(0, "left")));
		hitbox.add(add(buttonDown = createhitbox(sizex, "down")));
		hitbox.add(add(buttonUp = createhitbox(sizex * 2, "up")));
		hitbox.add(add(buttonRight = createhitbox(sizex * 3, "right")));
	}

	public function createhitbox(buttonPozitionX:Float, framestring:String) {
		var frames = Paths.getSparrowAtlas('androidcontrols/hitbox');
        var graphic:FlxGraphic = FlxGraphic.fromFrame(frames.getByName(framestring));

		var button = new FlxButton(buttonPozitionX, 0);
        button.loadGraphic(graphic);
        button.alpha = 0;

		button.onDown.callback = function (){
			if (alphaTween != null)
				alphaTween.cancel();

			alphaTween = FlxTween.num(button.alpha, 0.75, 0.075, {ease:FlxEase.circInOut}, function(a:Float) { 
				button.alpha = a; 
			});
		};

		button.onUp.callback = function (){
			if (alphaTween != null)
				alphaTween.cancel();

			alphaTween = FlxTween.num(button.alpha, 0, 0.15, {ease:FlxEase.circInOut}, function(a:Float) {
				button.alpha = a; 
			});
		}
		
		button.onOut.callback = function (){
			if (alphaTween != null)
				alphaTween.cancel();

			alphaTween = FlxTween.num(button.alpha, 0, 0.15, {ease:FlxEase.circInOut}, function(a:Float) { 
				button.alpha = a; 
			});
		}

        return button;
	}

	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}
