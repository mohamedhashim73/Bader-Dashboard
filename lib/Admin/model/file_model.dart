class ReportModel{
  String? pdfUrl;
  String? id;
  String? title;
  String? clubName;

  ReportModel({required this.pdfUrl,required String title,required this.id,required this.clubName});

  ReportModel.fromJson({required Map<String,dynamic> json}){
    pdfUrl = json['pdfUrl'];
    title = json['title'];
    id = json['title'];
    clubName = json['clubName'];
  }

  Map<String,dynamic> toJson(){
    return {
      'pdfUrl' : pdfUrl,
      'title' : title,
      'id' : id,
      'clubName' : clubName
    };
  }

}