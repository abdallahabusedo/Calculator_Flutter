import 'package:flutter/material.dart';
import 'MyButton.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {runApp(MaterialApp(
  home: calculator() ,
));
}

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  var input = "" ;
  var answer = "";
  final List<String> buttons = [
    'C','+/-','%','DEL',
    '7','8','9','/',
    '4','5','6','x',
    '1','2','3','-',
    '0','.','=', '+',
  ];

  @override
  Widget build(BuildContext context) {return Scaffold(


    appBar: new AppBar(
      title: new Text("Calculator"),
    ),

    backgroundColor: Colors.black,
    body: Column(
      children: <Widget>[
        // result
        // answer
        Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    input,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                )
              ],
          ),
        )),
        // first row c +/- % del
        Expanded(
        flex: 3,
          child: Container(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
              ),
              itemBuilder: (BuildContext context, int index){
                // Clear Button
                if (index == 0) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        input = '';
                        answer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[500],
                    textColor: Colors.black,
                  );

                }
                // +/- button
                else if (index == 1) {
                  return MyButton(
                    buttonText: buttons[index],
                    color: Colors.grey[500],
                    textColor: Colors.black,
                  );
                }
                // % Button
                else if (index == 2) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        input += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[500],
                    textColor: Colors.black,
                  );
                }
                // Delete Button
                else if (index == 3) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        input =
                            input.substring(0, input.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange[500],
                    textColor: Colors.white,
                  );
                }
                // Equal_to Button
                else if (index == 18) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange[500],
                    textColor: Colors.white,
                  );
                }

                //  other buttons
                else {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        input += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.orange[500]
                        : Colors.grey[800],
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.white,
                  );
                }
              }
        ))
        )],
    ),
  );
  }
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finalInput = input;
    finalInput = input.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
