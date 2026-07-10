extends Control

const MAIN_MENU_PATH: String = "res://game/Menus/main_menu.tscn"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		get_tree().change_scene_to_file(MAIN_MENU_PATH)
