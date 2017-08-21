package;

import flixel.FlxState;

class World extends FlxState
{
    override public function create() : Void
    {
        // Do things

        add(new Entity(100, 100, this));

        super.create();
    }

    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
    }
}
