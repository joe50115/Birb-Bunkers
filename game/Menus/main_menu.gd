extends Control

const PLAYER_SELECT_PATH: String = "res://game/Menus/player_select.tscn"
const SETTINGS_MENU_PATH: String = "res://game/Menus/settings_menu.tscn"
const SPLASH_SCREEN_PATH: String = "res://game/Menus/splash_screen.tscn"


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(PLAYER_SELECT_PATH)


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file(SETTINGS_MENU_PATH)


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file(SPLASH_SCREEN_PATH)

@onready var first_button: Button =  $CenterContainer/VBoxContainer/PlayButton

func _ready() -> void:
	first_button.grab_focus.call_deferred()
