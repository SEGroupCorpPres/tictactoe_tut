import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;

  Future<String> info() async {
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
    print(wifiIP);
    return wifiIP!;
  }

  static SocketClient? _instance;

  SocketClient._internal() {
    print(info());
    socket = IO.io('http://192.168.43.252:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
