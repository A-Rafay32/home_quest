import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/core/utils/types.dart';
import 'package:real_estate_app/features/auth/model/user_details.dart';
import 'package:real_estate_app/features/auth/repositories/user_repository.dart';
import 'package:real_estate_app/features/auth/model/user.dart';

class AuthRepository {
  final UserRepository userService = UserRepository.instance;
  static FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  static User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  FutureEither0 signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final result = await userService.getUserByEmail(email);

      if (result.isLeft) {
        return failure("No user exists with the email provided");
      }
      return success("User signed in with $email");
    } on FirebaseAuthException catch (e) {
      return failure(e.message.toString());
    } catch (e) {
      return success(e.toString());
    }
  }

  FutureEither0 signOut() async {
    try {
      await firebaseAuth.signOut();
      return success("User signed out successfully");
    } on FirebaseAuthException catch (e) {
      return failure(e.message.toString());
    } catch (e) {
      return success(e.toString());
    }
  }

  FutureEither0 register(
      {required String name, required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final result = await userService.createUser(
          user: UserModel(
              id: currentUser?.uid ?? "",
              userDetails: UserDetails(
                name: name,
                email: email,
                password: password,
              )),
          uid: currentUser?.uid ?? "");

      if (result.isLeft) {
        return failure("User failed to be created in database");
      }

      return success("User created with email: $email");
    } on FirebaseAuthException catch (e) {
      return failure(e.message.toString());
    } catch (e) {
      return success(e.toString());
    }
  }

  void resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      String returnedEmail = await firebaseAuth.verifyPasswordResetCode(code);
      if (returnedEmail.isNotEmpty) {
        await firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
      } else {
        throw "Reset code failed to verify";
      }
    } catch (e) {
      rethrow;
    }
  }

  void forgetPassword() {}

  void updateUser() async {
    try {} catch (e) {
      rethrow;
    }
  }

  void updateEmail() {}

  void updatePassword() {}
}
