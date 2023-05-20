class NotifyModel{
  String? notifyType;
  bool? fromAdmin;
  String? receiveDate;
  String? notifyMessage;
  String? clubID;        // Todo: optional as it will have value if Admin ask user to be a leader for a specific CLub

  NotifyModel({required this.receiveDate,required this.notifyType,required this.fromAdmin,required this.notifyMessage,required this.clubID});

  Map<String,dynamic> toJson(){
    return
      {
      'notifyType' : notifyType,
      'fromAdmin' : fromAdmin,
      'notifyMessage' : notifyMessage,
      'clubID' : clubID,
      'receiveDate' : receiveDate,
    };
  }

}