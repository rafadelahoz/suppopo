package;

class Actor extends Entity
{
    var xRemainder : Float;
    var yRemainder : Float;

    public function new(X : Float, Y : Float, World : World)
    {
        super(X, Y, World);

        xRemainder = 0;
        yRemainder = 0;
    }

    override public function update(elapsed : Float)
    {
        super.update(elapsed);
    }

    public function moveX(amount : Float, ?callback : Void -> Void = null) : Void
    {
        xRemainder += amount;
        var move : Int = Std.int(xRemainder);

        if (move != 0)
        {
            xRemainder -= move;
            var delta : Int = sign(move);
            while (move != 0)
            {
                if (!overlapsAt(x + delta, y, world.solids))
                {
                    x += delta;
                    move -= delta;
                }
                else
                {
                    if (callback != null) {
                        callback();
                    }

                    break;
                }
            }
        }
    }

    public function moveY(amount : Float, ?callback : Void -> Void = null) : Void
    {
        yRemainder += amount;
        var move : Int = Std.int(yRemainder);

        if (move != 0)
        {
            yRemainder -= move;
            var delta : Int = sign(move);

            while (move != 0)
            {
                if (!overlapsAt(x, y + delta, world.solids))
                {
                    y += delta;
                    move -= delta;
                }
                else
                {
                    if (callback != null) {
                        callback();
                    }

                    break;
                }
            }
        }
    }

    private function sign(num : Int) : Int
    {
        if (num < 0)
            return -1;
        else if (num > 0)
            return 1;
        else
            return 0;
    }
}