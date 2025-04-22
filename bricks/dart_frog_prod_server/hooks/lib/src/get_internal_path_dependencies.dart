import 'dart:io' as io;

import 'package:dart_frog_prod_server_hooks/dart_frog_prod_server_hooks.dart';
import 'package:path/path.dart' as path;

List<String> getInternalPathDependencies(io.Directory directory) {
  final pubspecLock = getPubspecLock(directory.path);

  final internalPathDependencies = pubspecLock.packages.where(
    (dependency) {
      final pathDescription = dependency.pathDescription;
      if (pathDescription == null) return false;

      return path.isWithin('', pathDescription.path);
    },
  );

  return internalPathDependencies
      .map((dependency) => dependency.pathDescription!.path)
      .toList();
}
