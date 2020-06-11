import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  final _minimumpadding = 5.0;
  var _currencies = ["Rupees", "Dollar", "Pound", "Cents"];
  var _currentlyselected = '';

  @override
  initState() {
    super.initState();
    _currentlyselected = _currencies[0];
  }

  TextEditingController tecontrollerPrincipal = TextEditingController();
  TextEditingController tecontrollerRoi = TextEditingController();
  TextEditingController tecontrollerTerms = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumpadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAssets(),
            TextField(
              keyboardType: TextInputType.number,
              style: textstyle,
              controller: tecontrollerPrincipal,
              decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g 1200',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            Padding(
                padding: EdgeInsets.only(top: _minimumpadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textstyle,
                  controller: tecontrollerRoi,
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'Enter Rate of Interest',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    style: textstyle,
                    controller: tecontrollerTerms,
                    decoration: InputDecoration(
                        labelText: 'Terms',
                        hintText: 'Enter Terms',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
                  Container(width: _minimumpadding * 5),
                  Expanded(
                      child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _currentlyselected,
                    onChanged: (String newValueSelected) {
                      setState(() {
                        this._currentlyselected = newValueSelected;
                      });
                    },
                  ))
                ])),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      "Submit",
                      textScaleFactor: 1.3,
                    ),
                    onPressed: () {
                      setState(() {
                        Fluttertoast.showToast(
                            msg: _calculateRateofInterest(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Reset",
                      textScaleFactor: 1.3,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetimage = AssetImage('images/ic_crony_logo.jpg');
    Image image = Image(image: assetimage, width: 250.0, height: 125.0);

    return Container(
        child: image, margin: EdgeInsets.all(_minimumpadding * 10));
  }

  String _calculateRateofInterest() {
    double principal = double.parse(tecontrollerPrincipal.text);
    double roi = double.parse(tecontrollerRoi.text);
    double terms = double.parse(tecontrollerTerms.text);

    double interestAmt = principal + (principal * roi * terms) / 100;

    String result =
        'After $terms years, your investment will be $interestAmt $_currentlyselected';
    return result;
  }
}
