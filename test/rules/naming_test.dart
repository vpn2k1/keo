import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Quy ước: tên file và thư mục dùng snake_case (rules/naming.md).
final snakeFile = RegExp(r'^[a-z][a-z0-9_]*\.dart$');
final snakeDir = RegExp(r'^[a-z][a-z0-9_]*$');

void main() {
  test('tên file Dart trong lib/ và test/ là snake_case', () {
    final bad = <String>[];
    for (final dir in ['lib', 'test']) {
      for (final e in Directory(dir).listSync(recursive: true)) {
        final name = e.uri.pathSegments.where((s) => s.isNotEmpty).last;
        if (e is File && name.endsWith('.dart') && !snakeFile.hasMatch(name)) {
          bad.add(e.path);
        }
      }
    }
    expect(bad, isEmpty, reason: 'Đổi sang snake_case: ${bad.join(', ')}');
  });

  test('tên thư mục trong lib/ và test/ là snake_case', () {
    final bad = <String>[];
    for (final dir in ['lib', 'test']) {
      for (final e in Directory(dir).listSync(recursive: true)) {
        if (e is! Directory) continue;
        final name = e.uri.pathSegments.where((s) => s.isNotEmpty).last;
        if (!snakeDir.hasMatch(name)) bad.add(e.path);
      }
    }
    expect(bad, isEmpty, reason: 'Đổi sang snake_case: ${bad.join(', ')}');
  });
}
