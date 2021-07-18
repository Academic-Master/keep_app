import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_app/core/exceptions/save_user_exception.dart';
import 'package:keep_app/features/auth/data/models/user_model.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';

mixin FireStoreRepository {
  // Save data in firestore
  Future<Either<Exception, User>> saveUserCredentials(
      UserModel user, FirebaseFirestore firestoreInstance) async {
    try {
      await firestoreInstance.collection('users').add(user.toJson());
      return right(user);
    } catch (e) {
      return left(SaveUserException());
    }
  }
}
