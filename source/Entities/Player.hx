package;

import flixel.FlxG;

class Player extends Actor
{
    var HorizontalSpeed : Float = 2.5;
    var HorizontalAirFactor : Float = 0.7;
    var VerticalSpeed : Float = 6.6;
    var JumpReleaseSlowdownFactor : Float = 0.256;
    var Gravity : Float = 0.35;
    var MaxVspeed : Float = 25;

    var HorizontalAccel : Float = 0.3;
    var Friction : Float = 0.6;

    var sOnAir : Bool;

    var hspeed : Float;
    var vspeed : Float;

    var haccel : Float;

    public function new(X : Float, Y : Float, World : World) {
        super(X, Y, World);

        makeGraphic(16, 16, 0xFFFFFFFF);

        hspeed = 0;
        vspeed = 0;

        haccel = 0;

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
            haccel = -HorizontalAccel * (sOnAir ? HorizontalAirFactor : 1);
        } else if (Gamepad.right()) {
            haccel = HorizontalAccel * (sOnAir ? HorizontalAirFactor : 1);
        } else {
            haccel = 0;
        }

        if (!sOnAir && Gamepad.justPressed(Gamepad.A))
        {
            vspeed = -VerticalSpeed;
        }
        else if (sOnAir && vspeed < 0 && Gamepad.justReleased(Gamepad.A))
        {
            vspeed *= JumpReleaseSlowdownFactor;
        }

        hspeed += haccel;
        if (Math.abs(hspeed) > HorizontalSpeed)
        {
            hspeed = MathUtil.sign(hspeed) * HorizontalSpeed;
        }

        moveX(hspeed, onHorizontalCollision);
        moveY(vspeed, onVerticalCollision);

        // Handle friction
        if (haccel == 0)
        {
            hspeed *= Friction;
        }

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

    function onHorizontalCollision() : Void
    {
        hspeed = 0;
        haccel = 0;
    }

    function onVerticalCollision() : Void
    {
        vspeed = 0;
    }
}
