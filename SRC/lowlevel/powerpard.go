package powerpard

func PVM_SimpleAdd_Int(a int32, b int32) int32 {
	return a + b
}

func PVM_SimpleAdd_Float(a float32, b float32) float32 {
	return a + b
}

func PVM_CAdd_Int(a int32, b int32, c int32) int32 {
	return a + b + c
}

func PVM_CAdd_Float(a float32, b float32, c float32) float32 {
	return a + b + c
}

func PVM_SimpleMult_Int(a int32, b int32) int32 {
	return a * b
}

func PVM_SimpleMult_Float(a float32, b float32) float32 {
	return a * b
}

func PVM_CMult_Float(a float32, b float32, c float32) float32 {
	return a * b * c
}

func PVM_CMult_Int(a int32, b int32, c int32) int32 {
	return a * b * c
}

func PVM_SimpleSub_Int(a int32, b int32) int32 {
	return a - b
}

func PVM_SimpleSub_Float(a float32, b float32) float32 {
	return a - b
}

func PVM_CSub_Float(a float32, b float32, c float32) float32 {
	return a - b - c
}

func PVM_CSub_Int(a int32, b int32, c int32) int32 {
	return a - b - c
}

func PVM_SimpleDiv_Int(a int32, b int32) int32 {
	return a / b
}

func PVM_SimpleDiv_Float(a float32, b float32) float32 {
	return a / b
}
