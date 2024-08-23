import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photo> photoList = [];

  Future<List<Photo>> getPhotos() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List<Photo> photos = [];
      for (var i in data) {
        Photo photo = Photo(title: i["title"], url: i["url"]);
        photos.add(photo);
      }
      return photos;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getPhotos().then((photos) {
      setState(() {
        photoList = photos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Two: API Integration"),
      ),
      body: photoList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(photoList[index].url),
            title: Text(photoList[index].title),
          );
        },
      ),
    );
  }
}

class Photo {
  final String title;
  final String url;

  Photo({
    required this.title,
    required this.url,
  });
}
