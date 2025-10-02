using Godot;
using System;

namespace IllusionSystem.Internal
{
    [Tool]
    public partial class ResizeWithCamera : Node3D
    {
        [Export]
        public Camera3D camera;
        public override void _Process(double delta)
        {
            base._Process(delta);
            if (camera != null)
            {
                Scale = new Vector3(camera.Size, camera.Size, camera.Size);
            }
        }
    }
}
