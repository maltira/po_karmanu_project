import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;

// Список рецептов
late final List recipes;
Future requestRecipeData() async{
  recipes = await supabase.from('recipe_data').select('*');
}
List get getRecipeList => recipes;


Future SignUpOptResponse(String email, String password) async {
  final response = await supabase.auth.signUp(
      email: email,
      password: password
  );
  print(response);
  return response;
}

Future CreateUser({required String uid, required String username, required String email, required String password, required String timeOfCreate}) async {
  try {
    await supabase.from('users').insert({
      'id': uid,
      'created_at': timeOfCreate,
      'username': username,
      'password': password,
      'email': email
    });
    return true;
  } catch (e){
    print('ОШИБКАААА: $e');
    return e;
  }
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

