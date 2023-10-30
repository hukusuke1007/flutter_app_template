import 'package:flutter_test/flutter_test.dart';
import 'package:quiver/iterables.dart';

void main() {
  group('配列テスト', () {
    test('ある配列から10件の要素を取り出して複数の配列を生成する', () {
      const list = [
        '2mOHnKIEfifCCnd2418o1q0hxe23',
        '3kkAsS0F7MS0YdpddJQzcEFCqG02',
        '4ji3MPxHZMYRrPkYxr6jaV2KTbj2',
        '5ZF7WGIb1uWFrkANZUV5IDnSYs83',
        '6LZjIZQyNGY0lmUaMRnsYnHkPsJ2',
        '8ARLBEPkdxgTaTBwktypJGm0kHw2',
        '8ilKQ6BU5JOsJ29VVFlRhajLHgE2',
        '9eWGVzKgkjN0STziLyQPZf55WWg1',
        'BPwt6y1mkFg5mWFZh3Pm73qtAmL2',
        'DAVGi31AsmNyTn7plJs7AP3OG8C3',
        'E8Vdk0tdYdYMMs9lV1lrXfkncQJ3',
        'EAaE5TT98GVno874F2UKWR5bLyj2',
        'FDNGIHL3CihwMJjUwEUHRUHyhKd2',
        'FKCDhWWgsLZTedCpBj03P4a6tUI2',
        'FNNjOtaxvNP9cHi3lgqFDrHFljW2',
        'G4I9gfSYwKZOuwIENmxzAr2ohnP2',
        'GK9hMIzrovd0JKw6DD4hyH6aCmx1',
        'IH9bKhT49KfjGU0TzA0CVxGOS1H2',
        'JxM21piohhW56WuTHJs03zotrKQ2',
        'L0vhrztLwkMi5XReVpY2MPqWJrY2',
        'Mk8bSYQg2Nd4tu7OrXAApzkbHOs2',
        'PrjkkQvKn8bZmlbRp6T9WexOHTe2',
        'XMpeEVibTQaV6yOxbxJM15yCX942',
        'Xc8uDUfrCXgWw1zOjhHOTYuQ4WF2',
        'YJ4nvDbedGgpAYemm9nKgZjHKQy1',
        'Yfm2zcmHR2V3CfDufrTmsUGIQeh2',
        'bh0ZA6AjIfQlHvsKkWdgBhWl0zr2',
        'cpmsOCTfSAZ53Ai2yjvYmqGO5KC2',
        'dppddWObTVZuZm7K797xgS0UmWk1',
        'ggSWFhexE8fNEQzuvGFjVTcRk4z1',
        'n87TjrOflGWoYpkHftEAOXKRTeT2',
        'nSwJql2VGqXq70X9OzFtVKHwqzU2',
        'ooEHgjE42wWExcmmd0A95hUqvmI2',
        'owmp0jRJByTKoNnDVks4AlB8hv43',
        'pIoWww5r1XczEoLIwNoIm2czqPY2',
        'peBnenVh7CbZPYVzlvHijrAAppB3',
        'yxHAHTKxphgbcUn1MosPzFBC3BA2',
      ];
      const count = 10;
      final results = partition<String>(list, count).toList();

      for (var i = 0; i < results.length; i++) {
        final result = results[i];
        for (var j = 0; j > result.length; j++) {
          expect(result[i], list[j * i]);
        }
      }
    });
  });
}
