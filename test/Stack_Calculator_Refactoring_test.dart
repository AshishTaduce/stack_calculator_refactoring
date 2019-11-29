import 'package:test/test.dart';
import '../bin/main.dart';

void main() {
  test('calculate', () {
    expect(stackCalc(""),0);
    expect(stackCalc("5 6 +"),11);
    expect(stackCalc("3 DUP +"), 6);
    expect(stackCalc("6 5 5 7 * - /"), 5);
    expect(stackCalc("6 5 5 7 POP - +"), 6);
    expect(stackCalc("2 5 6 POP +"), 7);
    expect(stackCalc("+ 5 6 POP +"), null);
    expect(stackCalc("6 POP +"), null);
    expect(stackCalc("POP 6 +"), null);
  });
}
