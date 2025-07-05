import 'package:auth_task/core/helpers/app_regex.dart';
import 'package:auth_task/core/helpers/sizes.dart';
import 'package:auth_task/core/routes/routes.dart';
import 'package:auth_task/core/theming/styles.dart';
import 'package:auth_task/core/utils/asyn_value_ui.dart';
import 'package:auth_task/core/widgets/app_button.dart';
import 'package:auth_task/core/widgets/app_text_form_field.dart';
import 'package:auth_task/core/widgets/form_field_header.dart';
import 'package:auth_task/core/widgets/full_screen_loading.dart';
import 'package:auth_task/features/auth/domain/register_request_body.dart';
import 'package:auth_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegiserationScreenState();
}

class _RegiserationScreenState extends ConsumerState<RegistrationScreen> {
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    _confirmPassword.dispose();
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
                  Text('Create new account', style: TextStyles.font18BoldBlack),
                  verticalSpace(40),
                  FormFieldHeader(text: 'Phone Number'),
                  verticalSpace(4),
                  AppTextFormField(
                    hintText: '1012345678',
                    controller: _phoneNumber,
                    maxLength: 10,

                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                    },
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
                  FormFieldHeader(text: 'Confirm Password'),
                  verticalSpace(4),
                  AppTextFormField(
                    hintText: 'Confirm your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a confirmation password';
                      } else if (_confirmPassword.text != _password.text) {
                        return 'Confirmation password isn\'t right';
                      }
                    },
                    controller: _confirmPassword,
                  ),
                  verticalSpace(20),
                  AppButton(onPressed: register, title: 'Continue'),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account? ',
                        style: TextStyles.font14RegularBlack,
                      ),
                      GestureDetector(
                        onTap: authState.isLoading
                            ? null
                            : () => context.pushReplacementNamed(
                                AppRoutes.login.name,
                              ),
                        child: Text(
                          'Login',
                          style: TextStyles.font16MediumPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    final authController = ref.watch(authControllerProvider.notifier);

    if (_formState.currentState!.validate()) {
      authController.register(
        registerRequestBody: RegisterRequestBody(
          phoneNumber: _phoneNumber.text,
          password: _password.text,
          passwordConfirmation: _confirmPassword.text,
        ),
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')),
          );
        },
        onError: (error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Registration failed')));
        },
      );
    }
  }
}
