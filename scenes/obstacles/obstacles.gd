extends Area3D

var speed: int = 5
var direction: float

 
func _ready() -> void:
    global_position.y = -1.7
    global_position.z = GameManager.player.global_position.z - randf_range(40, 10)
    global_position.x = GameManager.player.global_position.x + randf_range(-40, 40)     
    scale = Vector3(randi_range(1, 1), randi_range(3, 3), randi_range(2, 2))
    for i in randf_range(0, 10):
        rotation.y = i
    
        scale = Vector3(randf_range(1, 1), randf_range(2, 2), randf_range(.7, .7))
    
func _physics_process(delta: float) -> void:
    position.z += speed * delta
    #look_at(GameManager.player.global_position, Vector3.UP)
    var dir = global_position -  GameManager.player.global_position
    rotation.y =  atan2(dir.x, dir.z)   
 
    
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
    queue_free()
