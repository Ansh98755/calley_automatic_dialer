import 'dart:developer';
import 'package:flutter/foundation.dart';

void customDebugLogs({required String message, String name = ""}) {
  if (kDebugMode) {
    final stackTrace = StackTrace.current;
    final frames = stackTrace.toString().split('\n');
    final callingFrame = frames.length > 1 ? frames[1] : frames[0];
    final callingMatch = RegExp(r'([a-zA-Z0-9_]+)\.dart:([0-9]+)').firstMatch(callingFrame);
    final callingFile = callingMatch?.group(1) ?? 'unknown file';
    final callingLine = callingMatch?.group(2) ?? 'unknown line';
    log("$callingFile:$callingLine: $message  ----->$name");
  }
}