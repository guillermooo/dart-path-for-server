// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library path_for_server.test;

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:unittest/unittest.dart';

import 'package:path_for_server/path_for_server.dart';

main() {

  if (!Platform.isWindows) {
    group("Testing on Unix", () {

      test("that we can expand '~'", () {
        var actual = expand_variables(r'~/cat/dog');
        var expected = path.join(Platform.environment['HOME'], "cat/dog");
        expect(expected, equals(actual));
      });

      test("that we don't expand '~' if it isn't the first component", () {
        var actual = expand_variables(r'cat/~/dog');
        var expected = 'cat/~/dog';
        expect(expected, equals(actual));
      });

      test("that we can expand '\$HOME' as first component", () {
        var actual = expand_variables('\$HOME/cat/dog');
        var expected = path.join(Platform.environment['HOME'], "cat/dog");
        expect(actual, equals(expected));
      });

      test("that we can expand '\$USER' as non-first component", () {
        var actual = expand_variables('hello/\$USER/cat/dog');
        var expected = path.join('hello', Platform.environment['USER'], "cat/dog");
        expect(actual, equals(expected));
      });

      test("that we cannot expand '%USER%' as first component", () {
        var actual = expand_variables('%USER%/cat/dog');
        expect("%USER%/cat/dog", equals(actual));
      });

      test("that we cannot expand '%USER%' as non-first component", () {
        var actual = expand_variables('hello/%USER%/cat/dog');
        expect('hello/%USER%/cat/dog', equals(actual));
      });
      
    });
  }

  if (Platform.isWindows) {
    group("Testing on Windows", () {

      test("that we can expand '~'", () {
        var actual = expand_variables(r'~\\cat\\dog');
        var expected = path.join(Platform.environment['USERPROFILE'], "cat\\dog");
        expect(expected, equals(actual));
      });

      test("that we don't expand '~' if it isn't the first component", () {
        var actual = expand_variables(r'cat\\~\\dog');
        var expected = 'cat\\~\\dog';
        expect(expected, equals(actual));
      });

      test("that we can expand '\$USERPROFILE' as first component", () {
        var actual = expand_variables('\$USERPROFILE\\cat\\dog');
        var expected = path.join(Platform.environment['USERPROFILE'], "cat\\dog");
        expect(actual, equals(expected));
      });

      test("that we can expand '\$USERNAME' as non-first component", () {
        var actual = expand_variables('hello\\\$USERNAME\\cat\\dog');
        var expected = path.join('hello', Platform.environment['USERNAME'], "cat\\dog");
        expect(actual, equals(expected));
      });

      test("that we can expand '%USERPROFILE%' as first component", () {
        var actual = expand_variables('%USERPROFILE%\\cat\\dog');
        var expected = path.join(Platform.environment['USERPROFILE'], "cat\\dog");
        expect(actual, equals(expected));
      });

      test("that we can expand '%USERNAME%' as non-first component", () {
        var actual = expand_variables('hello\\%USERNAME%\\cat\\dog');
        var expected = path.join('hello', Platform.environment['USERNAME'], "cat\\dog");
        expect(actual, equals(expected));
      });

    });
  }
}
