import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileOperator extends StatefulWidget {

  // constructor
  FileOperator({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FileOperatorState();
  }
}

class _FileOperatorState extends State<FileOperator> {

  int _counter;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Demo file io"),),
      body: Center(
        child: Text("Hit $_counter times.", style: TextStyle(fontSize: 24),),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: "Hi hit me",
      child: Icon(Icons.add),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Read hit counter from file
    _readcounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });

  }

  // ====================================================
  //  private method
  // ====================================================
  Future<File> _getLocalFile() async {
    // get app dir
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File("$dir/counter.txt");
  }

  Future<int> _readcounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      Fluttertoast.showToast(msg: "readcounter: file system exception");
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    // write counter to file
    await (await _getLocalFile()).writeAsStringSync("$_counter");

  }

}