import 'package:sqlite_demo/repositories/gallery_repo.dart';
import 'package:sqlite_demo/utils/objects.dart';

import '../repositories/table_repo.dart';

class GalleryService{
  late GalleryRepository _repository;
  String table = 'images';

  GalleryService(){
    _repository = GalleryRepository();
  }

  insertElement(Photo photo) async{
    return await _repository.insertData(table, photo.photoMap());
  }

  readElements() async{
    return await _repository.readData(table);
  }

  deleteElement(categoryId) async{
    return await _repository.deleteData(table,categoryId);
  }
}