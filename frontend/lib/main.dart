import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  String items,id,rad;

  IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      connect();
    });
  }

  void connect() {
    socket = IO.io("http://192.168.29.181:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    // socket.emit("/test", "Grocery,Meds,Fruits" + _counter.toString());
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  void sendMessage(String sourceId, String message, String radius) {
    socket.emit("message",
        {"sourceId": sourceId, "List of items": message, "radius": radius});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: textController1,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Value 1 added');
                  // updateTitle();
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: textController2,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Value 2 added');
                  // updateTitle();
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "List of items",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: textController3,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Value 3 added');
                  // updateTitle();
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "Radius",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ElevatedButton(
                child: Text("Send"),
                onPressed:(){
                  setState(() {
                    debugPrint("List send");
                    sendMessage(textController1.text, 
                    textController2.text, textController3.text);

                  });
                } ,),  
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
