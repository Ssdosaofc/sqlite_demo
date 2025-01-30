import 'package:sqlite_demo/utils/objects.dart';
import 'package:sqlite_demo/repositories/table_repo.dart';

class TableService{
  late TableRepository _repository;
  String table = 'students';

  TableService(){
    _repository = TableRepository();
  }

  insertElement(Student student) async{
    return await _repository.insertData(table, student.studentMap());
  }

  readElements() async{
    return await _repository.readData(table);
  }

  readElementById(categoryId) async{
    return await _repository.readDataById(table, categoryId);
  }

  updateElement(Student student) async{
    return await _repository.updateData(table,student.studentMap());
  }

  deleteElement(categoryId) async{
    return await _repository.deleteData(table,categoryId);
  }
}

