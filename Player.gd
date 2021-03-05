extends KinematicBody

const SPEED = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


remote func _set_pos(position):
	global_transform.origin = position


func _physics_process(delta):
	var moving_vec = Vector3()
	if Input.is_action_pressed("forwards"):
		moving_vec.z += 1
	if Input.is_action_pressed("backwards"):
		moving_vec.z -= 1
	if Input.is_action_pressed("right"):
		moving_vec.x -= 1
	if Input.is_action_pressed("left"):
		moving_vec.x += 1
	
	moving_vec = moving_vec.normalized()
	moving_vec *= SPEED
	if is_network_master():
		move_and_slide(moving_vec, Vector3.UP)
		rpc_unreliable("_set_pos", global_transform.origin)
	
