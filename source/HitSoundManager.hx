package;

import flixel.FlxG;
#if (flixel >= "5.3.0")
import flixel.sound.FlxSound;
#else
import flixel.system.FlxSound;
#end

class HitSoundManager
{
	public static var noteHit:Bool = false;

	public static var snap:FlxSound;
	public static var perfect:FlxSound;
	public static var great:FlxSound;
	public static var good:FlxSound;
	public static var tap:FlxSound;

	public static function init():Void
	{
		// não precisa do precache
		// no paths.sound dos sons ali embaixo já carrega e funfa certinho pra gameplay.
		snap = null;
		perfect = null;
		great = null;
		good = null;
		tap = null;

		if(SaveData.hitSound) {
			snap = new FlxSound().loadEmbedded(Paths.sound('hitsound/snap'));
			snap.volume = SaveData.hitSoundVolume;

			FlxG.sound.list.add(snap);
		}

		if(SaveData.judgeHitSound) {
			perfect = new FlxSound().loadEmbedded(Paths.sound('hitsound/perfect'));
			perfect.volume = SaveData.hitSoundVolume;
			perfect.onComplete = function():Void
			{
				noteHit = false;
			};

			great = new FlxSound().loadEmbedded(Paths.sound('hitsound/great'));
			great.volume = SaveData.hitSoundVolume;
			great.onComplete = function():Void
			{
				noteHit = false;
			};

			good = new FlxSound().loadEmbedded(Paths.sound('hitsound/good'));
			good.volume = SaveData.hitSoundVolume;
			good.onComplete = function():Void
			{
				noteHit = false;
			};

			tap = new FlxSound().loadEmbedded(Paths.sound('hitsound/tap'));
			tap.volume = SaveData.hitSoundVolume;

			FlxG.sound.list.add(perfect);
			FlxG.sound.list.add(great);
			FlxG.sound.list.add(good);
			FlxG.sound.list.add(tap);
		}
	}

	public static function play(rating:String = 'ghost'):Void
	{
		var sfx:FlxSound;

		if (SaveData.judgeHitSound)
		{
			noteHit = true;

			switch (rating)
			{
				case 'sick':
					sfx = perfect;
				case 'good':
					sfx = great;
				case 'bad':
					sfx = good;
				default:
					sfx = tap;
					noteHit = false;
			}
		}
		else
			sfx = snap;

		if (sfx.playing) sfx.stop();
		sfx.play();
	}
}
