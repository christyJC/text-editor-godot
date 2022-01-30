extends TextEdit


static func snippet(editor,ext):
		var curr_col = editor.cursor_get_column()
		var curr_row = editor.cursor_get_line()
		
		editor.cursor_set_column(curr_col-1)
		var word = editor.get_word_under_cursor()
		if word == "main":
			var length = word.length()
			editor.select(curr_row,curr_col-length,curr_row,curr_col)
			editor.insert_text_at_cursor("int main(args)")
		else:
			editor.cursor_set_column(curr_col)

func c_snippets(editor,word):
	match word:
		"main":
			pass
		"inc":
			pass
		"if":
			pass
	
func java_snippets(editor,word):
	pass
func python_snippets(editor,word):
	pass
	
