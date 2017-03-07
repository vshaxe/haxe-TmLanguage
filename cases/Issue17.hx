enum Item {
    @:json({ type: 'sword' }) Sword(damage:{max:Int});
    @:json({ type: 'shield' }) Shield(shield:{armor:Int});
    @json("test") Staff(block:Float, ?magic:Int);
    Potion(effect:PotionEffect);
}