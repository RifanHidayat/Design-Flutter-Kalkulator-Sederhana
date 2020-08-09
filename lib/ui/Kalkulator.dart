import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';



class Kalkulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,

            style: TextStyle(

//                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children:<Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(50, 150, 10, 0),
                      child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
                    ),




                    Expanded(
                      child: Divider(),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Table(
                            children: [
                              TableRow(
                                  children: [
                                    buildButton("C", 1, Colors.redAccent),
                                    buildButton("⌫", 1, Colors.blue),
                                    buildButton("÷", 1, Colors.blue),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("7", 1, Colors.black54),
                                    buildButton("8", 1, Colors.black54),
                                    buildButton("9", 1, Colors.black54),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("4", 1, Colors.black54),
                                    buildButton("5", 1, Colors.black54),
                                    buildButton("6", 1, Colors.black54),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("1", 1, Colors.black54),
                                    buildButton("2", 1, Colors.black54),
                                    buildButton("3", 1, Colors.black54),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton(".", 1, Colors.black54),
                                    buildButton("0", 1, Colors.black54),
                                    buildButton("00", 1, Colors.black54),
                                  ]
                              ),
                            ],
                          ),
                        ),


                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Table(
                            children: [
                              TableRow(
                                  children: [
                                    buildButton("×", 1, Colors.blue),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("-", 1, Colors.blue),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("+", 1, Colors.blue),
                                  ]
                              ),

                              TableRow(
                                  children: [
                                    buildButton("=", 2, Colors.redAccent),
                                  ]
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}