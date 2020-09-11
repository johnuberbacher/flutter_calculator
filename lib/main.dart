import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(new MyApp());

bool isSwitched = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Exam Prep',
            theme: theme,
            home: new MyHomePage(title: 'Flutter Calculator'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void themeSwitch(context, value) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
    setState(() {
      isSwitched = value;
      print(isSwitched);
    });
  }

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already conatains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget calculatorButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 32.0,
        ),
        child: new Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Widget equalsButton(String buttonText) {
    return new Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color(0xFF608efc),
                    const Color(0xFF453caa)
                  ], // whitish to gray
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color(0xFFff9a61),
                    const Color(0xFFd67c9b)
                  ], // whitish to gray
                ),
        ),
        child: new OutlineButton(
          padding: new EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: new Text(
            ("="),
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          onPressed: () => buttonPressed("="),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          backgroundColor: Color(0x00000000),
          elevation: 0,
          title: new Switch(
            value: isSwitched,
            onChanged: (value) => themeSwitch(context, value),
            activeTrackColor: Colors.white54,
            activeColor: Colors.white,
          ),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                  decoration: BoxDecoration(
                    gradient: Theme.of(context).brightness == Brightness.dark
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: [
                              const Color(0xFF608efc),
                              const Color(0xFF453caa)
                            ], // whitish to gray
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: [
                              const Color(0xFFff9a61),
                              const Color(0xFFd67c9b)
                            ], // whitish to gray
                          ),
                  ),
                  alignment: Alignment.bottomRight,
                  padding: new EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: new Text(output,
                      style: new TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ))),
            ),
            new Container(
                decoration: BoxDecoration(
                  gradient: Theme.of(context).brightness == Brightness.dark
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8,
                              0.0), // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xFF37498f),
                            const Color(0xFF1c1b48)
                          ], // whitish to gray
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8,
                              0.0), // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xFFFFFFFF),
                            const Color(0xFFFFFFFF)
                          ], // whitish to gray
                        ),
                ),
                child: new Column(children: [
                  new Row(children: [
                    calculatorButton("7"),
                    calculatorButton("8"),
                    calculatorButton("9"),
                    calculatorButton("X"),
                  ]),
                  new Row(children: [
                    calculatorButton("4"),
                    calculatorButton("5"),
                    calculatorButton("6"),
                    calculatorButton("/"),
                  ]),
                  new Row(children: [
                    calculatorButton("1"),
                    calculatorButton("2"),
                    calculatorButton("3"),
                    calculatorButton("-"),
                  ]),
                  new Row(children: [
                    calculatorButton("0"),
                    calculatorButton("."),
                    calculatorButton("+"),
                    equalsButton("="),
                  ]),
                  new Row(children: [
                    calculatorButton("AC"),
                  ])
                ])),
          ],
        )));
  }
}
