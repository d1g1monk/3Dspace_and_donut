extends Area3D

var speed: int = 5
var direction: Vector3
var can_move: bool = true
  

func _ready() -> void:
    GameManager.rock = self
    GameManager.rock_mesh = $meteor
    var unique_mat = $meteor.material_overlay.duplicate()
    $meteor.material_overlay = unique_mat
    global_position.z =  GameManager.player.global_position.z -30
    global_position.x = GameManager.player.global_position.x +  randf_range(-20, 20)
    scale = Vector3(randf_range(1, 2), randf_range(1, 2), randf_range(1, 2)) 
    
    
func _process(delta: float) -> void:
    if !can_move: return
    #direction = global_position - GameManager.player.global_position
    #position += speed * direction * delta 
    position.z += speed * delta 
    position.x += direction.x * delta 
    rotation += Vector3(1, 1, 0) * delta
    
    

func _on_body_entered(body: Node3D) -> void:
    if !(body == GameManager.player): return
    print("HIT")
    #get_tree().quit()    

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
    queue_free()
