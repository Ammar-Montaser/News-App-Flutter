import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/features/auth/data/models/userModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDB {
  Session? get currentUserSession;
  Future<UserModel> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> SignInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDBImpl implements AuthRemoteDB {
  final SupabaseClient supabaseClient;
  AuthRemoteDBImpl(this.supabaseClient);

  @override
  Future<UserModel> SignInWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      print(response.toString());
      if (response.user == null) {
        throw ServerException(message: "Error logging in user");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
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
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq("id", currentUserSession!.user.id);
        return UserModel.fromJson(userData[0])
            .copyWith(email: currentUserSession!.user.email);
      } else {
        return null;
      }
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
