extends Control

onready var tabs = $TabContainer
onready var file_editor =  preload("res://FileEditor.tscn")
onready var file_script = preload("res://FileEditor.gd")

onready var c_source_icon = preload("res://c_file.png")
onready var c_header_icon = preload("res://c_header.png")
onready var java_icon = preload("res://java_file.png")
onready var python_icon = preload("res://python_file.png")


func _ready():
	add_keybind_ctrl("new_tab", KEY_T)
	add_keybind_ctrl("close_tab",KEY_W)
	add_keybind_ctrl("next_tab",KEY_RIGHT)
	add_keybind_ctrl("prev_tab",KEY_LEFT)
	add_keybind_ctrl("open_file",KEY_O)
	

func _process(_delta):
	if Input.is_action_just_pressed("new_tab"):
		new_tab(tabs)
	if Input.is_action_just_pressed("close_tab"):
		close_tab(tabs)
	if Input.is_action_just_pressed("next_tab"):
		next_tab(tabs)
	if Input.is_action_just_pressed("prev_tab"):
		prev_tab(tabs)
		
	if Input.is_action_just_pressed("open_file"):
		open_file()

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
	if tabs_exist(container):
		var curr_tab = container.current_tab
		var to_be_closed = container.get_child(curr_tab) # get the text editor to be closed
		to_be_closed.queue_free() # remove text editor
		# TODO: warn before closing if there is text

# cycle active TextEdit to the right
func next_tab(container):
	if tabs_exist(container):
		var curr_tab = container.current_tab
		var last_tab = container.get_tab_count() - 1
		
		if curr_tab == last_tab: # check for wrapping
			container.current_tab = 0
		else:
			container.current_tab = curr_tab + 1 # move right

# cycle active TextEdit to the left
func prev_tab(container):
	if tabs_exist(container):
		var first_tab = 0
		var curr_tab = container.current_tab
		var last_tab = container.get_tab_count() -1
		
		if curr_tab ==  first_tab: # check for wrapping
			container.current_tab = last_tab
		else:
			container.current_tab = curr_tab - 1 # move left

# check that at least one tab exists
func tabs_exist(container):
	if container.get_tab_count() > 0:
		return true
	else:
		return false 

# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	$OpenDialog.popup()

func _on_OpenDialog_file_selected(path):
	var file = File.new()
	file.open(path,1) # open file at path in read only mode
	
	# get the current editor 
	var curr_id = tabs.current_tab 
	var curr_editor = tabs.get_child(curr_id)
	# put the file contents in the current TextEdit
	curr_editor.text = file.get_as_text()
	file.close()
	
	var file_name = path.get_file() # get file name (words.txt)
	var file_ext = file_name.get_extension() # get extension (.txt)
	var file_no_dots = file_name.replace(".","_")
	#string replace(what,forwhat)
	set_highlight(file_ext,curr_editor) # set syntac highlighting base on extension
	curr_editor.name = file_no_dots # rename file editor to name of file
	set_file_icon(file_ext,tabs,curr_id)

	#TODO fix 

func set_highlight(extension,editor):
	match extension:
		"c":
			editor.c_default()
		"h":
			editor.c_default()
			
		"java":
			editor.java_default()
		"py":
			editor.python_default()

func set_file_icon(extension,container,tab_id):
	match extension:
		"c":
			container.set_tab_icon(tab_id,c_source_icon)
		"h":
			container.set_tab_icon(tab_id,c_header_icon)
			
		"java":
			container.set_tab_icon(tab_id,java_icon)
		"py":
			container.set_tab_icon(tab_id,python_icon)
	
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


