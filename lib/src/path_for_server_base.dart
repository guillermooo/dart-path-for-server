// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library path_for_server.base;

import 'dart:io';

import 'package:path/path.dart' as path;

final RegExp unixEnvironmentVariable = new RegExp(r'^\$.*$');
final RegExp windowsEnvironmentVariable = new RegExp(r'^%.*%$');
final RegExp variableNameRegExp = new RegExp(r'^[\$%](.*?)%?$');

String expand_variables(String filePath) {
  assert(filePath != null);
  var segments = path.split(filePath);
  var expanded = [];

  for (var segment in segments) {
    if (unixEnvironmentVariable.hasMatch(segment) ||
        Platform.isWindows && windowsEnvironmentVariable.hasMatch(segment)) {
      var name = variableNameRegExp.allMatches(segment).toList()[0].group(1);
      var value = Platform.environment[name];
      expanded.add(value != null ? value : '');
    } else {
      expanded.add(segment);
    }
  }

  if (expanded[0] == '~') {
    var home = Platform.isWindows ? 'USERPROFILE' : 'HOME';
    expanded[0] = Platform.environment[home];
  }

  return path.normalize(expanded.join(path.separator));
}
