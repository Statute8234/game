extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256
var text = ""
var segments: Array[String] = []
var current_segment_index = 0 
var is_waiting_for_input = false

signal finished_displaying

func display_text(text_to_display: String):
	text = text_to_display
	segments = split_text_by_punctuation(text)
	current_segment_index = 0
	is_waiting_for_input = false
	label.text = ""
	display_next_segment()

func display_next_segment():
	if current_segment_index < segments.size():
		label.text = segments[current_segment_index]
		current_segment_index += 1
		is_waiting_for_input = true
	else:
		finished_displaying.emit()

func split_text_by_punctuation(text_to_split: String) -> Array[String]:
	var split_segments: Array[String] = []  # Explicitly typed array
	var current_segment = ""
	for char in text_to_split:
		current_segment += char
		if char in [".", "!", "?", ","]:
			split_segments.append(current_segment.strip_edges())
			current_segment = ""
	if current_segment.strip_edges() != "":
		split_segments.append(current_segment.strip_edges())
	return split_segments

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and is_waiting_for_input:
		is_waiting_for_input = false
		display_next_segment()
