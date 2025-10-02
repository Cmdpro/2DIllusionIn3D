using Godot;
using System;

public partial class MoveCamera : Camera3D
{
    Vector3 StartPosition;
    float StartSize;
    public override void _Ready()
    {
        base._Ready();
        StartPosition = GlobalPosition;
        StartSize = Size;
    }
    public override void _Process(double delta)
    {
        base._Process(delta);
        float speed = 5;
        if (Input.IsKeyPressed(Key.A))
        {
            GlobalPosition -= GlobalTransform.Basis.X * (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.D))
        {
            GlobalPosition += GlobalTransform.Basis.X * (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.S))
        {
            GlobalPosition -= GlobalTransform.Basis.Y * (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.W))
        {
            GlobalPosition += GlobalTransform.Basis.Y * (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.Q))
        {
            Size -= (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.E))
        {
            Size += (float)delta * speed;
        }
        if (Input.IsKeyPressed(Key.Left))
        {
            GlobalRotationDegrees += new Vector3(0, 45 * (float)delta, 0);
        }
        if (Input.IsKeyPressed(Key.Right))
        {
            GlobalRotationDegrees -= new Vector3(0, 45 * (float)delta, 0);
        }
        if (Input.IsKeyPressed(Key.Shift))
        {
            GlobalRotationDegrees = new Vector3(0, 0, 0);
            GlobalPosition = new Vector3(GlobalPosition.X, GlobalPosition.Y, StartPosition.Z);
            Size = StartSize;
        }
    }
}
