import 'package:badir_app/Admin/model/admin_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/components/constants.dart';
import '../../repositories/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitialState());

  static AuthCubit getInstance(BuildContext context) => BlocProvider.of(context);

  AdminModel? adminModel;
  Future<void> getAdminInfo() async {
    try{
      adminModel = await authRepository.getAdminData();
      emit(GetAdminDataSuccessState());
    }
    on FirebaseAuthException catch (e) {
      debugPrint("Failed To get Admin Data , reason : ${e.message}");
      emit(FailedGetAdminDataState());
    }
  }

  Future<void> login({required String email,required String password}) async {
    if( adminModel?.id == null ) await getAdminInfo();
    emit(LoginLoadingState());
    try{
      UserCredential userCredential = await authRepository.login(email: email, password: password);
      if( userCredential.user?.uid != null && email.trim() == adminModel!.email!.trim())   // لازم يكون البريد هو نفسه اللي في Firestore
      {
        if( adminModel!.password != password )   // معناها ان هو دخل علي نسيت كلمه السر وغيره
        {
          await authRepository.updateAdminPassword(newPassword: password, adminID: userCredential.user!.uid);
          emit(UpdateAdminPasswordSuccessState());
        }
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setString("adminID", userCredential.user!.uid);
        Constants.kAdminID = sharedPref.getString('adminID');
        emit(LoginSuccessState());
      }
      else
      {
        emit(FailedToLoginState(message: "غير مصرح لهذا الحساب بالدخول ك أدمن"));
      }
    } on FirebaseAuthException catch(e){
      debugPrint("Failed To Login as an Admin, reason : ${e.message}");
      emit(FailedToLoginState(message: "غير مصرح لهذا الحساب بالدخول ك أدمن"));
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