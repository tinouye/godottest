extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all animation names into an array
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# Choose an entry from the mob_types array above
	var animation_to_play = mob_types[randi_range(0,mob_types.size()-1)]
	# Play the chosen animation
	$AnimatedSprite2D.play(animation_to_play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
