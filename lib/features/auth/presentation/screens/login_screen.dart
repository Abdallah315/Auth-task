import 'package:auth_task/core/helpers/app_regex.dart';
import 'package:auth_task/core/helpers/sizes.dart';
import 'package:auth_task/core/routes/routes.dart';
import 'package:auth_task/core/theming/styles.dart';
import 'package:auth_task/core/utils/asyn_value_ui.dart';
import 'package:auth_task/core/widgets/app_button.dart';
import 'package:auth_task/core/widgets/app_text_button.dart';
import 'package:auth_task/core/widgets/app_text_form_field.dart';
import 'package:auth_task/core/widgets/form_field_header.dart';
import 'package:auth_task/core/widgets/full_screen_loading.dart';
import 'package:auth_task/features/auth/domain/login_request_body.dart';
import 'package:auth_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: FullScreenLoader(
        isLoading: authState.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Form(
              key: _formState,
              child: ListView(
                children: [
                  verticalSpace(23),
                  Text('Welcome', style: TextStyles.font32BoldBlack),
                  verticalSpace(40),
                  Text('Login', style: TextStyles.font18BoldBlack),
                  verticalSpace(40),
                  FormFieldHeader(text: 'Phone Number'),
                  verticalSpace(4),
                  AppTextFormField(
                    hintText: '1012345678',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                    },
                    maxLength: 10,
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          Text('+20', style: TextStyles.font12RegularBlack),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  FormFieldHeader(text: 'Password'),
                  verticalSpace(4),
                  AppTextFormField(
                    hintText: 'Enter Your Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      } else if (!AppRegex.isPasswordValid(value)) {
                        return 'Password must be at least 8 characters and include one lowercase letter, one uppercase letter, one special character, and one digit';
                      }
                    },
                    controller: _password,
                  ),
                  verticalSpace(20),
                  AppButton(onPressed: login, title: 'Login'),
                  verticalSpace(20),
                  AppTextButton(
                    onPressed: () => context.pushReplacementNamed(
                      AppRoutes.registration.name,
                    ),
                    title: 'Create new account',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    final authController = ref.watch(authControllerProvider.notifier);

    if (_formState.currentState!.validate()) {
      authController.login(
        loginRequestBody: LoginRequestBody(
          phoneNumber: _phoneNumber.text,
          password: _password.text,
        ),
        onSuccess: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successful')));
        },
        onError: (error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login failed')));
        },
      );
    }
  }
}
