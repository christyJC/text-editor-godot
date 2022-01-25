extends Control

onready var tabs = $TabContainer
onready var file_editor =  preload("res://FileEditor.tscn")
onready var file_script = preload("res://FileEditor.gd")

onready var editor_container = preload("res://EditorContainer.tscn")
onready var tab_control = preload("res://tab_control.gd")
onready var tab_container = editor_container.instance()

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
	add_keybind_ctrl("save_file",KEY_S)
	

func _process(_delta):
	if Input.is_action_just_pressed("new_tab"):
		tab_container.new_tab(tabs,file_editor.instance())
	if Input.is_action_just_pressed("close_tab"):
		tab_container.close_tab(tabs)
	if Input.is_action_just_pressed("next_tab"):
		tab_container.next_tab(tabs)
	if Input.is_action_just_pressed("prev_tab"):
		tab_container.prev_tab(tabs)
		
	if Input.is_action_just_pressed("open_file"):
		open_file()
	if Input.is_action_just_pressed("save_file"):
		save_file(tabs)

# adds input for Ctrl + key_code
func add_keybind_ctrl(action,key_code):
	InputMap.add_action(action)
	var event = InputEventKey.new()
	event.scancode = key_code
	event.control = true # require holding Ctrl
	InputMap.action_add_event(action,event)

	


# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	$OpenDialog.popup()

func _on_OpenDialog_file_selected(path):
	var file = File.new()
	file.open(path,File.READ) # open file at path in read only mode
	
	# get the current editor 
	var curr_id = tabs.current_tab 
	var curr_editor = tabs.get_child(curr_id)
	# put the file contents in the current TextEdit
	curr_editor.text = file.get_as_text()
	file.close()
	
	var file_name = path.get_file() # get file name (words.txt)
	var file_ext = file_name.get_extension() # get extension (.txt)

	set_highlight(file_ext,curr_editor) # set syntax highlighting base on extension
	set_tab_name(path,curr_editor)
	set_file_icon(file_ext,tabs,curr_id)
	
func set_tab_name(path,editor):
	var file_name = path.get_file() # get file name (words.txt)
	var file_no_dots = file_name.replace(".","_")
	editor.name = file_no_dots
	

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
func save_file(container):
	var curr_id = container.current_tab 
	var curr_editor = container.get_child(curr_id)
	var curr_path = curr_editor.get_file_path()
	if curr_path == "":
		$SaveDialog.popup()

	else:
		save_contents(curr_path,curr_editor)

# overwrite the contents of the current file
func save_contents(path,editor):
	var file = File.new()
	var file_contents = editor.text
	print(editor.get_file_path())
	file.open(path,File.WRITE)
	file.store_string(file_contents)
	file.close()

# this runs when trying to save with no path selected
func _on_SaveDialog_file_selected(path):
	var curr_id = tabs.current_tab 
	var curr_editor = tabs.get_child(curr_id)
	curr_editor.set_file_path(path)
	set_tab_name(path,curr_editor)
	save_contents(path,curr_editor)

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




