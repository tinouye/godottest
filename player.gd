extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# hide()

func start(start_pos):
	position = start_pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Handle inputs and determine vector direction
	var velocity = Vector2.ZERO # Player movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# Normalize vector magnitude to player speed and set animation play
	if velocity.length()> 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	# Update position based on velocity vector
	# I guess position is declared in the parent class?
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Change animation depending on movement direction
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = true if velocity.x < 0 else false
		
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		


func _on_body_entered(body):
	hide() # Player disappears
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
