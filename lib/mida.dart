library mida;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class Mida {
  final host = 'https://api.mida.so';
  String publicKey;
  String? userId;

  Mida({required this.publicKey, this.userId});

  void checkUserDistinctId(String? distinctId) {
    if (userId.isNullOrEmpty && distinctId.isNullOrEmpty) {
      throw 'You must pass your user ID or distinct ID';
    }
  }

  Future<dynamic> getExperiment({required String experimentKey, String? distinctId}) async {
    try {
      checkUserDistinctId(distinctId);

      Map<String, dynamic> requestBody = {
        'key': publicKey,
        'experiment_key': experimentKey,
        'distinct_id': distinctId ?? userId,
      };

      final http.Response response = await http.post(Uri.parse('$host/experiment/query'),
        headers: await headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> setEvent({required String eventName, String? distinctId}) async {
    try {
      checkUserDistinctId(distinctId);

      Map<String, dynamic> requestBody = {
        'key': publicKey,
        'name': eventName,
        'distinct_id': distinctId ?? userId,
      };

      final http.Response response = await http.post(Uri.parse('$host/experiment/event'),
        headers: await headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> setAttribute({required Map<String,dynamic> properties, String? distinctId}) async {
    try {
      checkUserDistinctId(distinctId);

      properties.addAll({
        'id': distinctId ?? userId
      });

      final http.Response response = await http.post(Uri.parse('$host/track/$publicKey'),
        headers: await headers,
        body: jsonEncode(properties),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, String>> get headers async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'user-agent': 'mida-node/$version($buildNumber)'
    };
  }
}

extension StringExt on String? {
  bool get isNullOrEmpty {
    return this == null || this == '';
  }
}
