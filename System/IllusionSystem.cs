using Godot;
using System;

namespace IllusionSystem
{
    [Tool]
    public partial class IllusionSystem : Node3D
    {
        private static IllusionSystem instance;

        [Export]
        public Camera3D mainCamera;
        [Export]
        public float outlineSize = 16f;
        [Export]
        public float outlineWobble = 0.5f;
        [Export]
        public float outlineSizeVariance = 3f;

        public override void _Process(double delta)
        {
            base._Process(delta);
            instance = this;
        }
        public static IllusionSystem GetInstance()
        {
            if (instance != null && (!IsInstanceValid(instance) || !instance.IsInsideTree()))
            {
                instance = null;
            }
            return instance;
        }
    }
}