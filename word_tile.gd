extends Button

var is_selected = false

# Define the tile size
var tile_size = Vector2(200, 60)  # Change the size as needed

# Create a variable for storing the style box
var selected_style : StyleBoxFlat

func _ready():
	# Set the fixed size for the tile
	custom_minimum_size = tile_size

	# Create a style box to modify the appearance
	selected_style = StyleBoxFlat.new()
	#selected_style.border_width_all = 3  # Set border width
	selected_style.border_color = Color(0, 1, 0)  # Green border color
	
	# Get the Label node and ensure text is centered
	var label = $Label  # Assuming the button has a Label node as a child
	#label.alignment = Label.Alignment.CENTER  # Horizontal center alignment
	#label.valign = Label.VAlign.CENTER  # Vertical center alignment
	
	# Initialize the default state (for initial visual state)
	update_visual()

func _on_pressed():
	# Toggle selection state when the button is pressed
	is_selected = !is_selected
	update_visual()

	# Optionally, call the parent scene to track selected words
	var parent_scene = get_parent()
	if parent_scene and parent_scene.has_method("track_selected"):
		parent_scene.track_selected(self, {"word": text, "category": ""})  # Pass appropriate word data

func update_visual():
	# Update the button's appearance based on selection state
	if is_selected:
		self.modulate = Color(0, 1, 0)  # Highlight in green
		self.add_theme_stylebox_override("normal", selected_style)  # Apply custom style when selected
		self.font_color = Color(0, 0, 0)  # Change font color when selected
	else:
		self.modulate = Color(1, 1, 1)  # Default color (white background)
		self.remove_theme_stylebox_override("normal")  # Remove custom style when not selected
		#self.font_color = Color(0, 0, 0)  # Default font color (black)
