extends Control

const MAIN_MENU_PATH: String = "res://game/Menus/main_menu.tscn"

func _on_back_player_select_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)

@onready var first_button: Button =  $CenterContainer/BackPlayerSelect

func _ready() -> void:
	first_button.grab_focus.call_deferred()
