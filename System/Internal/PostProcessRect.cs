using Godot;
using System;

namespace IllusionSystem.Internal
{
    [Tool]
    public partial class PostProcessRect : ColorRect
    {
        public override void _Process(double delta)
        {
            base._Process(delta);
            IllusionSystem system = IllusionSystem.GetInstance();
            if (system != null && system.mainCamera != null) 
            {
                if (Material is ShaderMaterial material)
                {
                    material.SetShaderParameter("camera_size", system.mainCamera.Size);
                    material.SetShaderParameter("outline_size", system.outlineSize);
                }
            }
        }
    }
}