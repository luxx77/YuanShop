import 'dart:convert';

import 'package:flutter/services.dart';

mixin AssetClientMixin {
  final _client = _AssetClient();

  _AssetClient get assetBundle => _client;
}

class _AssetClient {
  final _client = PlatformAssetBundle();

  Future<Map<String, dynamic>> getData(String path) async {
    final data =
        await _client.loadString(path).then((value) => jsonDecode(value));
    return data;
  }
}
