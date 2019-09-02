import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

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
  List<String> dogImages = new List();

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatch_five();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        {
          fatch_five();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            controller: _scrollController,
            itemCount: dogImages.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Image.network(
                  dogImages[index],
                  fit: BoxFit.fitWidth,
                ),
              );
            }));
  }

  void fatch() async {
    try {
      var url = 'https://dog.ceo/api/breeds/image/random';
      Response response = await get(url);
      if (response.statusCode == 200) {
        setState(() {
          dogImages.add(json.decode(response.body)['message']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void fatch_five() {
    for (int i = 0; i < 5; i++) {
      fatch();
    }
  }
}
