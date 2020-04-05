import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const url = "https://rest.coinapi.io/v1/exchangerate";
const apikey = "EA60F148-CC1B-4469-9CC9-58B6972A9F6E";
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

class CoinData {
  Future getCoinData(String currency,String rate) async {
    http.Response response = await http.get("$url/$currency/$rate?apikey=$apikey");
    if (response.statusCode == 200) {
      var data =  convert.jsonDecode(response.body);
     double data1= data['rate'];
     return data1.toStringAsFixed(0);
    }
  }
}
