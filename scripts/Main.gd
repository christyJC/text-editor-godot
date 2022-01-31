extends Control

onready var tabs = $TabContainer
onready var file_io = $FileDialogs
onready var file_editor =  preload("res://scenes/FileEditor.tscn")
onready var editor_text= preload("res://scripts/EditorText.gd")

func _ready():
	add_keybind_ctrl("new_tab", KEY_T)
	add_keybind_ctrl("close_tab",KEY_W)
	add_keybind_ctrl("next_tab",KEY_RIGHT)
	add_keybind_ctrl("prev_tab",KEY_LEFT)
	add_keybind_ctrl("open_file",KEY_O)
	add_keybind_ctrl("save_file",KEY_S)
	
func _input(event):
	if event.is_action_pressed("new_tab"):
		tabs.new_tab(file_editor.instance())
		
	if event.is_action_pressed("close_tab"):
		tabs.close_tab()
	if event.is_action_pressed("next_tab"):
		tabs.next_tab()
	if event.is_action_pressed("prev_tab"):
		tabs.prev_tab()
		
	if event.is_action_pressed("open_file"):
		file_io.open_file()
	if event.is_action_pressed("save_file"):
		file_io.save_file()
	if event.is_action_pressed("snippet"): # added from input map in project settings
		var curr_editor = tabs.get_child(tabs.current_tab)
		editor_text.snippet(curr_editor)
		
	
# adds input for Ctrl + key_code
func add_keybind_ctrl(action,key_code):
	InputMap.add_action(action)
	var event = InputEventKey.new()
	event.scancode = key_code
	event.control = true # require holding Ctrl
	InputMap.action_add_event(action,event)

# Preferences menu 
# open a preferences menu
func pref_menu():
	pass

# save updated preferences
func pref_save():
	pass

# restore preferences to defaults 
func pref_restore():
	pass




