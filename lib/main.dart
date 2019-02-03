import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

typedef ActionCallBack = void Function(Key key);
typedef KeyCallBack = void Function(Key key);

const Color primaryColor = const Color(0xff50E3C2);
const Color keypadColor = const Color(0xff4A4A4A);


class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key _actionKey;
  Key _plusKey = Key('plus');
  Key _minusKey = Key('minus');
  Key _multiplyKey = Key('multiply');
  Key _divideKey = Key('divide');
  Key _sevenKey = Key('seven');
  Key _eightKey = Key('eight');
  Key _nineKey = Key('nine');
  Key _fourKey = Key('four');
  Key _fiveKey = Key('five');
  Key _sixKey = Key('six');
  Key _oneKey = Key('one');
  Key _twoKey = Key('two');
  Key _threeKey = Key('three');
  Key _dotKey = Key('dot');
  Key _zeroKey = Key('zero');
  Key _clearKey = Key('clear');
  Key _allClearKey = Key('allclear');
  Key _equalsKey = Key('equals');

  var height;
  var width;
  List _currentValues = List();
  double lastValue;
  TextEditingController _textEditingController;
  bool savedLastValue = false;

  void onActionTapped(Key actionKey) {
    setState(() {
      _actionKey = actionKey;

      if (_currentValues.isNotEmpty) {
        lastValue = double.parse(convertToString(_currentValues));
      }
    });
  }

  void onKeyTapped(Key key) {

    if (savedLastValue == false && lastValue != null) {
      _currentValues.clear();
      savedLastValue = true;
    }
    setState(() {
      if (identical(_sevenKey, key)) {
        _currentValues.add('7');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_eightKey, key)) {
        _currentValues.add('8');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_nineKey, key)) {
        _currentValues.add('9');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_fourKey, key)) {
        _currentValues.add('4');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_fiveKey, key)) {
        _currentValues.add('5');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_sixKey, key)) {
        _currentValues.add('6');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_oneKey, key)) {
        _currentValues.add('1');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_twoKey, key)) {
        _currentValues.add('2');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_threeKey, key)) {
        _currentValues.add('3');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_dotKey, key)) {
        if (!_currentValues.contains('.')) {
          _currentValues.add('.');
        } 
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_zeroKey, key)) {
        _currentValues.add('0');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_clearKey, key)) {
        print('Values :: $_currentValues'); 
        _currentValues.removeLast();
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_allClearKey, key)) {
        _currentValues.clear();
        lastValue = null;
        savedLastValue = false;
        _textEditingController.clear();
      } else if (identical(_equalsKey, key)) {
        calculateValue();
        savedLastValue = false;
      }
    });
  }

  String validateDouble(double doubleValue) {
    int value;
    if (doubleValue % 1 == 0) {
      value = doubleValue.toInt();
    } else {
      return doubleValue.toStringAsFixed(1);
    }
    return value.toString();
  }

  void calculateValue() {
    String value;
    double doubleValue;
    if (identical(_actionKey, _plusKey)){
      doubleValue = Math.add(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      print('Value after conversion : $value');
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _minusKey)) {
      doubleValue = Math.subtract(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _multiplyKey)) {
      doubleValue = Math.multiply(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _divideKey)) {
      doubleValue = Math.divide(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    }
  }

  String convertToString(List values) {
    String val = '';
    print(_currentValues);
    for (int i = 0;i < values.length;i++) {
      val+=_currentValues[i];
    }
    return val;
  }

  List convertToList(String value) {
    List list = new List();
    for(int i = 0;i < value.length;i++) {
      list.add(String.fromCharCode(value.codeUnitAt(i)));
    }
    return list;
}

  void initState() { 
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    debugPrint('Width :: $width and Height :: $height');  
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: width,
            height: (height/100)*20,
            child: IgnorePointer(
                child: TextField(  
                enabled: true,
                autofocus: true,
                controller: _textEditingController,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontSize: 60.0,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: '0',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0
                  )
                ),              ),
            ),
          ),
          Row(
            children: <Widget>[
              buildActionButton('+', _plusKey),
              buildActionButton('-', _minusKey),
              buildActionButton('x', _multiplyKey),
              buildActionButton('/', _divideKey)
            ],
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(30.0),
                color: Colors.white,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('7', _sevenKey),
                          buildKeyItem('8',_eightKey),
                          buildKeyItem('9',_nineKey),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('4',_fourKey),
                          buildKeyItem('5',_fiveKey),
                          buildKeyItem('6',_sixKey),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('1',_oneKey),
                          buildKeyItem('2',_twoKey),
                          buildKeyItem('3',_threeKey),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('.',_dotKey),
                          buildKeyItem('0',_zeroKey),
                          KeyItem(
                            key: _clearKey,
                            child: Icon(
                              Icons.backspace,
                              size: 40,
                              color: keypadColor,
                            ),
                            onKeyTap: onKeyTapped,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('ac',_allClearKey),
                          buildKeyItem(' ',Key('')),
                          KeyItem(
                            key: _equalsKey,
                            onKeyTap: onKeyTapped,
                            child: Text(
                              '=',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 80.0,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    color: primaryColor,
                                    spreadRadius: 30.0
                                  )
                                ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }

  ActionButton buildActionButton(String name , Key key) {
    return ActionButton(
      key: key,
      actionName: name,
      onTapped: onActionTapped,
      enabled: identical(_actionKey, key) ? true : false,
      padding: height > 600 ? EdgeInsets.all(10.0) : EdgeInsets.all(0.0),
    );
  }

  KeyItem buildKeyItem(String val, Key key) {
    return KeyItem(
      key: key,
      child: Text(
        val,
        style: TextStyle(
          color: keypadColor,
          fontFamily: 'Avenir',
          fontStyle: FontStyle.normal,
          fontSize: 50.0,
        ),
      ),
      onKeyTap: onKeyTapped,
    );
  }
}


class ActionButton extends StatelessWidget {

  final Color defaultBackground = Colors.transparent;
  final Color defaultForeground = primaryColor;
  final Color changedBackground = primaryColor;
  final Color changedForeground = Colors.white;

  final String actionName;
  final bool enabled;
  final ActionCallBack onTapped;
  final Key key;
  final EdgeInsets padding;

  ActionButton({@required this.actionName,this.onTapped,this.enabled,this.key,this.padding}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: padding ?? EdgeInsets.all(0.0),
                color: Color(0xffF6F6F6),
                child: GestureDetector(
                  onTap: () {
                    onTapped(key);
                  },                
                  child: CircleAvatar(
                    backgroundColor: enabled ? changedBackground : defaultBackground,
                    radius: 30,
                    child: Text(
                      actionName,
                      style: TextStyle(
                        color: enabled ? changedForeground : defaultForeground,
                        fontSize: 40.0,
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
  }

}

class KeyItem extends StatelessWidget {

  final Widget child;
  final Key key;
  final KeyCallBack onKeyTap;

  KeyItem({@required this.child,this.key,this.onKeyTap});

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Expanded(
        child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          splashColor: primaryColor,
          highlightColor: Colors.white,
          onTap: () => onKeyTap(key),
          child: Container(
            //color: Colors.white,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class Math {

  static double add(double val1, val2) {
    return val1+val2;
  }

  static double subtract(double val1,val2) {
    return val1 - val2;
  }

  static double multiply(double val1, double val2) {
    return val1*val2;
  }

  static double divide(double val1, double val2) {
    return val1/val2;
  }
}