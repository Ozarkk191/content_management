import 'package:ccm/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel());

  void setUser(UserModel user) => emit(user);
}
