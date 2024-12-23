extends Sprite2D

const lines: Array[String] = [
	"Welcome back, unit; You have sustained damage to your memory processor and may have issues recovering invaluable data about your responsibilities in this job.",
	"test 1"
]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if DialogManager:
			var pos = Vector2(global_position.x + self.scale[0], global_position.y)
			DialogManager.start_dialog(pos, lines)
		else:
			print("DialogManager node not found. Ensure it's properly added to the scene tree.")
