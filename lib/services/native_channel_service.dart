import 'package:flutter/services.dart';

class NativeChannelService {
  static const _channel = MethodChannel('app.channel.shared.data');

  /// Gets user info from native.
  Future<Map<String, dynamic>> getUserDetails({String? uid}) async {
    final args = uid != null ? {'uid': uid} : null;
    final result = await _channel.invokeMethod('getUserDetails', args);
    // result is already Map<String, Object?>
    return Map<String, dynamic>.from(result);
  }
}
