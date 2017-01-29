enum Color<T1, T2> {
    Red;
    Green;
    Blue;
    Grey( v : T1 );
    Rgb( r : Int, g : T1, ?b : T2 = null );
    ALPHA( a : Int, col : Color );
}