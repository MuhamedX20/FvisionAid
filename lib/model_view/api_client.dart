import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiClient {
  final String baseUrl = 'https://blind-ai-api.onrender.com';

  Future<Map<String, dynamic>> detectCash(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/cash-detector'),
    );
    request.headers['Accept'] = 'application/json';
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();
    

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to detect cash');
    }
  }

  Future<List<String>> extractColors(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/extract-colors'),
    );
    request.headers['Accept'] = 'application/json';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> result = json.decode(responseBody);
      return List<String>.from(result['colors']);
    } else {
      throw Exception('Failed to extract colors');
    }
  }


  
  // New method for OCR
  Future<Map<String, dynamic>> performOcr(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/ocr'),
    );
    request.headers['Accept'] = 'application/json';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to perform OCR');
    }
  }
}
