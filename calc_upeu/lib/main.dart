import 'package:flutter/material.dart';
import 'package:calc_upeu/comp/CustomAppBar.dart';
import 'package:calc_upeu/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import './comp/CalcButton.dart';
import 'dart:math' as math;
import 'dart:math';


void main() => runApp(CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({super.key}) ;
  @override
  CalcAppState createState() => CalcAppState();

}


class CalcAppState extends State<CalcApp>{


  String valorAnt = '';
  String operador = '';
  TextEditingController _controller = new TextEditingController();
  void numClick(String text) {
    setState(() => _controller.text += text);
    print(_controller);
  }
  void clear(String text) {
    setState(() {
      _controller.text = '';
    });
  }
  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
    });
  }

  void operadorClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';

      // Verifica si el operador es uno de los operadores especiales
      if (text == "√" || text == "π" || text == "x²") {
        switch (text) {
          case "√":
            _controller.text = math.sqrt(int.parse(valorAnt)).toString();
            break;
          case "π":
            _controller.text = math.pi.toString();
            break;
          case "x²":
            _controller.text = (int.parse(valorAnt) * int.parse(valorAnt)).toString();
            break;

        }
      }
    });
  }

  void accion(){
    setState(() {
      print("");
    });
  }
  void resultOperacion(String text) {
    setState(() {
      switch (operador) {
        case "/":
          _controller.text =
              (int.parse(valorAnt) / int.parse(_controller.text)).toString();
          break;
        case "*":
          _controller.text =
              (int.parse(valorAnt) * int.parse(_controller.text)).toString();
          break;
        case "+":
          _controller.text =
              (int.parse(valorAnt) + int.parse(_controller.text)).toString();
          break;
        case "-":
          _controller.text =
              (int.parse(valorAnt) - int.parse(_controller.text)).toString();
          break;
        case "%":
          _controller.text =
              (int.parse(valorAnt) % int.parse(_controller.text)).toString();
          break;


        case "^":
          _controller.text =
              math.pow(int.parse(valorAnt), int.parse(_controller.text))
                  .toString();
          break;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    //Aqui codigo
    List<List> labelList = [["√","π","x²","^"], ["AC","C","%","/"], ["7","8","9","*"],["4","5","6","-"],["1","2","3","+"],[".","0","00","="]];
    List<List> funx=[[operadorClick,operadorClick, operadorClick,opeClick ],
      [clear,clear, opeClick,opeClick ],
      [numClick,numClick, numClick,opeClick ],
      [numClick,numClick, numClick,opeClick ],
      [numClick,numClick, numClick,opeClick ],
      [numClick,numClick, numClick,resultOperacion ]];

    AppTheme.colorX=Colors.blue;
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion as Function),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
/*color:
Theme.of(context).colorScheme.surfaceVariant,*/
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                ),
              ),




                SizedBox(height: 20),
                  ...List.generate(labelList.length, (index) =>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                        labelList[index].length,
                            (indexx) => CalcButton(
                          text: labelList[index][indexx],
                          callback: funx[index][indexx] as Function,
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),

    );
  }

}


