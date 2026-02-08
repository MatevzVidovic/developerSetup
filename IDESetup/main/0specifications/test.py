# basic_calculator.py

def add(a: float, b: float) -> float:
    """Return the sum of a and b."""
    return a + b

def multiply(a: float, b: float) -> float:
    """Return the product of a and b."""
    return a * b

def calculate(a: float, op: str, b: float) -> float:
    """Perform a basic calculation for + or * operations."""
    if op == '+':
        return add(a, b)
    elif op == '*':
        return multiply(a, b)
    else:
        raise ValueError(f"Unsupported operator: {op}")

if __name__ == "__main__":
    print("Basic Calculator — supports + and *")
    try:
        expr = input("Enter expression (e.g. 3 + 4 or 2 * 5): ").strip()
        a_str, op, b_str = expr.split()
        a, b = float(a_str), float(b_str)
        result = calculate(a, op, b)
        print(f"Result: {result}")
    except Exception as e:
        print(f"Error: {e}")


