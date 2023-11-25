import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String kBtcText = '1 BTC = ';
const String kEthText = '1 ETH = ';
const String kLtcText = '1 LTC = ';


class CoinData {
  // This is for BTC, ETH, LTC
  List<double> cryptoPrice = [0,0,0];

  Future<dynamic> getCoinData(String currency) async {
    // BTC is cryptoList[0]...
    String dataURL = '';
    NetworkHelper networkHelper = NetworkHelper(dataURL);

    for (int i=0; i<3; i++) {
      dataURL = '${kCoinURL}${cryptoList[i]}/$currency';

      print(dataURL);
      networkHelper.setURL(dataURL);
      var coinData = await networkHelper.getData();

      //TODO: check the returned data - try catch
      if (coinData != null) {
        print(coinData);
        cryptoPrice[i] = coinData['rate'];
        print(cryptoPrice[i]);
      }
    }
  }
}
