import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/checkingInfo/checking_info_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/features/login/logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Text(
                          "Tayaar App",
                          style: TextStyles.normal,
                        ),
                        SizedBox(height: size.height * 0.1),
                        defaultFormField(
                          controller: _nameController,
                          type: TextInputType.name,
                          onSubmit: () {},
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter a value!";
                            }
                            return null;
                          },
                          label: "Name",
                          prefix: Icons.person,
                          context: context,
                        ),
                        SizedBox(height: size.height * 0.05),
                        defaultFormField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: () {},
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter a value!";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          isPassword: true,
                          context: context,
                        ),
                        SizedBox(height: size.height * 0.05),
                        if (state is! LoginLoadingState)
                          defaultButton(
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                    context,
                                    _nameController.text,
                                    _passwordController.text);
                              }
                            },
                            context: context,
                            text: "Login",
                          ),
                        if (state is LoginLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
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
