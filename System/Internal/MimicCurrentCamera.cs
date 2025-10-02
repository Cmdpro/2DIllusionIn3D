using Godot;
using System;

namespace IllusionSystem.Internal
{
    [Tool]
    public partial class MimicCurrentCamera : Camera3D
    {
        public override void _Process(double delta)
        {
            base._Process(delta);
            IllusionSystem illusionSystem = IllusionSystem.GetInstance();
            if (illusionSystem != null)
            {
                Camera3D mimicing = illusionSystem.mainCamera;
                if (mimicing != null)
                {
                    GlobalPosition = mimicing.GlobalPosition;
                    GlobalRotation = mimicing.GlobalRotation;
                    Scale = mimicing.Scale;
                    Fov = mimicing.Fov;
                    Near = mimicing.Near;
                    Far = mimicing.Far;
                    HOffset = mimicing.HOffset;
                    VOffset = mimicing.VOffset;
                    Size = mimicing.Size;
                }
            }
        }
    }
}