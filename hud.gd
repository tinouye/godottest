extends CanvasLayer

# Notifies `Main` node that the buton has been pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


# Show Game Over screen and then bring up main menu
# Shouldn't this be 2 functions???
func show_game_over():
	show_message("Game Over")
	# Wait until MessageTimer has counted down
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	# This just makes and waits for a timer, I guess
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
