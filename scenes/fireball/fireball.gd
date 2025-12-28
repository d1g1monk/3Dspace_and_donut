extends Area3D

var speed: int = 15
var belongs_to
var can_move: bool = true
#var time_is_up: bool = false

func _ready() -> void:
    GameManager.fireball = self

         
func _physics_process(delta: float) -> void:
    if !can_move: return
    position.z -= speed * delta
    if global_position.distance_squared_to(GameManager.player.global_position) > 2500:
        queue_free()              
    

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
    queue_free()
 


func _on_area_entered(area: Area3D) -> void:
   
    if !(area.is_in_group("Rocks")): return
    can_move = false
    area.can_move = false
    print("Rock fire collide")
    area.get_node("meteor").material_overlay.set_shader_parameter("progress", 1.0)    
    await get_tree().create_timer(0.4).timeout
    queue_free()
    if !is_instance_valid(area):  return
    area.queue_free()
       
