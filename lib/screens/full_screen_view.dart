import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/utils/objects.dart';

import '../services/gallery_service.dart';

class FullScreenView extends StatelessWidget {

  final Photo photo;
  FullScreenView({required this.photo,super.key});

  final GalleryService _galleryService = GalleryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(photo.name,style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.white,),
            onPressed: () async {
              _galleryService.deleteElement(photo.id);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
              Future.delayed(Duration(milliseconds: 100));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Image.memory(base64Decode(photo.base64string)),
      ),
    );
  }
}
