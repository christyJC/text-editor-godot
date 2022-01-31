extends TextEdit


static func snippet(editor,ext):
		var curr_col = editor.cursor_get_column()
		var curr_row = editor.cursor_get_line()
		
		editor.cursor_set_column(curr_col-1)
		var word = editor.get_word_under_cursor()
		var output = ""
		print(ext)
		
		if ext == "c":
			output = _c_snippets(word)
		if ext == "java":
			output = _java_snippets(word)
		if ext == "py":
			output = _python_snippets(word)
			
			
		if output != "":
			var length = word.length()
			editor.select(curr_row,curr_col-length,curr_row,curr_col)
			editor.insert_text_at_cursor(output)
		else:
			editor.cursor_set_column(curr_col)
			

static func _c_snippets(word):
	var result = ""
	match word:
		"main":
			result = "int main(int argc, char *argv[]){\n\n}"
		"inc":
			result = "#include "
		"if":
			result = "if(){\n\n}"
		"elif":
			result = "else if(){\n\n}"
		"el":
			result = "else{\n\n}"
		"for":
			result = "for(;;){\n\n}"
		"while":
			result = "while(){\n\n}"
	return result
	
static func _java_snippets(word):
	pass
static func _python_snippets(word):
	pass
	
