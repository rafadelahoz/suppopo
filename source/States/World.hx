package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxBasic;
import flixel.group.FlxGroup;

class World extends FlxState
{
    public var platforms : FlxGroup;
    public var solids : FlxGroup;
    public var oneways : FlxGroup;

    override public function create() : Void
    {
        solids = new FlxGroup();
        add(solids);

        oneways = new FlxGroup();
        add(oneways);

        platforms = new FlxGroup();
        platforms.add(solids);
        platforms.add(oneways);

        solids.add(new Solid(0, 200-16, 320, 16, this));

        oneways.add(new Solid(112, 200-80, 64, 8, this));

        add(new Player(112, 16, this));

        trace(FlxG.updateFramerate);
        trace(FlxG.drawFramerate);

        super.create();
    }

    override public function update(elapsed : Float) : Void
    {
        if (FlxG.keys.pressed.SPACE)
        {
            beginSlowdown();
        }
        else
        {
            endSlowdown();
        }

        if (FlxG.mouse.justPressed)
        {
            var x : Int = Std.int(FlxG.mouse.x / 16) * 16;
            var y : Int = Std.int(FlxG.mouse.y / 16) * 16;

            if (FlxG.keys.pressed.ALT)
                oneways.add(new Solid(x, y, 16, 8, this));
            else
                solids.add(new Solid(x, y, 16, 16, this));
        }

        super.update(elapsed);
    }

    public function beginSlowdown() : Void
    {
        forEachAlive(function(entity : FlxBasic) {
            if (Std.is(entity, Entity))
            {
                cast(entity, Entity).beginSlowdown();
            }
        }, true);
    }

    public function endSlowdown() : Void
    {
        forEachAlive(function(entity : FlxBasic) {
            if (Std.is(entity, Entity))
            {
                cast(entity, Entity).endSlowdown();
            }
        }, true);
    }
}
