extends FileDialog

onready var c_source_icon = preload("res://c_file.png")
onready var c_header_icon = preload("res://c_header.png")
onready var java_icon = preload("res://java_file.png")
onready var python_icon = preload("res://python_file.png")

func _ready():
	pass

# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	$OpenDialog.popup()

func _on_OpenDialog_file_selected(path):
	var file = File.new()
	file.open(path,File.READ) # open file at path in read only mode
	var tabs2 = get_node("TabContainer")

	# get the current editor 
	if tabs2.get_child_count() > 0:
		var curr_id = tabs2.current_tab 
		var curr_editor = tabs2.get_child(curr_id)
		# put the file contents in the current TextEdit
		curr_editor.text = file.get_as_text()
		file.close()
		
		var file_name = path.get_file() # get file name (words.txt)
		var file_ext = file_name.get_extension() # get extension (.txt)

		set_highlight(file_ext,curr_editor) # set syntax highlighting base on extension
		set_tab_name(path,curr_editor)
		set_file_icon(file_ext,tabs2,curr_id)
	else:
		print("need at least 1 tab")
	
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
	
