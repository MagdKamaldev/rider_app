import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/home/UI/home_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/features/login/logic/cubit/login_cubit.dart';
import 'package:tayaar/features/orders/UI/order_details_screen.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';

class CheckingInfo extends StatelessWidget {
  const CheckingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<LoginRepositoryImpelemntation>())
        ..handleLocationPermissions(context),
      child: BlocListener<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is GetLocationSuccess) {
          //  print("Location permission granted");
            LoginCubit.get(context).getInfo(context);
          }
          if (state is InfoSuccess) {
            if (LoginCubit.get(context).model!.isInShift!) {
              if (LoginCubit.get(context).model!.currentOrderId! == 0) {
                navigateAndFinish(context, const OrdersScreen());
              } else {
                navigateAndFinish(context, const OrderDetailsScreen());
              }
            } else {
              navigateTo(
                context,
                HomeScreen(
                  id: LoginCubit.get(context).model!.id!,
                  position: LoginCubit.get(context).myPosition!,
                ),
              );
            }
          } else if (state is GetLocationError) {
            // Handle the location error if needed
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 250,
                    child: Lottie.asset(
                      "assets/animations/Animation - 1723638863478.json",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyles.headings.copyWith(
                      color: AppColors.prussianBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}