import 'package:groovix/features/auth/auth_index.dart';

/// SignupScreen - Figma-inspired UI only (no logic)
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _secretKeyController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _secretKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthSignupSuccess) {
          state.data.role == Role.cms.name
              ? context.go(AppRoutes.cmsDashboard)
              : context.go(AppRoutes.bottomNav);
        } else if (state is AuthSignupFailure) {
          showToast(title: state.error);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.music_note,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 24),
                      Text('Create Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Sign up to get started',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value != _passwordController.text) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _secretKeyController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Additional Information',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            getIt<AuthBloc>().add(AuthSignupEvent(
                                params: SignUpParams(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    secretKey: _secretKeyController.text)));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.g_mobiledata,
                      color: Theme.of(context).colorScheme.primary),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                    TextButton(
                      onPressed: () {
                        context.push(AppRoutes.login);
                      },
                      child: Text('Login',
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
    );
  }
}
