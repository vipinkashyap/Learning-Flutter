import '../../models/models.dart';
import '../repositories.dart';

abstract class BaseAuthRepository extends BaseRepository {
  Future<User> loginAnonymously();
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<User> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<User> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<User> logOut();
  Future<User?> getCurrentUser();
  Future<bool> isAnonymous();
}
