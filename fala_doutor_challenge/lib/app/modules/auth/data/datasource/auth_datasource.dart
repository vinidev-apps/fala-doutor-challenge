import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required UserModel user,
    required String password,
  });

  Future<void> signOut();
  Future<UserModel?> getLoggedUser();

  Future<void> sendPasswordResetEmail({required String email});
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}

// IMPLEMENTAÇÃO
class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthDatasourceImpl({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final String collection = 'users';

  // SIGN IN
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = result.user!.uid;

    final doc = await _firestore.collection(collection).doc(uid).get();

    if (!doc.exists) {
      throw Exception("Usuário não encontrado no Firestore.");
    }

    return UserModel.fromMap(doc.data()!, doc.id);
  }

  // SIGN UP
  @override
  Future<UserModel> signUp({
    required UserModel user,
    required String password,
  }) async {
    // 1) Criar usuário no Firebase Auth
    final result = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );

    final uid = result.user!.uid;

    // 2) Criar documento no Firestore
    await _firestore.collection(collection).doc(uid).set({
      ...user.toMap(),
      'id': uid,
    });

    // 3) Buscar do Firestore (garante consistência)
    final doc = await _firestore.collection(collection).doc(uid).get();

    return UserModel.fromMap(doc.data()!, doc.id);
  }

  // SIGN OUT
  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // GET LOGGED USER
  @override
  Future<UserModel?> getLoggedUser() async {
    final current = _auth.currentUser;

    if (current == null) return null;

    final doc =
        await _firestore.collection(collection).doc(current.uid).get();

    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!, doc.id);
  }

  // PASSWORD RESET EMAIL
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // SEND EMAIL VERIFICATION
  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("Nenhum usuário logado.");
    }

    await user.sendEmailVerification();
  }

  // CHECK EMAIL VERIFIED
  @override
  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;

    if (user == null) return false;

    await user.reload();
    return user.emailVerified;
  }
}
