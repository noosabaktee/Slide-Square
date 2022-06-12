extends Node2D


var fileName = "user://save_game.save"

func _init():
	OS.is_userfs_persistent()
	var file = File.new()
	if !file.file_exists(fileName):
		file.open(fileName, File.WRITE)
		var content = {
			"best_score": "0",
			"last_score": "0"
		}
		file.store_var(content)
	file.close()
	

func _ready():
	if $"/root/Vars".first == true:	
		get_tree().paused = true
		$UI/ButtonPlay.show()
	else:
		$UI/ButtonPlay.hide()


func _on_ButtonGameOver_button_down():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_ButtonPlay_button_down():
	$"/root/Vars".first = false
	$UI/ButtonPlay.hide()
	get_tree().paused = false
