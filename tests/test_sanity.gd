extends GutTest


func test_integer_division_truncates() -> void:
	var result: int = 7 / 2
	assert_eq(result, 3, "int / int should truncate")


func test_float_division() -> void:
	var result: float = 7 / 2.0
	assert_eq(result, 3.5, "int / float should return float")
