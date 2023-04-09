import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitialState());

  static AuthCubit getInstance(BuildContext context) => BlocProvider.of(context);

  Future<void> login({required String email,required String password}) async {
    emit(LoginLoadingState());
    try{
      UserCredential userCredential = await authRepository.login(email: email, password: password);
      if( userCredential.user?.uid != null )
      {
        debugPrint("User Data is : ${userCredential.user!}");
        emit(LoginSuccessState());
      }
      else
      {
        debugPrint("User info is : $userCredential");
        emit(FailedToLoginState());
      }
    } on FirebaseAuthException catch(e){
      debugPrint("Failed To Login as an Admin, reason : ${e.message}");
      emit(FailedToLoginState());
    }
  }

  // Todo: Responsible to change password by click on Forget Password Button
  Future<void> sendPasswordResetToEmail({required String email}) async {
    emit(SendPasswordResetEmailLoadingState());
    try {
      await authRepository.forgetPassword(email: email);
      emit(SendPasswordResetEmailSuccessState());
    }
    catch(e)
    {
      debugPrint("Failed To send Password Reset to Email, reason : ${e.toString()}");
      emit(SendPasswordResetEmailFailureState());
    }
  }
}