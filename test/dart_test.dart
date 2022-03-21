import 'package:flutter_test/flutter_test.dart';

// 後述の拡張関数で使用
extension MyFancyList<T> on List<T> {
  int get doublelength => this.length * 2;

  List<T> operator -() => this.reversed.toList();

  List<List<T>> split(int at) =>
      <List<T>>[this.sublist(0, at), this.sublist(at)];
}

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
    Set v1 = const {};
    var v2 = const {};
    test('v1はSetである', () {
      expect(v1 is Set, true);
    });
    test('v2はMapである', () {
      expect(v2 is Map, true);
    });
    test('set1とset2はSetである', () {
      Set<String> set1 = const {};
      var set2 = const <String>{};
      expect(set1 is Set, true);
      expect(set2 is Set, true);
    });
  });
  group('Mapを使う', () {
    var map = Map<String, int>();
    map['foo'] = 100;
    test('mapに入力したデータを検証する', () {
      expect(map['foo'], 100);
    });
    test('指定した値がない場合はnullになる', () {
      expect(map['baz'], null);
    });
    test('次の3つは同じ意味になる', () {
      var gifts1 = {
        'first': 'partridge',
        'second': 'turtledoves',
      };
      var gifts2 = Map();
      gifts2['first'] = 'partridge';
      gifts2['second'] = 'turtledoves';
      var gifts3 = Map<String, String>();
      gifts3['first'] = 'partridge';
      gifts3['second'] = 'turtledoves';

      expect(gifts1, gifts2);
      expect(gifts2, gifts3);
      expect(gifts1, gifts3);
    });
  });
  group('Runesを試す', () {
    test('clappingの文字列を検証', () {
      var clapping = '\u{1f44f}';
      print(clapping);
      print(clapping.codeUnits);
      print(clapping.runes.toList());
      expect(clapping, "👏");
      expect(clapping.codeUnits, [55357, 56399]);
      expect(clapping.runes.toList(), [128079]);
    });
    test('様々な絵文字を検証', () {
      Runes input =
          Runes('\u2665 \u{1f605} \u{1f60e} \u{1f47b} \u{1f596} \u{1f44d}');
      print(String.fromCharCodes(input));
      expect(String.fromCharCodes(input), '♥ 😅 😎 👻 🖖 👍');
    });
  });
  group('関数', () {
    String Function(String name) hello = (name) {
      return 'Hello, ${name}!';
    };
    test('関数の戻り値が正しい', () {
      expect(hello('user'), 'Hello, user!');
    });
    test('関数の型はFunction型', () {
      expect(hello is Function, true);
    });
  });
  group('クロージャを試す', () {
    Function makeAdder(num addBy) {
      return (num i) => addBy + i;
    }

    var add2 = makeAdder(2);
    var add4 = makeAdder(4);
    test('add2に3を渡すと5', () {
      expect(add2(3), 5);
    });
    test('add4に3を渡すと7', () {
      expect(add4(3), 7);
    });
  });
  group('冒頭で定義した拡張関数(MyFancyList)を利用', () {
    var list = []
      ..add("a")
      ..add("b")
      ..add("c");
    print(list.doublelength);
    print(-list);
    print(list.split(1));
    test("拡張関数がそれぞれ機能している事を確認", () {
      expect(list.doublelength, 6);
      expect(-list, ["c", "b", "a"]);
      expect(list.split(2), [
        ["a", "b"],
        ["c"]
      ]);
    });
  });
}