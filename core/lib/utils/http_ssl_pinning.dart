// coverage:ignore-file
import 'package:core/utils/sslpin_helper.dart';
import 'package:http/http.dart' as http;

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await SslpinHelper.createLEClient();

  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
