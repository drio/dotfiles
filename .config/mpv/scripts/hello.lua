require("os")
require("io")
require("string")

function print_hello_world()
	print("Hello World")
end

-- Set key bindings.
mp.add_key_binding("g", "print_hello_world", print_hello_world)
