extends Node3D

@onready var cube: MeshInstance3D = $World1/Cube
@onready var camera_3D: Camera3D = $CameraManager/Camera3D
@onready var donut: MeshInstance3D = $World1/Donut
@onready var fps_indi: Label = $Control/Label

var fireball_scene: PackedScene = preload("res://scenes/fireball/fireball.tscn")

var current_color: Color 
var spin_cube: Vector3
var spin_donut: float

func _ready() -> void:
    var get_current_color = donut.mesh.material.albedo_color
    current_color = get_current_color
    donut.material_override = donut.mesh.material.duplicate()
    print("current_color: " + str(current_color))
    print(cube.mesh.material)
    print(donut.mesh.material)
    color_transition()
    spin_cube = Vector3(3,3,3).normalized()
    spin_donut = 1
    
func _physics_process(delta: float) -> void:
    #camera_3d.rotate(Vector3(2, 2, 0).normalized(), delta)
    #cube.rotate(Vector3(3, 3, 3).normalized(), delta)
    #donut.rotate_y(1 * delta)      
    cube.rotate(spin_cube, delta)
    donut.rotate_y(spin_donut * delta)
  # 2. Convert 3D position to 2D screen position
    #var camera = get_viewport().get_camera_3d()
    #var screen_pos = camera.unproject_position(donut.global_position) 
    #fps_indi.global_position = screen_pos + Vector2(480, -320) # Offset so it floats above
    fps_indi.text = "FPS: " + str(Engine.get_frames_per_second())


func color_transition():
    var tween = create_tween().set_loops()  
    tween.tween_property(donut, "material_override:albedo_color", Color.RED,  2.5)
    tween.tween_property(donut, "material_override:albedo_color", current_color,  2.5).from(Color.RED)
    print("swapping from" + str(current_color)) 


func _on_player_shoot_fireball(muzzle_transform: Transform3D) -> void:
    var fireball = fireball_scene.instantiate() as Area3D
    fireball.global_transform = muzzle_transform
    $Projectiles.add_child(fireball)
