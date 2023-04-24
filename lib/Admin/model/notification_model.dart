class NotifyModel{
  String? notifyType;
  bool? fromAdmin;
  String? notifyDate;
  String? notifyMessage;
  String? clubID;        // Todo: optional as it will have value if Admin ask user to be a leader for a specific CLub
  String? senderID;

  NotifyModel({required this.notifyDate,required this.senderID,required this.notifyType,required this.fromAdmin,required this.notifyMessage,required this.clubID});

  NotifyModel.fromJson({required json})
  {
    fromAdmin = json['fromAdmin'];
    notifyDate = json['notifyDate'];
    notifyMessage = json['notifyMessage'];
    notifyType = json['notifyType'];
    clubID = json['clubID'];
    senderID = json['senderID'];
  }

  Map<String,dynamic> toJson(){
    return
      {
      'notifyType' : notifyType,
      'fromAdmin' : fromAdmin,
      'notifyMessage' : notifyMessage,
      'clubID' : clubID,
      'notifyDate' : notifyDate,
      'senderID' : senderID
    };
  }

}