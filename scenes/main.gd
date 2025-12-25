extends Node3D

@onready var cube: MeshInstance3D = $Cube
@onready var camera_3d: Camera3D = $Camera3D
@onready var donut: MeshInstance3D = $Donut
var current_color: Color
@onready var fps_indi: Control = $Control/Label
 
 

func _ready() -> void:
    print(cube.mesh.material)
    print($Donut.mesh.material)
    var get_current_color = donut.mesh.material.albedo_color
    current_color = get_current_color
    print("current_color: " + str(current_color))
    donut.material_override = donut.mesh.material.duplicate()
    color_transition()
    
func _physics_process(delta: float) -> void:
    #camera_3d.rotate(Vector3(2, 2, 0).normalized(), delta)
    cube.rotate(Vector3(3, 3, 3).normalized(), delta)
    donut.rotate_y(1 * delta)      
  # 2. Convert 3D position to 2D screen position
    var camera = get_viewport().get_camera_3d()
    var screen_pos = camera.unproject_position(donut.global_position) 
    fps_indi.global_position = screen_pos + Vector2(480, -320) # Offset so it floats above
    fps_indi.text = "FPS: " + str(Engine.get_frames_per_second())
     


 
func color_transition():
    var tween = create_tween().set_loops()  
    tween.tween_property(donut, "material_override:albedo_color", Color.RED,  2.5)
    tween.tween_property(donut, "material_override:albedo_color", current_color,  2.5).from(Color.RED)
    print("swapping from" + str(current_color)) 
