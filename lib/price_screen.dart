import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; //for checting platform IOS/Android

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //L2- 6: Update the default currency to AUD, the first item in the currencyList.
  String selectedCurrecy = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrecy,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrecy = value!;
          //L2 -2: Call getData() when the picker/dropdown changes.
          getData();
        });
      },
    );
  }

  CupertinoPicker IOSPicker() {
    List<Text> pickerItems = [];
    for (var currency in currenciesList) {
      var item = Text(currency);
      pickerItems.add(item);
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            //L2 -1: Save the selected currency to the property selectedCurrency
            selectedCurrecy = currenciesList[selectedIndex];
            //L2 -2: Call getData() when the picker/dropdown changes.
            getData();
          });
        },
        children: pickerItems);
  }

  // instead of this method you can use ternory operator where you use
  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return IOSPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidDropdown();
  //   } else {
  //     // else if it not IOS or Android
  //     return androidDropdown();
  //   }
  // }

  double bitcoinValue = 0;
  double ETHvalue = 0;
  double LTCvalue = 0;
  //L1: Create a method here called getData() to get the coin data from coin_data.dart
  void getData() async {
    CoinData coindata = CoinData();
    try {
      Map data = await coindata.getCoinData(selectedCurrecy);
      setState(() {
        ////////////////////////////
        bitcoinValue = (data["BTC"]);
        ETHvalue = (data["ETH"]);
        LTCvalue = (data["LTC"]);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //L1: Call getData() when the screen loads up.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                  cryptoCurrency: "BTC",
                  value: bitcoinValue.toStringAsFixed(0),
                  selectedCurrecy: selectedCurrecy),
              CryptoCard(
                  cryptoCurrency: "ETH",
                  value: ETHvalue.toStringAsFixed(0),
                  selectedCurrecy: selectedCurrecy),
              CryptoCard(
                  cryptoCurrency: "LTC",
                  value: LTCvalue.toStringAsFixed(0),
                  selectedCurrecy: selectedCurrecy),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {Key? key,
      required this.value,
      required this.selectedCurrecy,
      required this.cryptoCurrency})
      : super(key: key);

  final String value;
  final String selectedCurrecy;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 4.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //L1: Update the Text Widget with the live bitcoin data here.
            //L2 -5: Update the currency name depending on the selectedCurrency.
            '1 $cryptoCurrency = ${value} $selectedCurrecy',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
