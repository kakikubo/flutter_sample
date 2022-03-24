import 'package:flutter_test/flutter_test.dart';

// 後述の拡張関数で使用
extension MyFancyList<T> on List<T> {
  int get doublelength => this.length * 2;

  List<T> operator -() => this.reversed.toList();

  List<List<T>> split(int at) =>
      <List<T>>[this.sublist(0, at), this.sublist(at)];
}

// 後述のMixinで使用
mixin Greet1 {
  // 4.
  String hello() => "hello, greet1";
}
mixin Greet2 {
  // 3.
  String hello() => "hello, greet2";
}
mixin Greet3 {
  // 2.
  String hello() => "hello, greet3";
}

class Ancestor {
  // 6.
  String hello() => "I am a Ancestor";
}

class Parent extends Ancestor {
  // 5.
  String hello() => "I am a Parent";
}

class Child extends Parent with Greet1, Greet2, Greet3 {
  // 1.
  // String hello() => "I am a child";
}

// 後述のCallable Classe
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

// 後述のinitializer list
class Employee extends Person {
  final String message;

  Employee.fromJson(Map data)
      : message = "hello",
        super.fromJson(data) {
    print(message);
    print('in Employee');
  }
}

class Person {
  final String firstName;

  Person.fromJson(Map data) : this.firstName = "Bob" {
    print(firstName);
    print('in Person');
  }
}

// 後述のenum
enum Color { red, green, blue }

// 後述のIterable
class MyStrings extends Iterable<String> {
  final List<String> strings;

  MyStrings(this.strings);

  @override
  Iterator<String> get iterator => strings.iterator;
}

// 後述の同期ジェネレーター
Iterable<int> getRange(int start, int end) sync* {
  print('called getRange');
  for (int i = start; i <= end; i++){
    print('before yield');
    yield i;
    print('after yield');
    print('\n');
  }
}
// 後述の非同期ジェネレーター
Stream<int> fetchDoubles(int start, int end) async* {
  for (int i = start; i <= end; i++) {
    yield await fetchDouble(i);
  }
}
Future<int> fetchDouble(int val){
  return Future.delayed(Duration(seconds: 1)).then((_){
    return val * 2;
  });
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
  group('例外をなげる', () {
    test('ArgumentError', () {
      expect(() => throw FormatException("Expected Good Life"),
          throwsFormatException);
    });
  });
  group('mixin', () {
    test('定義を一番最後にしたMixinが優先される', () {
      var message = Child().hello();
      expect(message, "hello, greet3");
    });
  });
  group('Callable Classe', () {
    test('インスタンスを関数のように呼べる', () {
      var instance = WannabeFunction();
      var out = instance("Hi", "there,", "gang");
      expect(out, "Hi there, gang!");
    });
  });
  group('initializer list', () {
    test('コンストラクタ呼び出しでinitializer list が適用されていること', () {
      expect(Employee.fromJson({}).message, "hello");
    });
  });
  group('Enum', () {
    test('indexは0からはじまる', () {
      expect(Color.red.index, 0);
    });
    test('valuesプロパティを利用して値を取得する', () {
      List<Color> colors = Color.values;
      expect(colors[2], Color.blue);
    });
    group('列挙型', () {
      test('列挙型はswitch文ですべての列挙値を条件にいれないと警告がでる', () {
        var aColor = Color.blue;
        switch (aColor) {
          case Color.red:
            print('Red as roses!');
            break;
          case Color.green:
            print('Green as grass!');
            break;
          default:
            print(aColor);
        }
      });
    }, skip: "これはうまくいってない気がするのとWarningのテストって書けるんでしたっけ");
  });
  group('Iterable', (){
    final myStrings = MyStrings([
      'one',
      'two',
      'three',
    ]);
    test('Iterableを継承したクラスはforループが使える',(){
      var strList = [];
      for (final str in myStrings){
        strList.add(str);
      }
      expect(strList, myStrings);
    });
    test('mapだって使える', (){
      final lengths = myStrings.map((s) => s.length);
      var lengthList = [];
      for (final length in lengths) {
        lengthList.add(length);
      }
      expect(lengthList, [3, 3, 5]);
    });
  });
  group('同期ジェネレーターをつかう', (){
    final numbers = getRange(1, 10);
    test('イテレーター同様にループさせる(テストになってない)', (){
      for (int val in numbers){
        print('before print val');
        print(val);
        print('after print val');
      }
    });
  });
  group('非同期ジェネレーターもつかう', (){
    test('ループさせてみる(テストになってない)', (){
      fetchDoubles(1, 10).listen(print);
    });
  });
  group('Conditional member access operator(save navigation operatorともいう)', (){
    String? target = null;
    test('nullであってもエラーにならない', (){
      var length = target?.trim()?.toLowerCase()?.length ?? 0;
      expect(length, 0);
    });
    test('nullでない場合は問題なく処理される', (){
      target = "test string   ";
      var length = target?.trim()?.toLowerCase()?.length ?? 0;
      expect(length, 11);
    });
  });
  group('spread operator', (){
    test('リストを別のリストに挿入する', (){
      var list = [1,2,3];
      var list2 = [0, ...list];
      expect(list2.length, 4);
    });
    test('nullの可能性があるリストはnull-aware Spread Operatorでエラーを回避できる', (){
      var list = null;
      var list2 = [0, ...?list];
      expect(list2.length, 1);
    });
  });
  group('Collection for',(){
    test('リスト作成時に別のリストを操作しながらリストに追加する処理', (){
      var listOfInts = [1,2,3];
      var listOfStrings = [
        '#0',
        for (var i in listOfInts) '#$i'
      ];
      expect(listOfStrings[1], '#1');
      expect(listOfStrings.length, 4);
    });
  });
}
