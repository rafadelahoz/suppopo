package;

import flixel.FlxG;

class Player extends Actor
{
    var HorizontalSpeed : Float = 2.5;
    var HorizontalAirFactor : Float = 0.7;
    var VerticalSpeed : Float = 6.6;
    var Gravity : Float = 0.35;
    var MaxVspeed : Float = 25;

    var sOnAir : Bool;

    var hspeed : Float;
    var vspeed : Float;

    public function new(X : Float, Y : Float, World : World) {
        super(X, Y, World);

        makeGraphic(16, 16, 0xFFFFFFFF);

        hspeed = 0;
        vspeed = 0;

        FlxG.watch.add(this, "hspeed");
        FlxG.watch.add(this, "vspeed");
        FlxG.watch.add(this, "xRemainder");
        FlxG.watch.add(this, "yRemainder");
    }

    override public function update(elapsed : Float) : Void
    {
        sOnAir = !overlapsAt(x, y+1, world.solids);

        if (sOnAir) {
            vspeed += Gravity;
        } else {
            vspeed = 0;
        }

        if (Gamepad.left()) {
            hspeed = -HorizontalSpeed;
        } else if (Gamepad.right()) {
            hspeed = HorizontalSpeed;
        } else {
            hspeed = 0;
        }

        if (!sOnAir && Gamepad.pressed(Gamepad.A))
        {
            vspeed = -VerticalSpeed;
        }
        else if (sOnAir && Gamepad.justReleased(Gamepad.A))
        {
            vspeed *= 0.256;
        }

        moveX(hspeed);
        moveY(vspeed, onVerticalCollision);

        hspeed = 0;

        if (vspeed > MaxVspeed)
        {
            vspeed = MaxVspeed;
        }

        // Debug zone
        if (sOnAir)
            color = 0xFF0aFF00;
        else
            color = 0xFFFFFFFF;

        super.update(elapsed);
    }

    function onVerticalCollision() : Void
    {
        vspeed = 0;
    }
}
