import 'dart:async';

import 'package:awesome_flutter_layouts/bloc/bloc.dart';
import 'package:awesome_flutter_layouts/models/usermodel.dart';

class UserBloc extends Bloc {
  final userController = StreamController<List<RandomUserModel>?>.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    userController.close();
  }
}

UserBloc userBloc = UserBloc();
