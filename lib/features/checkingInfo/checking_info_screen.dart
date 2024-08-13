import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/home/UI/home_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/features/login/logic/cubit/login_cubit.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';

class CheckingInfo extends StatelessWidget {
  const CheckingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(getIt<LoginRepositoryImpelemntation>())..getInfo(context),
      child: BlocListener<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is InfoSuccess) {
            if (state.info.data!.isInShift!) {
              navigateAndFinish(context, const OrdersScreen());
            } else {
              navigateTo(
                  context,
                  HomeScreen(
                    id: state.info.data!.id!,
                  ));
            }
          }
        },
        child: const Scaffold(
          body: SafeArea(
              child: Center(
            child: Text(
              "Checking Info ...!",
            ),
          )),
        ),
      ),
    );
  }
}
