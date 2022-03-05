import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_firebase_bloc_notes/entities/user_entity.dart';
import 'package:flutter_firebase_bloc_notes/repositories/repositories.dart';
import '../../config/paths.dart';
import '../../models/models.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firestore;
  final auth.FirebaseAuth _fireBaseAuth;

  AuthRepository(
      {FirebaseFirestore? firestore, auth.FirebaseAuth? firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _fireBaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  Future<User> _firebaseUserToUser(auth.User user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection(Paths.users).doc(user.uid).get();

    if (userDoc.exists) {
      User user = User.fromEntity(UserEntity.fromSnapshot(userDoc));
      return user;
    }
    return User(email: '', id: user.uid);
  }

  @override
  Future<User> loginAnonymously() async {
    final authResult = await _fireBaseAuth.signInAnonymously();
    //Get user from authResult
    //authResult.user returns a firebase user and we need to conver to user
    return _firebaseUserToUser(authResult.user!);
  }

  @override
  Future<User> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    //Get current user
    final currentUser = _fireBaseAuth.currentUser;
    final authCredential =
        auth.EmailAuthProvider.credential(email: email, password: password);
    final authResult = await currentUser?.linkWithCredential(authCredential);
    final user = await _firebaseUserToUser(authResult!.user!);

    _firestore
        .collection(Paths.users)
        .doc(user.id)
        .set(user.toEntity().toDocument());
    return user;
  }

  @override
  Future<User> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final authResult = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await _firebaseUserToUser(authResult.user!);
  }

  @override
  Future<User> logOut() async {
    await _fireBaseAuth.signOut();
    // User signed out so login anonymously
    return await loginAnonymously();
  }

  @override
  Future<User?> getCurrentUser() async {
    final currentUser = _fireBaseAuth.currentUser;
    if (currentUser == null) {
      return null;
    }
    return _firebaseUserToUser(currentUser);
  }

  @override
  void dispose() {}

  @override
  Future<bool> isAnonymous() async {
    final currentUser = _fireBaseAuth.currentUser;
    if (currentUser == null) {
      return false;
    }
    return currentUser.isAnonymous;
  }

  @override
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
