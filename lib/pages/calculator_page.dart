import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _calculatorFormKey = GlobalKey<FormState>();

  int total = 0;
  final _number1TextController = TextEditingController();
  final _number2TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator Page"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _calculatorFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _number1TextController,
                    validator: (number) {
                      if (number == null) {
                        return null;
                      }

                      if (number.isEmpty) {
                        return 'Please enter a number';
                      }

                      var value = int.tryParse(number);
                      if (value == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Number 1",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  TextFormField(
                    controller: _number2TextController,
                    validator: (number) {
                      if (number == null) {
                        return null;
                      }

                      if (number.isEmpty) {
                        return 'Please enter a number';
                      }

                      var value = int.tryParse(number);
                      if (value == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Number 2",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text("=",   style: TextStyle(
                fontSize: 20
            ))),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text("$total",
              style: const TextStyle(
                fontSize: 25
              ),),
            ),
            ElevatedButton(
              onPressed: () {
                if (_calculatorFormKey.currentState!.validate()) {
                  var number1 = int.tryParse(_number1TextController.text);
                  var number2 = int.tryParse(_number2TextController.text);
                  if(number1 != null && number2 != null){
                    setState((){
                      total = number1 + number2;
                    });
                  }

                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Text('Add', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_calculatorFormKey.currentState!.validate()) {
                  var number1 = int.tryParse(_number1TextController.text);
                  var number2 = int.tryParse(_number2TextController.text);
                  if(number1 != null && number2 != null){
                    setState((){
                      total = number1 - number2;
                    });
                  }

                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Text('Subtract', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
