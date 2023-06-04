class ReportModel{
  String? reportID;
  String? reportType;
  String? clubID;
  String? clubName;
  String? senderID;
  String? pdfLink;
  bool? isAccepted;

  ReportModel.fromJson({required Map<String,dynamic> json}){
    reportID = json['reportID'];
    reportType = json['reportType'];
    clubID = json['clubID'];
    clubName = json['clubName'];
    senderID = json['senderID'];
    pdfLink = json['pdfLink'];
    isAccepted = json['isAccepted'];
  }

}