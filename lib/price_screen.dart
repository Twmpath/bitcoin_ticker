import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();

  @override
  void initState() {
    print('initState called');
    // Set up the data for the initial selected currency
    // This function should return data to use but cannot add async directly
    // So make an anonymous async with some foul syntax
    () async {
//      print('Call from initState');
      await coinData.getCoinData(selectedCurrency);
//      print('getCoinData returned ${coinData}');
      setState(() {
//        print('setState from initState');
      });
      
    } ();
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropdownList() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }
  List<Text> getPickerItems() {
    List<Text> pickerItemsList = [];
    for (String pickerItem in currenciesList) {
      pickerItemsList.add(Text(pickerItem));
    }
    return pickerItemsList;
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        await coinData.getCoinData(selectedCurrency);
        setState(() {
        });
      },
      children: getPickerItems(),
    );
  }
  DropdownButton<String> androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: buildDropdownList(),
      onChanged: (selectedIndex) async {
        selectedCurrency = selectedIndex != null ? selectedIndex : 'USD';
        await coinData.getCoinData(selectedCurrency);
        setState(() {
        });
      },
    );
  }
  Widget getPicker() {
    Widget picker = androidPicker();
    if(Platform.isIOS) {
      picker = iOSPicker();
    }
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      '${kBtcText}${coinData.cryptoPrice[0].toStringAsFixed(2)} ${selectedCurrency}',
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
                      '${kEthText}${coinData.cryptoPrice[1].toStringAsFixed(2)} ${selectedCurrency}',
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
                      '${kLtcText}${coinData.cryptoPrice[2].toStringAsFixed(2)} ${selectedCurrency}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
