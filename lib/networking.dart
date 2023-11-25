import 'package:http/http.dart' as http;
import 'dart:convert';

const kCoinAPIKey = '2C1E8744-D121-40F4-B228-68592E47CD18';
const kCoinURL = 'https://rest.coinapi.io/v1/exchangerate/';
const kCoinRequest = '--request GET';
const kCoinHeader = '--header "X-CoinAPI-Key: ';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;
  Map<String, String> headerInfo = {'X-CoinAPI-Key':kCoinAPIKey};

  void setURL(String newURL) {
    this.url = newURL;
  }

  Future getData() async {
    // print('Getting data in NetworkHelper');
    Uri urlFromString = Uri.parse(url);
    http.Response response = await http.get(urlFromString, headers: headerInfo);

    if(response.statusCode == 200) {
      // print('All OK to proceed. Response: ${response.body}');

      String jsonSource = response.body;

      return jsonDecode(jsonSource);
    }
    else {
      print('Error condition from get data ${response.statusCode} ${response.reasonPhrase}');
      return null;
    }
  }
}