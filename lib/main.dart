import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static final navKey = new GlobalKey<NavigatorState>();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberForm;
  double _finalNumber;
  String _startMeasure;
  String _finalMeasure;
  String errorMessage;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles'
  ];

  @override
  void initState() {
    _numberForm = 0;
    _finalNumber = 0;
    _startMeasure = 'meters';
    _finalMeasure = 'kilometers';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navKey,
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Value',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration:
                      InputDecoration(hintText: 'Please insert the measure'),
                  onChanged: (value) {
                    var rv = double.tryParse(value);
                    if (rv != null) {
                      setState(() {
                        _numberForm = rv;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'From',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: _startMeasure,
                  isExpanded: true,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasure = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'To',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: _finalMeasure,
                  isExpanded: true,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _finalMeasure = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    final context = MyApp.navKey.currentState.overlay.context;
                    setState(() {
                      convert(context);
                    });
                  },
                  child: const Text('Convert', style: TextStyle(fontSize: 14)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_finalNumber.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void viewError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void convert(BuildContext context) {
    if (_numberForm == 0) {
      errorMessage = 'Insert the Measure!';
      viewError(context);
    }
    if (_startMeasure == 'grams' && _finalMeasure != 'kilograms') {
      errorMessage = 'Incorrect selected measures';
      viewError(context);
    }
    if (_startMeasure == 'kilograms' && _finalMeasure != 'grams') {
      errorMessage = 'Incorrect selected measures';
      viewError(context);
    }
    if (_startMeasure == 'meters' && _finalMeasure == 'kilometers')
      _finalNumber = _numberForm * 0.001;
    if (_startMeasure == 'kilometers' && _finalMeasure == 'meters')
      _finalNumber = _numberForm * 1000;
    if (_startMeasure == 'grams' && _finalMeasure == 'kilograms')
      _finalNumber = _numberForm * 0.001;
    if (_startMeasure == 'kilograms' && _finalMeasure == 'grams')
      _finalNumber = _numberForm * 1000;
    if (_startMeasure == 'feet' && _finalMeasure == 'miles')
      _finalNumber = _numberForm * 0.000189394;
    if (_startMeasure == 'miles' && _finalMeasure == 'feet')
      _finalNumber = _numberForm * 5280;
    if (_startMeasure == 'meters' && _finalMeasure == 'feet')
      _finalNumber = _numberForm * 3.28084;
    if (_startMeasure == 'feet' && _finalMeasure == 'meters')
      _finalNumber = _numberForm * 0.3048;
    if (_startMeasure == 'meters' && _finalMeasure == 'miles')
      _finalNumber = _numberForm * 0.000621371;
    if (_startMeasure == 'miles' && _finalMeasure == 'meters')
      _finalNumber = _numberForm * 1609.34;
    if (_startMeasure == 'kilometers' && _finalMeasure == 'miles')
      _finalNumber = _numberForm * 0.621371;
    if (_startMeasure == 'miles' && _finalMeasure == 'kilometers')
      _finalNumber = _numberForm * 1.60934;
    if (_startMeasure == 'kilometers' && _finalMeasure == 'feet')
      _finalNumber = _numberForm * 3280.84;
    if (_startMeasure == 'feet' && _finalMeasure == 'kilometers')
      _finalNumber = _numberForm * 0.0003048;
  }
}
