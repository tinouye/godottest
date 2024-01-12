extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	get_tree().call_group("mobs", "queue_free")
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Creates a vector 90 degrees clockwise of MobSpawnLocation's heading
	var direction = mob_spawn_location.rotation + PI/2
	
	# Set the mob's position to the current location of MobSpawnLocation
	mob.position = mob_spawn_location.position
	
	# Modify the vector by +- 45 degrees
	direction += randf_range(-PI/4, PI/4)
	
	# Set velocity between 150 and 250
	# Vector is initially in the X direction (aka 0 degrees) 
	# but is rotated to direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
