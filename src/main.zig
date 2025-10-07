const std = @import("std");
const zrox_game = @import("zrox_game");
const rl = @cImport({
    @cInclude("raylib.h");
    // @cInclude("raymath.h");
    // @cInclude("rcamera.h");
});

pub fn main() !void {
    const screenWidth = 500;
    const screenHeigth = 500;
    var currentFps: c_int = 60;

    rl.InitWindow(screenWidth, screenHeigth, "zRoxGame");
    defer {
        rl.CloseWindow();
    }

    rl.SetTargetFPS(currentFps);

    var deltaCircle: rl.Vector2 = .{ .x = 0, .y = screenHeigth / @as(f32, 3.0) };
    var frameCircle: rl.Vector2 = .{ .x = 0, .y = screenHeigth / @as(f32, (2.0 / 3.0)) };

    const speed: comptime_float = 10.0;
    const circleRadius: comptime_int = 32.0;

    while (!rl.WindowShouldClose()) {
        //Update
        const mouseWheel = rl.GetMouseWheelMove();
        if (mouseWheel != 0) {
            const new_fps: c_int = @intFromFloat(mouseWheel);
            currentFps += new_fps;
            if (currentFps < 0) currentFps = 0;
            rl.SetTargetFPS(currentFps);
        }

        deltaCircle.x += rl.GetFrameTime() * 6.0 * speed;
        frameCircle.x += 9.9 * speed;

        //Draw
        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.DrawCircleV(deltaCircle, circleRadius, rl.RED);
        rl.DrawCircleV(frameCircle, circleRadius, rl.BLUE);

        rl.ClearBackground(rl.WHITE);
    }
}
