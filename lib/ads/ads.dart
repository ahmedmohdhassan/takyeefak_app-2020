import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAd {
  String url;
  CreateAd({this.url});
  Future fetchad() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      return;
    }
  }
}
