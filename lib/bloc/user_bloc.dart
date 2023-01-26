import 'package:ccm/models/user_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserCubit extends Cubit<UserModel> {
//   UserCubit() : super(UserModel());

//   void setUser(UserModel user) => emit(user);
// }

class UserData {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
  }
}
