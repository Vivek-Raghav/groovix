// Project imports:

import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/gen/assets.gen.dart';

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
          state.data.role == Role.cms.name
              ? context.go(AppRoutes.cmsDashboard)
              : context.go(AppRoutes.bottomNav);
        } else if (state is AuthLoginFailure) {
          showToast(title: state.error);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.background,
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
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
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
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                  const SizedBox(height: 8),
                  Text('Login to your account',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16)),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              prefixIcon: Icon(Icons.email,
                                  color: Theme.of(context).colorScheme.primary),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
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
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              prefixIcon: Icon(Icons.lock,
                                  color: Theme.of(context).colorScheme.primary),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
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
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                                  .withOpacity(0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant)),
                      ),
                      Expanded(
                          child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                                  .withOpacity(0.3))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.g_mobiledata,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20),
                      label: Text('Continue with Google',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
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
                      Text('Don\'t have an account?',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                      TextButton(
                        onPressed: () {
                          context.push(AppRoutes.signup);
                        },
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
