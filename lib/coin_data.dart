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
Map cryptoPrices = {};

class CoinData {
  //L1: Create your getCoinData() method here.
  //L2 -3: Update getCoinData to take the selectedCurrency as an input.
  Future getCoinData(String selectedCurrency) async {
    //L2 -4: Update the URL to use the selectedCurrency input.

    for (var crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=053CC058-24BC-476D-862F-5BD56DEBE5E4'));
      if (response.statusCode == 200) {
        String data = response.body;
        cryptoPrices[crypto] = jsonDecode(data)['rate'];
      } else {
        print(response.statusCode);

        // throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
