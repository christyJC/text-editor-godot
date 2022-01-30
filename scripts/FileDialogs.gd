extends Control

onready var c_source_icon = preload("res://icons/c_file.png")
onready var c_header_icon = preload("res://icons/c_header.png")
onready var java_icon = preload("res://icons/java_file.png")
onready var python_icon = preload("res://icons/python_file.png")

func _ready():
	pass

func get_tab_container():
	return $"../TabContainer"

# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	$OpenDialog.popup()

func _on_OpenDialog_file_selected(path):
	var file = File.new()
	file.open(path,File.READ) # open file at path in read only mode
	var tabs = get_tab_container()
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
	editor.set_file_path(file_name)
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
func save_file():
	var tabs = get_tab_container()
	var curr_id = tabs.current_tab 
	var curr_editor = tabs.get_child(curr_id)
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
	var tabs = get_tab_container()
	var curr_id = tabs.current_tab 
	var curr_editor = tabs.get_child(curr_id)
	curr_editor.set_file_path(path)
	set_tab_name(path,curr_editor)
	save_contents(path,curr_editor)
