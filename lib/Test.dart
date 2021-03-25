class Test {
  final int id;
  final String date;
  final String imgPath;

  Test({this.id,this.date,this.imgPath});

  Map<String,dynamic> toMap(){
    return {
      "createdAt" : date,
      "imgPath" : imgPath
    };
  }


}