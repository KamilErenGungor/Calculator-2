import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calculator/widgets/buttondesign.dart';
import 'package:calculator/themes/theme.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int number1 = 0;
  int number2 = 0;
  String displayNumber = "";
  String transactionHistory = "";
  String result = "";
  String transactionHolder = "";

  ThemeMode currentThemeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      if (currentThemeMode == ThemeMode.light) {
        currentThemeMode = ThemeMode.dark;
      } else if (currentThemeMode == ThemeMode.dark) {
        currentThemeMode = ThemeMode.light;
      } else {
        currentThemeMode = ThemeMode.dark;
      }
    });
  }

  void btnClick(String buttonValueHolder) {
    if (buttonValueHolder == "AC") {
      displayNumber = "";
      result = "";
      number1 = 0;
      number2 = 0;
      transactionHistory = "";
      transactionHolder = "";
    } else if (buttonValueHolder == "C") {
      displayNumber = "";
      result = "";
      number1 = 0;
      number2 = 0;
    } else if (buttonValueHolder == "Back") {
      if (displayNumber.isNotEmpty) {
        result = displayNumber.substring(0, displayNumber.length - 1);
      }
    } else if (buttonValueHolder == "=") {
      number2 = int.tryParse(displayNumber) ?? 0;

      if (transactionHolder == "+") {
        result = (number1 + number2).toString();
        transactionHistory = "$number1$transactionHolder$number2";
      } else if (transactionHolder == "-") {
        result = (number1 - number2).toString();
        transactionHistory = "$number1$transactionHolder$number2";
      } else if (transactionHolder == "X") {
        result = (number1 * number2).toString();
        transactionHistory = "$number1$transactionHolder$number2";
      } else if (transactionHolder == "/") {
        if (number2 != 0) {
          result = (number1 / number2).toString();
        } else {
          result = "Error";
        }
        transactionHistory = "$number1$transactionHolder$number2";
      }
    } else if (["+", "-", "X", "/"].contains(buttonValueHolder)) {
      number1 = int.tryParse(displayNumber) ?? 0;
      result = "";
      transactionHolder = buttonValueHolder;
    } else if (buttonValueHolder == "+/-") {
      if (displayNumber.isNotEmpty) {
        if (displayNumber[0] != "-") {
          result = "-$displayNumber";
        } else {
          result = displayNumber.substring(1);
        }
      }
    } else {
      result = (displayNumber + buttonValueHolder);
    }

    setState(() {
      displayNumber = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentThemeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Builder(
        builder: (context) {
          bool isDark = Theme.of(context).brightness == Brightness.dark;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Calculator"),
              centerTitle: true,
              actions: [
                CalculatorButton(
                  text: "Theme",
                  fillcolor: Colors.black,
                  textcolor: Colors.white,
                  textsize: 18.0,
                  clicking: (_) => toggleTheme(),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: const Alignment(1.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
                    child: Text(
                      transactionHistory,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: const Alignment(1.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
                    child: Text(
                      displayNumber,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                buildButtonRow(["AC", "C", "Back", "/"], isDark),
                buildButtonRow(["9", "8", "7", "X"], isDark),
                buildButtonRow(["6", "5", "4", "-"], isDark),
                buildButtonRow(["3", "2", "1", "+"], isDark),
                buildButtonRow(["+/-", "0", "00", "="], isDark),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildButtonRow(List<String> buttons, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return CalculatorButton(
          text: text,
          fillcolor: isDark ? Colors.white : Colors.green,
          textcolor: isDark ? Colors.green : Colors.black54,
          textsize: 30.0,
          clicking: btnClick,
        );
      }).toList(),
    );
  }
}
