extends Control

onready var tabs = $TabContainer
onready var file_editor =  preload("res://FileEditor.tscn")
onready var active_editor_id = 0

func _ready():
	add_keybind("new_tab", KEY_T)
	

func _process(_delta):
	if Input.is_action_just_pressed("new_tab"):
		new_tab()

	
	
func add_keybind(action,key_code):
	InputMap.add_action(action)
	var event = InputEventKey.new()
	event.scancode = key_code
	event.control = true
	InputMap.action_add_event(action,event)

	
# Tab control functions 
# add a TextEdit node to tab container
func new_tab():
	var editor_count = tabs.get_child_count()
	var new_editor = file_editor.instance()
	new_editor.name = "Untitled" + str(editor_count)
	tabs.add_child(new_editor)
	tabs.current_tab = editor_count
	new_editor.grab_focus()
	

# remove TextEdit node from tab container
# ask to save changes before closing
func close_tab():
	pass

# cycle active TextEdit to the right
func next_tab():
	pass

# cycle active TextEdit to the left
func prev_tab():
	pass
	
# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	pass

# save changes to current file
func save_file():
	pass


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


func _on_TabContainer_tab_selected(tab):
	active_editor_id = tab
