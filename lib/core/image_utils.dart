import 'package:flutter/foundation.dart';

/// Returns [cacheWidth] on mobile/desktop platforms, or `null` on Web.
int? webSafeCacheWidth(int? cacheWidth, {bool isWeb = kIsWeb}) {
  if (isWeb) return null;
  return cacheWidth;
}
