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
  // TODO: هستعمله عند ارسال اشعار ب استخدام Firebase FCM
  static const String serverKey = "key=AAAAfzXaND4:APA91bEJtFGlWFAiVTBtbhnf9RAAKaUMaj-tAf0updm5hJV2QSat7-z2A_mrlpQb0-mpgoa2PmkX_qtb6oWWu7tE0whkEsh9zHTtRWNSA7xVjCQvTt3jD19kPWSVGD4VrH-_p52s6vZ4";
}