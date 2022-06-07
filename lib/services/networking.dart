import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  // This method is used to connect to the API.
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }
}
