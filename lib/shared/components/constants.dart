import 'package:intl/intl.dart';

class Constants{
  static String kNotificationsCollectionName = "Notifications";
  static String kUsersCollectionName = "Users";
  static String kClubsCollectionName = "Clubs";
  static String kEventsCollectionName = "Events";
  static String kReportsCollectionName = "Reports";
  static String? kAdminID;
  static String getTimeNow() => DateFormat('dd MMMM yyyy', 'ar').format(DateTime.now());
}