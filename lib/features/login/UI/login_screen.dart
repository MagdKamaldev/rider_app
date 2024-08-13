import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/checkingInfo/checking_info_screen.dart';
import 'package:tayaar/features/home/UI/home_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/features/login/logic/cubit/login_cubit.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(getIt<LoginRepositoryImpelemntation>()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            navigateAndFinish(context, const CheckingInfo());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Text(
                          "Tayaar App",
                          style: TextStyles.normal,
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        defaultFormField(
                            controller:
                                context.read<LoginCubit>().nameController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter a value !";
                              }
                            },
                            label: "Name",
                            prefix: Icons.person,
                            context: context),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        defaultFormField(
                            controller:
                                context.read<LoginCubit>().passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter a value !";
                              }
                            },
                            label: "Password",
                            prefix: Icons.person,
                            context: context),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        if (state is! LoginLoadingState)
                          defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(context);
                                }
                              },
                              context: context,
                              text: "Login"),
                        if (state is LoginLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
