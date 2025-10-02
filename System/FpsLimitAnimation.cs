using Godot;
using System;

namespace IllusionSystem
{
    [Tool]
    public partial class FpsLimitAnimation : Node
    {
        AnimationPlayer player;
        [Export]
        public int fps = 10;
        public override void _Ready()
        {
            base._Ready();
            player = (AnimationPlayer)GetParent();
            player.CallbackModeProcess = AnimationMixer.AnimationCallbackModeProcess.Manual;
        }
        double time;
        public override void _Process(double delta)
        {
            base._Process(delta);

            if (player == null)
            {
                player = (AnimationPlayer)GetParent();
                if (player != null) player.CallbackModeProcess = AnimationMixer.AnimationCallbackModeProcess.Manual;
                return;
            }

            double spf = 1d / fps;

            time += delta;
            while (time >= spf)
            {
                time -= spf;
                player.Advance(spf);
            }
        }
    }
}
