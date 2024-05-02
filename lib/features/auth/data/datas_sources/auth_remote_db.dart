import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/features/auth/data/models/userModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDB {
  Future<UserModel> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> SignInWithEmail({
    required String email,
    required String password,
  });
}

class AuthRemoteDBImpl implements AuthRemoteDB {
  final SupabaseClient supabaseClient;
  AuthRemoteDBImpl(this.supabaseClient);

  @override
  Future<UserModel> SignInWithEmail(
      {required String email, required String password}) {
    // TODO: implement SignInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<UserModel> SignUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});
      print(response.toString());
      if (response.user == null) {
        throw ServerException(message: "Error Creating user");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }
}
