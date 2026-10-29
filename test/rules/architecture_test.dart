import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Quy ước: `lib/core/` là Dart thuần, không import Flutter hay tầng giao diện
/// (rules/structure.md).
final importLine = RegExp(
  r"""^\s*import\s+['"]([^'"]+)['"]""",
  multiLine: true,
);
const forbiddenFromCore = [
  'package:flutter/',
  '../features/',
  '../app/',
  '../l10n/',
];

void main() {
  test('lib/core/ không import Flutter hay tầng giao diện', () {
    final bad = <String>[];
    for (final f in Directory('lib/core').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      for (final m in importLine.allMatches(f.readAsStringSync())) {
        final target = m.group(1)!;
        if (forbiddenFromCore.any(target.startsWith)) {
          bad.add('${f.path}: $target');
        }
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });
}
