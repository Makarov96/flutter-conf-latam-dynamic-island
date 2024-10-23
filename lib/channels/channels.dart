import 'package:flutter/services.dart';

class Channels {
  final _channel = const MethodChannel('ios.activities/flutter_conf');

  Future<void> onStart([
    Map<String, dynamic> arguments = const {},
  ]) async {
    await _channel.invokeMethod('onStart', arguments);
  }

  Future<bool> onUpdateDynamicIsland(
      [Map<String, dynamic> arguments = const {}]) async {
    try {
      final updated = await _channel.invokeMethod('onUpdate', arguments);
      return updated;
    } catch (e) {
      return false;
    }
  }

  void onEnd([
    Map<String, dynamic> arguments = const {},
  ]) {
    _channel.invokeMethod('onEnd', arguments);
  }

  void onListen(VoidCallback list) {
    _channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          default:
        }
      },
    );
  }
}
