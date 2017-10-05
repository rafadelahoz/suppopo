package;

class Solid extends Entity
{
    public function new(X : Float, Y : Float, Width : Float, Height : Float, World : World)
    {
        super(X, Y, World);

        makeGraphic(Std.int(Width), Std.int(Height), 0xFFFF0a00);
    }
}
