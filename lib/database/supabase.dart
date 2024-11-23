import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;

Future SignUpOptResponse(String email, String password) async {
  final response = await supabase.auth.signUp(
      email: email,
      password: password
  );
  print(response);
  return response;
}

Future SignInWithEmail(String email, String password) async{
  try {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password
    );
    print('Успешная авторизация, пользователь найден');
    return true;
  } catch (e){
    print('Попытка авторизации неуспешна: $e');
    return e;
  }
}

Future ConfirmOtpCode(String email, String token) async{
  try {
    await supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: token,
        email: email
    );
    return true;
  } catch(e) {
    return false;
  }
}

Future UpdatePassword(String newPass) async {
  await supabase.auth.updateUser(
      UserAttributes(
          password: newPass
      )
  );
}