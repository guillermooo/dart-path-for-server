// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library path_for_server.example;

import 'package:path_for_server/path_for_server.dart';

main() {
  // Expands '~' on all platforms.
  print(expand_variables("~/some/path"));

  // Expands $SOMEVAR on all plaforms.
  print(expand_variables("\$SOMEVAR/some/path"));

  // Expands %SOMEVAR% on Windows.
  print(expand_variables("%SOMEVAR%/some/path"));
}
