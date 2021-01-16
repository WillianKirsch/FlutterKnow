import 'package:estrutura_console/estrutura_console.dart';
import 'package:test/test.dart';

void main() {
  test('calculando_6_7', () {
    expect(calculate(6, 7), 42);
  });

  test('calculando_5_5', () {
    expect(calculate(5, 5), 25);
  });
}
