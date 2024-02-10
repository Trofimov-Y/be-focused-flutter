import 'package:be_focused/data/models/activity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
final class ActivitiesRemoteDataSource {
  const ActivitiesRemoteDataSource(this._firestore, this._auth);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> create(ActivityModel model) => _activitiesRef.add(model);

  Future<void> update(ActivityModel model) => _activitiesRef.doc(model.id).update(model.toJson());

  Future<void> delete(String id) => _activitiesRef.doc(id).delete();

  Stream<List<ActivityModel>> getActivitiesStream() => _activitiesRef
      .snapshots()
      .map((event) => event.docs.map((activity) => activity.data()).toList());

  DocumentReference<Map<String, dynamic>> get _userRef =>
      _firestore.collection('users').doc(_auth.currentUser?.uid);

  CollectionReference<ActivityModel> get _activitiesRef =>
      _userRef.collection('activities').withConverter(
            fromFirestore: (snapshot, _) => ActivityModel.fromJson({
              'id': snapshot.id,
              ...?snapshot.data(),
            }),
            toFirestore: (model, _) => model.toJson(),
          );
}
