abstract class DashBoardStates{}

class DashboardInitialState extends DashBoardStates{}

class ChooseCollegeState extends DashBoardStates{}

class GetClubsWithoutLeaderSuccessState extends DashBoardStates{}

class GetUsersDataSuccessState extends DashBoardStates{}
class ChooseALeaderSuccessState extends DashBoardStates{}

// Club from Assign leader to it
class ChooseClubNameSuccessState extends DashBoardStates{}

// Todo: Select Pdf ( While Uploading Report Info ro Firestore )
class SelectPdfSuccessState extends DashBoardStates{}
class FailedToSelectPdfState extends DashBoardStates{}

// Todo: Select Image ( While Uploading Club Info ro Firestore )
class SelectImageSuccessState extends DashBoardStates{}
class FailedToSelectImageState extends DashBoardStates{}
class CancelClubImageState extends DashBoardStates{}

class CreateClubSuccessState extends DashBoardStates{}
class CreateClubLoadingState extends DashBoardStates{}
class FailedToCreateClubState extends DashBoardStates{}

class AssignLeaderToClubSuccessState extends DashBoardStates{}
class AssignLeaderToClubLoadingState extends DashBoardStates{}
class FailedToAssignLeaderToClubState extends DashBoardStates{}

class DeleteClubSuccessState extends DashBoardStates{}
class DeleteClubLoadingState extends DashBoardStates{}
class FailedToDeleteClubState extends DashBoardStates{}

class GetClubsSuccessState extends DashBoardStates{}
class GetClubsLoadingState extends DashBoardStates{}
class FailedToGetClubsState extends DashBoardStates{}

class AcceptOrRejectPlanForClubSuccessState extends DashBoardStates{}
class AcceptOrRejectPlanForClubLoadingState extends DashBoardStates{}
class FailedToAcceptOrRejectPlanForClubState extends DashBoardStates{
  String message;
  FailedToAcceptOrRejectPlanForClubState({required this.message});
}

// Todo: Events
class GetEventsSuccessState extends DashBoardStates{}
class GetEventsLoadingState extends DashBoardStates{}
class FailedToGetEventsState extends DashBoardStates{}

class GetReportsSuccessState extends DashBoardStates{}
class GetReportsLoadingState extends DashBoardStates{}
class FailedToGetReportsState extends DashBoardStates{}

class ErrorDuringOpenPdfState extends DashBoardStates{
  String message;
  ErrorDuringOpenPdfState({required this.message});
}

