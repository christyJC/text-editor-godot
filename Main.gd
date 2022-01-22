extends Control

onready var tabs = $TabContainer
onready var file_editor =  preload("res://FileEditor.tscn")

func _ready():
	add_keybind_ctrl("new_tab", KEY_T)
	add_keybind_ctrl("close_tab",KEY_W)
	add_keybind_ctrl("next_tab",KEY_RIGHT)
	add_keybind_ctrl("prev_tab",KEY_LEFT)
	

func _process(_delta):
	if Input.is_action_just_pressed("new_tab"):
		new_tab(tabs)
	if Input.is_action_just_pressed("close_tab"):
		close_tab(tabs)
	if Input.is_action_just_pressed("next_tab"):
		next_tab(tabs)
	if Input.is_action_just_pressed("prev_tab"):
		prev_tab(tabs)

# adds input for Ctrl + key_code
func add_keybind_ctrl(action,key_code):
	InputMap.add_action(action)
	var event = InputEventKey.new()
	event.scancode = key_code
	event.control = true # require holding Ctrl
	InputMap.action_add_event(action,event)

	
# Tab control functions 
# add a TextEdit node to tab container
func new_tab(container):
	var editor_count = container.get_child_count()
	var new_editor = file_editor.instance()
	new_editor.name = "Untitled" + str(editor_count) # rename tab
	container.add_child(new_editor)
	container.current_tab = editor_count # set current tab to last tab
	new_editor.grab_focus() #put cursor in editor
	

# remove TextEdit node from tab container
# ask to save changes before closing
func close_tab(container):
	var curr_tab = container.current_tab
	var to_be_closed = container.get_child(curr_tab) # get the text editor to be closed
	to_be_closed.queue_free() # remove text editor
	# TODO: warn before closing if there is text

# cycle active TextEdit to the right
func next_tab(container):
	var curr_tab = container.current_tab
	var last_tab = container.get_tab_count() - 1
	
	if curr_tab == last_tab: # check for wrapping
		container.current_tab = 0
	else:
		container.current_tab = curr_tab + 1 # move right

# cycle active TextEdit to the left
func prev_tab(container):
	var first_tab = 0
	var curr_tab = container.current_tab
	var last_tab = container.get_tab_count() -1
	
	if curr_tab ==  first_tab: # check for wrapping
		container.current_tab = last_tab
	else:
		container.current_tab = curr_tab - 1 # move left

	
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

