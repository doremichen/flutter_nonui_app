import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HttpDemoState();
  }

}

class _HttpDemoState extends State<HttpDemo> {

  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo http")),
      body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Google", style: TextStyle(fontSize: 24),),
                onPressed: _loading? null: () async {
                  setState(() {
                    _loading = true;
                    _text = "Loading ...";
                  });

                  try {
                    // Build http client
                    HttpClient httpClient = HttpClient();

                    // Open http connect
                    HttpClientRequest request = await httpClient.getUrl(
                        Uri.parse("https://www.google.com"));


                    // Waite for http connect
                    HttpClientResponse response = await request.close();

                    // response text
                    _text = await response.transform(utf8.decoder).join();

                    // show response header
                    Fluttertoast.showToast(msg: response.headers.toString());
                    print(response.headers);

                    // close http client
                    httpClient.close();
                  } catch(e) {
                    _text = "Reauest fail: $e";
                  } finally {
                    setState(() {
                      _loading = false;
                    });
                  }

                },
              ),
              Container(
                width: MediaQuery.of(context).size.width-50.0,
                child: Text(_text.replaceAll(RegExp(r"\s"), ""), style: TextStyle(fontSize: 12),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}