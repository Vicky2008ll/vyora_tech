import 'package:flutter/material.dart';

void main() {
  runApp(const VyoraApp());
}

class VyoraApp extends StatelessWidget {
  const VyoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VYORA Tech',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF367BFA)),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool hidePassword = true;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void switchPage() {
    setState(() {
      isLogin = !isLogin;
      hidePassword = true;
      formKey.currentState?.reset();
    });
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      if (!isLogin && passwordController.text != confirmController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match!')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isLogin
                ? 'Login form submitted successfully!'
                : 'Registration successful!',
          ),
        ),
      );
    }
  }

  Widget inputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool password = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        obscureText: password && hidePassword,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your $label';
          }

          if (label == 'email' &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value.trim())) {
            return 'Enter a valid email address';
          }

          if (label == 'password' && value.length < 6) {
            return 'Password must be at least 6 characters';
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: password
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E7F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF367BFA), width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // VYORA TECH LOGO
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: const Color(0xFF367BFA),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.bolt_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'VYORA TECH',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Color(0xFF101D35),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Technology made simple.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                  const SizedBox(height: 35),

                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isLogin ? 'Welcome Back!' : 'Create Account',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF101D35),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            isLogin
                                ? 'Login to continue to your account.'
                                : 'Register to get started with VYORA Tech.',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 28),

                          if (!isLogin)
                            inputField(
                              label: 'full name',
                              hint: 'Enter your full name',
                              icon: Icons.person_outline,
                              controller: nameController,
                            ),

                          inputField(
                            label: 'email',
                            hint: 'Enter your email',
                            icon: Icons.email_outlined,
                            controller: emailController,
                          ),

                          inputField(
                            label: 'password',
                            hint: 'Enter your password',
                            icon: Icons.lock_outline,
                            controller: passwordController,
                            password: true,
                          ),

                          if (!isLogin)
                            inputField(
                              label: 'confirm password',
                              hint: 'Confirm your password',
                              icon: Icons.lock_reset,
                              controller: confirmController,
                              password: true,
                            ),

                          const SizedBox(height: 8),

                          SizedBox(
                            width: double.infinity,
                            height: 53,
                            child: ElevatedButton(
                              onPressed: submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF367BFA),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                isLogin ? 'LOGIN' : 'REGISTER',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isLogin
                                    ? "Don't have an account? "
                                    : 'Already have an account? ',
                                style: const TextStyle(fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: switchPage,
                                child: Text(
                                  isLogin ? 'Register' : 'Login',
                                  style: const TextStyle(
                                    color: Color(0xFF367BFA),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    '© 2026 VYORA Tech. All rights reserved.',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
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
