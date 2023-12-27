class Note{
  int? id;
  late  String title;
  late String content;
  String? date;

  Note(dynamic obj){
       id=obj['id'];
       title= obj['title'];
       content=obj['content'];
       date=obj['date'];
  }

  Note.fromMap(Map<String,dynamic>data){
    id=data['id'];
    title= data['title'];
    content=data['content'];
    date=data['date'];
  }

  Map<String,dynamic>toJson()=>{'id':id,'title':title,'content':content,'date':date};
}