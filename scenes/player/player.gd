extends CharacterBody3D


var speed: int = 6
var direction: float
signal shoot_fireball(muzzle_transform: Transform3D)
 
func _ready() -> void:
    GameManager.player = self
    
func _physics_process(delta: float) -> void:
    velocity.x = speed * direction
    $craft_speederA.rotation.z = move_toward($craft_speederA.rotation.z, -direction, delta)    
    velocity.y = sin(Time.get_ticks_msec() / 500.0) / 4.0 + sin(Time.get_ticks_msec() / 600.0) / 10.0
    get_input()
    move_and_slide() 
    
func get_input():
    direction = Input.get_axis("left", "right")   
    if Input.is_action_pressed("forward"):
        velocity.z = -speed
    if Input.is_action_just_pressed("backwards"):
        velocity.z = speed
    if Input.is_action_just_pressed("shoot"):
         shoot_fireball.emit($Muzzle.global_transform)
       
        
