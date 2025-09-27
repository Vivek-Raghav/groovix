// Flutter imports:

// Project imports:
import 'package:groovix/core/shared/domain/method/methods.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/gen/assets.gen.dart';
import 'package:groovix/main/main_index.dart';

/// LoginScreen - Figma-inspired UI only (no logic)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          context.go(AppRoutes.bottomNav);
        } else if (state is AuthLoginFailure) {
          showToast(title: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ThemeColors.primaryColor.withOpacity(0.1),
                ThemeColors.white,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Assets.icons.appIconLight.image(height: 120),
                  ),
                  const SizedBox(height: 32),
                  Text('Welcome Back!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.black)),
                  const SizedBox(height: 8),
                  const Text('Login to your account',
                      style: TextStyle(color: ThemeColors.grey, fontSize: 16)),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ThemeColors.primaryColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                  color: ThemeColors.primaryColor),
                              prefixIcon: const Icon(Icons.email,
                                  color: ThemeColors.primaryColor),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: ThemeColors.primaryColor, width: 2),
                              ),
                              filled: true,
                              fillColor: ThemeColors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              final regex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ThemeColors.primaryColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: ThemeColors.primaryColor),
                              prefixIcon: const Icon(Icons.lock,
                                  color: ThemeColors.primaryColor),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: ThemeColors.primaryColor, width: 2),
                              ),
                              filled: true,
                              fillColor: ThemeColors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              final regex = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$');
                              if (!regex.hasMatch(value)) {
                                return 'Password must contain at least 1 letter, 1 number, and 1 special character (!@#\$&*~)';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?',
                          style: TextStyle(color: ThemeColors.primaryColor)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.primaryColor.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          getIt<AuthBloc>().add(AuthLoginEvent(
                              params: SignInParams(
                                  email: _emailController.text,
                                  password: _passwordController.text)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primaryColor,
                        foregroundColor: ThemeColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: ThemeColors.grey.withOpacity(0.3))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or',
                            style: TextStyle(color: ThemeColors.grey)),
                      ),
                      Expanded(
                          child: Divider(
                              color: ThemeColors.grey.withOpacity(0.3))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: ThemeColors.primaryColor.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.primaryColor.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.g_mobiledata,
                          color: ThemeColors.primaryColor, size: 20),
                      label: const Text('Continue with Google',
                          style: TextStyle(color: ThemeColors.primaryColor)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?',
                          style: TextStyle(color: ThemeColors.grey)),
                      TextButton(
                        onPressed: () {
                          context.push(AppRoutes.signup);
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: ThemeColors.primaryColor,
                                fontWeight: FontWeight.bold)),
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
}
