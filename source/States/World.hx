package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxBasic;
import flixel.group.FlxGroup;

class World extends FlxState
{
    public var solids : FlxGroup;

    override public function create() : Void
    {
        // Do things
        solids = new FlxGroup();
        add(solids);

        solids.add(new Solid(0, 200-16, 320, 16, this));

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
