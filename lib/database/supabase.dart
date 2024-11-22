import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;

Future SignUpOptResponse(String email, String password) async {
  final response = await supabase.auth.signUp(
      email: email,
      password: password
  );
  return response;
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