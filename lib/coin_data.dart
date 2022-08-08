import 'package:http/http.dart' as http;
import 'dart:convert';

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
// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '053CC058-24BC-476D-862F-5BD56DEBE5E4';

class CoinData {
  //TODO: Create your getCoinData() method here.
  Future getCoinData() async {
    http.Response response = await http.get(Uri.parse(
        '$coinAPIURL/BTC/USD?apikey=053CC058-24BC-476D-862F-5BD56DEBE5E4'));
    if (response.statusCode == 200) {
      String data = response.body;
      return (jsonDecode(data)['rate']);
    } else {
      print(response.statusCode);

      // throw an error if our request fails.
      throw 'Problem with the get request';
    }
  }
}
