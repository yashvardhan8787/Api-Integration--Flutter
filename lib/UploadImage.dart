import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import "package:http/http.dart" as http;

class uploadImage extends StatefulWidget{
  @override
  State<uploadImage> createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  File? image;
  final _imagePicker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print("no Image is selected");
    }
  }

  Future<void> upload_Image() async {
    setState(() {
      showSpinner=true;
    });
    try{
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();

      var length = await image!.length();

      var uri = Uri.parse("https://fakestoreapi.com/products");

      var request = new http.MultipartRequest("Post", uri);
      request.fields['title']="static title" ;

      var multpart = new http.MultipartFile('image', stream, length);

      var response = await request.send();

      if(response.statusCode == 200){
        setState(() {
          showSpinner=false;
        });
        print("image uploaded successfully ");
      }else{
        setState(() {
          showSpinner=false;
        });
        print("image not succsessfully uploaded ");
      }
    }catch(error){
      print(error );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("uploading images using post api"),
      ),
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center ,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null ? Center(child: Text("choose Image")):
                Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                     height:100 ,
                     width:100 ,
                     fit: BoxFit.cover ,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: (){
                upload_Image();
              },
              child: Container(
                height: 50,
                  width: 200,
                  color:Colors.green,

                child:Center(child: Text("upload image"))
              ),
            )
          ]
        ),
      )
    );
  }
}