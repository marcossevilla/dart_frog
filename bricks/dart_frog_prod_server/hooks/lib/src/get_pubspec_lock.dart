import 'dart:io';

import 'package:dart_frog_prod_server_hooks/src/pubspec_lock/pubspec_lock.dart';
import 'package:path/path.dart' as path;

PubspecLock getPubspecLock(
  String workingDirectory, {
  path.Context? pathContext,
}) {
  final pathResolver = pathContext ?? path.context;
  Directory? currentDir = Directory(workingDirectory);

  while (currentDir != null) {
    final pubspecLockPath = pathResolver.join(currentDir.path, 'pubspec.lock');
    final pubspecLockFile = File(pubspecLockPath);

    if (pubspecLockFile.existsSync()) {
      final content = pubspecLockFile.readAsStringSync();
      return PubspecLock.fromString(content);
    }

    currentDir = currentDir.parent;

    // Stop if we reach the root directory.
    if (pathResolver.equals(
      currentDir.path,
      pathResolver.rootPrefix(currentDir.path),
    )) {
      currentDir = null;
    }
  }

  throw Exception('pubspec.lock not found');
}
