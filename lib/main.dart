import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katika World',
      theme: ThemeData(
        fontFamily: "maa",
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 131)),
      ),
      home: const MyHomePage(title: 'Katika Shop'),
      debugShowCheckedModeBanner: false, //remove debug banner
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var price = TextEditingController();
  var amount = TextEditingController();
  var change = TextEditingController();
  double _total = 0;
  double _change = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text('Katika Shop',
          style: TextStyle(fontFamily: "maa", fontSize: 50, fontWeight: FontWeight.bold, backgroundColor: Color.fromARGB(255, 244, 198, 233),  fontStyle: FontStyle.italic, color: Color.fromARGB(255, 193, 58, 144)),),
          priceTextField("price per time", price),
          priceTextField("amount of time", amount),
          calculateButton(),
          showTotalText(),
          priceTextField("get money", change),
          calculateChangeButton(),
          showChangeText(),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: priceTextField("price per time"),
          ),
          calculateButton(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: priceTextField("amount of time"),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Calculate Change")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: priceTextField("get money"),
          ),*/
        ],
      )
    );
  }

  Widget priceTextField(String text, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: control,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'price per time',
        ),
      ),
    );
  }

  Widget calculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (price.text.isNotEmpty && amount.text.isNotEmpty) {
            setState(() {
              _total = double.parse(price.text) * double.parse(amount.text);
            });
          }
        }, 
        child: Text("Calculate Total")),
    );
  }

  Widget showTotalText() {
    return Text('total: $_total Baht');
  }

Widget calculateChangeButton() {
  return ElevatedButton(onPressed: () {
    if (price.text.isNotEmpty && amount.text.isNotEmpty){
      _change = double.parse(change.text) - _total;
      if(_change < 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Money is not enough")));
      } else {
        setState(() {
          //_change;
        });
      }
    }
  }, child: Text("Calculate Change"));
}

  Widget showChangeText() {
  return Text('change: $_change Baht');
  }

}
