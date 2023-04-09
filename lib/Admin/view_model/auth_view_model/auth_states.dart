abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class LoginSuccessState extends AuthStates{}
class LoginLoadingState extends AuthStates{}
class FailedToLoginState extends AuthStates{}

class SendPasswordResetEmailSuccessState extends AuthStates{}
class SendPasswordResetEmailFailureState extends AuthStates{}
class SendPasswordResetEmailLoadingState extends AuthStates{}
