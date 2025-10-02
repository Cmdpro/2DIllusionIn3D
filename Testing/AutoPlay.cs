using Godot;
using System;

[Tool]
public partial class AutoPlay : AnimationPlayer
{
    [Export]
    public string Animation;
    public override void _Ready()
    {
        base._Ready();
        Play(Animation);
    }
}
