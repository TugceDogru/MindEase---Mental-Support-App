import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/locator.dart';
import '../../app/routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../shared/widgets/loading_indicator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => locator<AuthViewModel>(),
      child: Consumer<AuthViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 32),
                    Text('MindEase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32), textAlign: TextAlign.center),
                    SizedBox(height: 32),
                    Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), textAlign: TextAlign.center),
                    SizedBox(height: 32),
                    _buildInput(vm.emailController, '@username', false),
                    SizedBox(height: 16),
                    _buildInput(vm.passwordController, 'Password', true),
                    SizedBox(height: 24),
                    vm.state == AuthState.busy
                        ? LoadingIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              final success = await vm.login();
                              if (success) {
                                Navigator.pushReplacementNamed(context, Routes.home);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(vm.errorMessage ?? 'Login failed')),
                                );
                              }
                            },
                            child: Text('Sign in'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                    SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, Routes.register),
                          child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscure : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}
