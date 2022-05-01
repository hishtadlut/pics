import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:pics/src/widgets/image_list.dart';
import './models/image_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    try {
      var response = await get(
        Uri(path: 'https://jsonplaceolder.typicode.com/photos/${counter + 1}'),
      );
      var imageModel = ImageModel.fromJson(json.decode(response.body));
      setState(() {
        images.add(imageModel);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: const Text('Lets see some images'),
        ),
      ),
    );
  }
}
