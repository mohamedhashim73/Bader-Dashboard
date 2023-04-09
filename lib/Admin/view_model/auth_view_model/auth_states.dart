abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class UpdateAdminPasswordSuccessState extends AuthStates{}

class GetAdminDataSuccessState extends AuthStates{}
class FailedGetAdminDataState extends AuthStates{}

class LoginSuccessState extends AuthStates{}
class LoginLoadingState extends AuthStates{}
class FailedToLoginState extends AuthStates{
  String message;
  FailedToLoginState({required this.message});
}

class SendPasswordResetEmailSuccessState extends AuthStates{}
class SendPasswordResetEmailFailureState extends AuthStates{}
class SendPasswordResetEmailLoadingState extends AuthStates{}
