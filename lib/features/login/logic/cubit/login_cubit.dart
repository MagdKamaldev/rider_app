import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepositoryImpelemntation repoImpl;
  LoginCubit(this.repoImpl) : super(LoginInitial());


  void login(BuildContext context,String name,String password) async {
    emit(LoginLoadingState());
    final response =
        await repoImpl.login(name,password);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(LoginErrorState(l.message));
      },
      (r) {
        emit(LoginSuccessState(r));
      },
    );
  }

  InfoModel? model;

  void getInfo(BuildContext context) async {
    emit(InfoLoading());

    final response = await repoImpl.getInfo();

    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(InfoError(
          l.message,
        ));
      },
      (r) {
        model = r;
        emit(InfoSuccess(info: r));
      },
    );
  }
}
