class TaskModel{
  String? id;
  String? description;
  int? hours;
  int? numOfPosition;
  bool? states;
  String? clubName;
  String? clubID;

  TaskModel({required this.id,required this.description,required this.states,required this.hours,required this.clubID,required this.clubName,required this.numOfPosition});

  TaskModel.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    hours = json['hours'];
    description = json['description'];
    states = json['states'];
    numOfPosition = json['numOfPosition'];
    clubID = json['clubID'];
    clubName = json['clubName'];
  }

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'description' : description,
      'states' : states,
      'numOfPosition' : numOfPosition,
      'hours' : hours,
      'clubID' : clubID,
      'clubName' : clubName,
    };
  }
}