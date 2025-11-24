import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://izbasandreiti224.github.io/PAM-JSON2';
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$endpoint'),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data from $endpoint. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> getFeed() => get('feed.json');
  Future<Map<String, dynamic>> getFeedDetails() => get('feed-details.json');
}