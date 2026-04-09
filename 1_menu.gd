extends CanvasLayer


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://map.tscn")


func _on_controls_button_pressed():
	%Panel.show()
	%VBoxContainer.hide()

func _on_exit_button_2_pressed() -> void:
	%Panel.hide()
	%VBoxContainer.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
