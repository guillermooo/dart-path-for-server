// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Additional path handling functions for server applications.
///
/// Does not work for web applications.
library path_for_server;

import 'src/path_for_server_base.dart' as base;

/// Expands environment variables in [filePath].
///
/// On Windows, $NAME as well as %NAME% variables will be expanded.
/// The '~' symbol will also be expanded on all platforms, but only if
/// it is the first component in [filePath].
String expand_variables(String filePath) => base.expand_variables(filePath);
