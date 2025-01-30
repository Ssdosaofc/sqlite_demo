import 'package:flutter/material.dart';
import 'package:sqlite_demo/services/table_service.dart';
import 'package:sqlite_demo/utils/objects.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _editNameController;
  late TextEditingController _editAgeController;

  Student _student = Student();
  final TableService _tableService = TableService();

  List<Student> studentsList = [];

  var student;

  @override
  void initState() {
    super.initState();
    //TODO: Initialize list
    // getList();
    _nameController = TextEditingController();
    _ageController = TextEditingController();

    _editNameController = TextEditingController();
    _editAgeController = TextEditingController();
  }

  //TODO: Load/Refresh list each time
  // getList() async{
  //   studentsList = [];
  //   List students = await _tableService.readElements();
  //   for (var student in students) {
  //     setState(() {
  //       var studentInstance = Student();
  //       studentInstance.name = student['name'];
  //       studentInstance.age = student['age'];
  //       studentInstance.id = student['id'];
  //       studentsList.add(studentInstance);
  //     });
  //   }
  // }

  void _clear(){
    _nameController.clear();
    _ageController.clear();
    _editNameController.clear();
    _editAgeController.clear();
  }

  //TODO: Add element
  // showAddDialog(BuildContext context){
  //   return showDialog(context: context, barrierDismissible: true, builder: (param){
  //      return AlertDialog(
  //        actions: [
  //          TextButton(
  //              onPressed: () async{
  //                try{
  //                  _student.name = _nameController.text;
  //                  _student.age = int.parse(_ageController.text);
  //                  _student.id = await _tableService.insertElement(_student);;
  //                  var result = _student.id;
  //
  //                  if(result!>0) {
  //                    _clear();
  //                    Navigator.pop(context);
  //                    getList();
  //                  }
  //                }catch(e){
  //                  print(e);
  //                }
  //
  //          }, child: Text('Add')),
  //          TextButton(onPressed: (){
  //            _clear();
  //            Navigator.pop(context);
  //          }, child: Text('Cancel')),
  //        ],
  //        title: Text('Add Element'),
  //        content: SingleChildScrollView(
  //          child: Column(
  //            children: [
  //              TextField(
  //                controller: _nameController,
  //                decoration: InputDecoration(
  //                  hintText: "Enter name",
  //                  labelText: "Name",
  //                ),
  //              ),
  //              TextField(
  //                controller: _ageController,
  //                keyboardType: TextInputType.number,
  //                decoration: InputDecoration(
  //                  hintText: "Enter age",
  //                  labelText: "Age",
  //                ),
  //              ),
  //            ],
  //          ),
  //        ),
  //      );
  //   });
  // }

  //TODO: Edit element
  // editElement(BuildContext context, id) async {
  //   student = await _tableService.readElementById(id);
  //   setState(() {
  //     _editNameController.text = student[0]['name']??'No Name';
  //     _editAgeController.text = student[0]['age'].toString();
  //   });
  //   showEditDialog(context);
  // }

  // showEditDialog(BuildContext context){
  //   return showDialog(context: context, barrierDismissible: true, builder: (param){
  //     return AlertDialog(
  //       actions: [
  //         TextButton(
  //             onPressed: () async{
  //               try{
  //                 _student.id = student[0]['id'];
  //                 _student.name = _editNameController.text;
  //                 _student.age = int.parse(_editAgeController.text);
  //
  //                 print(_student.studentMap());
  //
  //                 var result = await  _tableService.updateElement(_student);
  //
  //                 if(result>0) {
  //                   _clear();
  //                   Navigator.pop(context);
  //                   getList();
  //                 }
  //               }catch(e){
  //                 print(e);
  //               }
  //
  //             }, child: Text('Update')),
  //         TextButton(onPressed: (){
  //           _clear();
  //           Navigator.pop(context);
  //         }, child: Text('Cancel')),
  //       ],
  //       title: Text('Edit Element'),
  //       content: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             TextField(
  //               controller: _editNameController,
  //               decoration: InputDecoration(
  //                 hintText: "Edit name",
  //                 labelText: "Name",
  //               ),
  //             ),
  //             TextField(
  //               controller: _editAgeController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 hintText: "Edit age",
  //                 labelText: "Age",
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  //TODO: Delete element
  // showDeleteDialog(BuildContext context, id){
  //   return showDialog(context: context, barrierDismissible: true, builder: (param){
  //     return AlertDialog(
  //       actions: [
  //         TextButton(
  //             onPressed: () async{
  //               try{
  //
  //                 var result = await  _tableService.deleteElement(id);
  //
  //                 if(result>0) {
  //                   Navigator.pop(context);
  //                   getList();
  //                 }
  //               }catch(e){
  //                 print(e);
  //               }
  //
  //             }, child: Text('Delete')),
  //         TextButton(onPressed: (){
  //           Navigator.pop(context);
  //         }, child: Text('Cancel')),
  //       ],
  //       title: Text('Delete Element'),
  //       content: Text('Are you sure you want to delete button?'),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        //TODO: Implement add function
        // showAddDialog(context);
      },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: studentsList.isNotEmpty?
        ListView.builder(itemCount: studentsList.length,
            itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: IconButton(onPressed: (){
                  //TODO: Implement edit function
                  // editElement(context, studentsList[index].id);
                }, icon: Icon(Icons.edit)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(studentsList[index].name),
                    IconButton(onPressed: (){
                      //TODO: Implement delete function
                      // showDeleteDialog(context,studentsList[index].id);
                    }, icon: Icon(Icons.delete))
                  ],
                ),
                subtitle: Text('Age: ${studentsList[index].age}'),
              ),
            ),
          );
        }):Center(
          child: Text("Add elements by clicking on the + button"),
        ),
      ),
    );
  }
}
