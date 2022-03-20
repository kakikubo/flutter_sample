import 'package:flutter_test/flutter_test.dart';

void main() {
  group('変数', () {
    test('デフォルトはnullである', () {
      int? lineCount;
      expect(lineCount, isNull);
    });
    test('Stringから数値に変換する', () {
      var one = int.parse('1');
      var onePointOne = double.parse('1.1');
      expect(one, 1);
      expect(onePointOne, 1.1);
    });
    test('数値からStringに変換する', () {
      String oneAsString = 1.toString();
      String piAsString = 3.14159.toStringAsFixed(2);
      expect(oneAsString, '1');
      expect(piAsString, '3.14');
    });
    test('シングルクォートもダブルクォートも同じ意味', () {
      var s = 'bar';
      var str1 = 'foo $s baz';
      var str2 = 'foo ${s.toUpperCase()} baz';
      expect(str1, 'foo bar baz');
      expect(str2, 'foo BAR baz');
    });
    test('rをつけるとraw文字列になる', () {
      var str3 = r'apple banana \npineapple';
      expect(str3, r'apple banana \npineapple');
    });
  });
  group('Listを使う', () {
    test('Listの操作をする', () {
      var list = <int>[];
      list.add(100);
      list.add(200);
      list[1] = 101;
      expect(list[0], 100);
      expect(list.elementAt(1), 101);
    });
    test('いろいろな宣言の方法がある', () {
      var list1 = <int>[];
      List<int> list2 = [];
      expect(list1, list2);
    });
    test('要素が3のリストを作成する', () {
      var list = Iterable<int>.generate(3).toList();
      expect(list, [0, 1, 2]);
    });
    test('要素が3のリストを多少いじって作成する', () {
      var list = List<String>.generate(3, (i) => "a" + i.toString());
      expect(list, ['a0', 'a1', 'a2']);
    });
  });
  group('Setを使う', () {
    Set set = {};
    set.add(1000);
    set.add(2000);
    set.add(3000);
    set.add(4000);
    test('基本的な使い方', () {
      expect(set.elementAt(0), 1000);
    });
    test('LinkedHashSetを使っているのでSetでも順序が保持されている', () {
      expect(set.elementAt(3), 4000);
    });
    test('指定したインデックスがない場合はエラー', () {
      expect(() => set.elementAt(10), throwsArgumentError);
    });
  });
}
