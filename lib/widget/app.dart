import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String _userInput = '';
  String _answer = '0';

  final List<String> _buttons = const [
    'AC',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(95, 61, 61, 61),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    _userInput,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    _answer,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: _buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                final button = _buttons[index];
                switch (button) {
                  case 'AC':
                    return MyButton(
                      buttonText: button,
                      color: const Color.fromARGB(95, 61, 61, 61),
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      buttontapped: () {
                        setState(() {
                          _userInput = '';
                          _answer = '0';
                        });
                      },
                    );

                  case 'DEL':
                    return MyButton(
                      buttonText: button,
                      color: const Color.fromARGB(95, 61, 61, 61),
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      buttontapped: () => setState(() {
                        if (_userInput.isNotEmpty) {
                          _userInput =
                              _userInput.substring(0, _userInput.length - 1);
                        }
                      }),
                    );
                  case '=':
                    return MyButton(
                      buttonText: button,
                      color: Colors.orange[700],
                      textColor: Colors.white,
                      buttontapped: () => setState(() {
                        _equalPressed();
                      }),
                    );
                  default:
                    return MyButton(
                      buttonText: button,
                      color: isOperator(button)
                          ? const Color.fromARGB(95, 61, 61, 61)
                          : const Color.fromARGB(95, 78, 78, 78),
                      textColor: isOperator(button)
                          ? Colors.white
                          : const Color.fromARGB(255, 255, 255, 255),
                      buttontapped: () => setState(() {
                        _userInput += button;
                      }),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String button) {
    return button == '/' ||
        button == 'x' ||
        button == '-' ||
        button == '+' ||
        button == '+/-' ||
        button == "%";
  }

  void _equalPressed() {
    final userInput = _userInput.replaceAll('x', '*');
    final parser = Parser();
    final exp = parser.parse(userInput);
    final cm = ContextModel();
    final eval = exp.evaluate(EvaluationType.REAL, cm);
    _answer = eval.toString();
  }
}
