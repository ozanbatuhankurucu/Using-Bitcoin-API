import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

CoinData coinData = CoinData();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = "USD";

  String btc = "?";
  String eth = "?";
  String ltc = "?";
  CupertinoPicker cupertinoPickerIos() {
    List<Text> cupertinoPickerTextList = [];
    for (String currency in currenciesList) {
      cupertinoPickerTextList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 30.0,
      backgroundColor: Colors.blue,
      children: cupertinoPickerTextList,
      onSelectedItemChanged: (index) {
        print(index);
      },
    );
  }

  DropdownButton dropDownAndroid() {
    List<DropdownMenuItem<String>> dropDownButtonList = [];

    for (String currency in currenciesList) {
      dropDownButtonList.add(DropdownMenuItem(
        value: currency,
        child: Text(currency),
      ));
    }
    return DropdownButton<String>(
      value: selectedItem,
      items: dropDownButtonList,
      onChanged: (value) {
        setState(() {
          selectedItem = value;
        });
        getCoinData();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinData();
  }

  Future<void> getCoinData() async {
    String btcData = await coinData.getCoinData("BTC", selectedItem);
    String ethData = await coinData.getCoinData("ETH", selectedItem);
    String ltcData = await coinData.getCoinData("LTC", selectedItem);
    setState(() {
      btc = btcData;
      eth = ethData;
      ltc = ltcData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  $btc $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH =  $eth $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC =  $btc $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? dropDownAndroid() : cupertinoPickerIos(),
          ),
        ],
      ),
    );
  }
}
