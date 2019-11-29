// Stack Calculator
// A stack machine processes instructions by pushing and popping values to an
// internal stack. A simple example of this is a calculator.
//
//  The argument passed to stackCalc(instructions) will always be a string containing a series of instructions.
//  The instruction set of the calculator will be this:
//
//  +: Pop the last 2 values from the stack, add them, and push the result onto the stack.
//  -: Pop the last 2 values from the stack, subtract the lower one from the
//     topmost one, and push the result.
//  *: Pop the last 2 values, multiply, and push the result.
//  /: Pop the last 2 values, divide the topmost one by the lower one, and push the result.
//  DUP: Duplicate (not double) the top value on the stack.
//  POP: Pop the last value from the stack and discard it.
//  PSH: Performed whenever a number appears as an instruction. Push the number to the stack.
//  Any other instruction (for example, a letter) should result in the value
//  "Invalid instruction: [instruction]"

/// Examples
//  stackCalc("") ➞ 0
//  stackCalc("5 6 +") ➞ 11
//  stackCalc("3 DUP +") ➞ 6
//  stackCalc("6 5 5 7 * - /") ➞ 5
//  stackCalc("x y +") ➞ Invalid instruction: x

int stackCalc(String inputString) {
  if (inputString == '') {
    return 0;
  }

  List<String> listOfInstructions = List.from(inputString.split(' '));
  List<int> stack = [];

  for (String instr in listOfInstructions) {
    //print(instr);

    if (isNumeric(instr)) {
      stack.add(int.parse(instr));
    }

    else if ([
          '+',
          '*',
          '/',
          '-',
          'DUP',
          'POP',
        ].contains(instr) &&
        stack.isNotEmpty) {
      //print(stack);

      if (instr == 'POP') {
        stack.removeLast();
      }

      if (instr == 'DUP') {
        stack.add(stack.last);
      }

      if (stack.length > 1) {
        if (instr == '+') {
          stack.add(calc(add, stack));
        }
        if (instr == '-') {
          stack.add(calc(sub, stack));
        }
        if (instr == '*') {
          stack.add(calc(mul, stack));
        }
        if (instr == '/') {
          if (!(stack.last == 0 || stack[stack.length - 2] == 0)) {
            stack.add(calc(div, stack));
          } else {
            print('Division with zero is not possible, please check input');
            throw ArgumentError;
          }
        }
      }

      else{
        print('Invalid Instruction $instr on stack $stack');
        return null;
      }
    }

    else {
      print('Invalid Instruction $instr on stack $stack');
      return null;
    }
  }

  return stack.last;
}

int calc(Function callBack, List stack) {
  if (stack.length > 1) {
    int last = stack.removeLast();
    int secondLast = stack.removeLast();
    return callBack(last, secondLast);
  } else {
    throw ArgumentError;
  }
}

int add(int x, int y) => x + y;
int sub(int x, int y) => x - y;
int mul(int x, int y) => x * y;
int div(int x, int y) {
  if (x != 0 && y != 0) {
    return x ~/ y;
  } else {
    throw ArgumentError;
  }
}

bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}

main() {
  print(stackCalc("+ 5 6 POP +"));
}
