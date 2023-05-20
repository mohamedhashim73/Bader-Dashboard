import 'package:jiffy/jiffy.dart';

class Constants{
  static String kNotificationsCollectionName = "Notifications";
  static String kUsersCollectionName = "Users";
  static String kClubsCollectionName = "Clubs";
  static String kAcceptedAnnualPlanForClubCollectionName = "Accepted Annual Plan";
  static String kMeetingsCollectionName = "Meetings";
  static String kMembershipRequestsCollectionName = "Membership Requests";
  static String kTaskAuthenticationRequestsCollectionName = "Tasks Authentication Requests";
  static String kOpinionsAboutTaskCollectionName = "Opinions";
  static String kMembersDataCollectionName = "Members Data";
  static String kMembersNumberCollectionName = "Members Number";
  static String kTotalVolunteerHoursThrowAppCollectionName = "Volunteer Hours";
  static String kEventsCollectionName = "Events";
  static String kTasksCollectionName = "Tasks";
  static String kReportsCollectionName = "Reports";
  static List<String> reportTypes = ["خطة سنوية","فعالية","ساعات تطوعية"];
  static String? kAdminID;
  static String getTimeNow() => Jiffy(DateTime.now()).yMMMd;
}