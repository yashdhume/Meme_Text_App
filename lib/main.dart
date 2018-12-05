import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.cyan[600],
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();
  String memeText="";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }
  String meme(String s){
    // setState(() {
    Clipboard.setData(new ClipboardData(text:" "));
    for (int i = 0; i < s.length; i++) {
      if (i % 2 == 0) {
        memeText += s.substring(i, i + 1).toUpperCase();
      } else {
        memeText += s.substring(i, i + 1);
      }
    }
    return memeText;
    // });
  }
  void  changeText(String text){
    setState(() {
      text = memeText;
      text = "";
      memeText="";
      Clipboard.setData(new ClipboardData(text: (" ")));
    });
  }

  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Meme Text"),
        ),
        body: new Center(

          child: new Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                child: new CustomToolTip(text: ((meme((myController.text)).toString()))),
                onTap: () {

                },
              ),
              new Flexible(
                  child: new TextField(
                    decoration: new InputDecoration(
                      //fillColor: Colors.white,
                        hintText: 'Enter Text to Memeafy'
                    ),
                    keyboardType: TextInputType.text,
                    controller: myController,
                    onChanged:(text){
                      changeText(text);
                    },
                  )
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),

            ],
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class CustomToolTip extends StatelessWidget {

  String text;

  CustomToolTip({this.text});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(preferBelow: false,
          message: "Copy", child: new Text(text)),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: text));
      },
    );
  }
}