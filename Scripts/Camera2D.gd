extends Camera2D

const MAX_SPEED = 600
const ACCELERATION = 2000
const FRICTION = 3000

@export var speed: int

var movement: Vector2
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	movement = Vector2.ZERO
	velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	camera_movement(delta)

func get_input():
	movement.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	movement.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))

	movement = movement.normalized()

func camera_movement(delta):
	get_input()
	
	if movement == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (movement * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)

	move(delta)

func move(delta):
	position = position + velocity * delta
