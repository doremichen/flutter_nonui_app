///
/// This is shared preference demo
///

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoSharedPref extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _DemoSharedPrefState();
  }

}

class _DemoSharedPrefState extends State<DemoSharedPref> {

  static final String KEY_DHARED_PREF_1 = "key1";

  // edit controller
  final TextEditingController _controller = TextEditingController();
  // show result
  String _showResult = "No data";


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text("Demo shared preference"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Input
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Please input data..."
              ),
            ),
            RaisedButton(
              child: Text("Save data to shared pref file"),
              onPressed: () {
                _saveData(_controller.text);
                Fluttertoast.showToast(msg: "Save data to shared pref");
              },
            ),
            RaisedButton(
              child: Text("Get data from shared pref file"),
              onPressed: () {
                getData().then((result) {
                  _showResult = result;
                });

                // Update UI
                setState(() {

                });

                Fluttertoast.showToast(msg: "Get data from shared pref");
              },
            ),
            Text("Result: $_showResult"),
          ],
        ),
      ),
    );
  }


  //
  // As following are private
  //
  _saveData(String data) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedData = data?? "default data";
    // save data to shared preference file
    await prefs.setString(KEY_DHARED_PREF_1, savedData);

  }

  Future<String> getData() async {
    String ret = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    ret = prefs.getString(KEY_DHARED_PREF_1);

    return ret?? "Default data";
  }

}