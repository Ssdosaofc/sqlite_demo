import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_demo/screens/full_screen_view.dart';
import 'package:sqlite_demo/services/gallery_service.dart';
import 'package:sqlite_demo/utils/objects.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {

  Photo _photo = Photo();
  final GalleryService _galleryService = GalleryService();

  List<Photo> photosList = [];

  final ImagePicker picker = ImagePicker();
  File? filePath;

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    getList();
    _nameController = TextEditingController();
  }

  void _clear(){
    _nameController.clear();
    filePath = null;
  }

  showAddDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () async{
                    try{
                      _photo.name = _nameController.text;
                      _photo.base64string = base64Encode(filePath!.readAsBytesSync());
                      _photo.id = await _galleryService.insertElement(_photo);
                      var result = _photo.id;
          
                      if(result!>0) {
                        _clear();
                        Navigator.pop(context);
                        getList();
                      }
                    }catch(e){
                      print(e);
                    }
          
                  }, child: Text('Add')),
              TextButton(onPressed: (){
                _clear();
                Navigator.pop(context);
              }, child: Text('Cancel')),
            ],
            title: Text('Add Element'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (filePath== null)?Image(image: AssetImage('assets/blank.png'),height: 256,width: 256,)
                        :Image.file(filePath!,height: 256,width: 256),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () async{
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setDialogState(() { // Update UI inside the dialog
                            filePath = File(image.path);
                          });
                        }
                      }, child: Icon(Icons.add_photo_alternate),),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: () async{
                        final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          setDialogState(() {
                            filePath = File(photo.path);
                          });
                        }
                      }, child:  Icon(Icons.camera_alt_outlined))
                    ],
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Image name",
                      labelText: "Name",
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
    });
  }

  getList() async{
    photosList = [];
    List photos = await _galleryService.readElements();
    for (var photo in photos) {
      setState(() {
        var photoInstance = Photo();
        photoInstance.name = photo['name'];
        photoInstance.id = photo['id'];
        photoInstance.base64string = photo['base64string'];
        photosList.add(photoInstance);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAddDialog(context);
      },
        child: Icon(Icons.add),
      ),
      body: (photosList.isNotEmpty)?Padding(padding: EdgeInsets.all(5.0),
        child: GridView.count(crossAxisCount: 4,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: photosList.map((photo){
            return GestureDetector(
              onTap: () async{
                Navigator.push(
                    context,
                    PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)
                    => FullScreenView(photo: photo))
                );
                getList();
                },
              child: Image.memory(
                base64Decode(photo.base64string),
                fit: BoxFit.fill,
                // height: 256.0,width: 256.0,
              ),
            );
          }).toList(),
        ),
      ):Center(
        child: Text('Gallery is Empty'),
      ),
    );
  }
}
