class Student{
  int? id;
  late String name;
  late int age;

  studentMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['age'] = age;

    return mapping;
  }
}

class Photo{
  int? id;
  late String name;
  late String base64string;

  photoMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['base64string'] = base64string;

    return mapping;
  }
}

