class ReportModel{
  String? reportID;
  String? reportType;
  String? clubID;
  String? clubName;
  String? senderID;
  String? pdfLink;

  ReportModel.fromJson({required Map<String,dynamic> json}){
    reportID = json['reportID'];
    reportType = json['reportType'];
    clubID = json['clubID'];
    clubName = json['clubName'];
    senderID = json['senderID'];
    pdfLink = json['pdfLink'];
  }

  Map<String,dynamic> toJson(){
    return {
      'reportID' : reportID,
      'reportType' : reportType,
      'clubID' : clubID,
      'clubName' : clubName,
      'senderID' : senderID,
      'pdfLink' : pdfLink,
    };
  }

}