extends Area3D

var speed: int = 15
var belongs_to

func _ready() -> void:
    GameManager.fireball = self
    
func _physics_process(delta: float) -> void:
        position.z -= speed * delta
        if global_position.distance_squared_to(GameManager.player.global_position) > 2500:
            queue_free()              
    

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
    queue_free()
