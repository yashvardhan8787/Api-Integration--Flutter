import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http ;

import 'Models/UsersModels.dart';

class Examplethree extends StatefulWidget{
  @override
  State<Examplethree> createState() => _ExamplethreeState();
}

class _ExamplethreeState extends State<Examplethree> {

  List<UsersModels> users = [];

  Future<List<UsersModels>> getUserApi () async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode ==  200){
      for(Map<String ,dynamic> i in data){
        users.add(UsersModels.fromJson(i));
      }
      return users;
    }else{
      return users;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:FutureBuilder<List<UsersModels>>(
        future: getUserApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return Card(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text("yes i am  working ")
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}