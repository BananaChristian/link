import 'package:flutter/material.dart';
import 'package:link/components/custom_button.dart';
import 'package:link/components/custom_fields.dart';
import 'package:link/pages/auth_pages/login_page.dart';
import 'package:link/pages/other_pages/navigation_page.dart';
import 'package:link/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Text('Register',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25)),
                  const SizedBox(height: 10),
                  const SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Center(
                          child: Image(
                        image: AssetImage('assets/images/link_logo.png'),
                      ))),
                  const SizedBox(height: 10),
                  //FIELDS
                  //Username field
                  CustomFields(
                      controller: usernameController,
                      hintText: 'username',
                      color: Theme.of(context).colorScheme.primary,
                      obscureText: false),
                  const SizedBox(height: 10),
                  //Email field
                  CustomFields(
                      controller: emailController,
                      hintText: 'email',
                      color: Theme.of(context).colorScheme.primary,
                      obscureText: false),
                  const SizedBox(height: 10),
                  CustomFields(
                      controller: passwordController,
                      hintText: 'password',
                      color: Theme.of(context).colorScheme.primary,
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFields(
                    controller: confirmPasswordController,
                    hintText: 'confirm password',
                    color: Theme.of(context).colorScheme.primary,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonText: 'Sign up',
                      onTap: () async {
                        if (passwordController.text.length >= 8 &&
                            passwordController.text.isNotEmpty) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            final message = await authService.registerUser(
                                username:usernameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                            if (message!.contains('Success')) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(message)));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Passwords do not match')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password is either empty or too short')));
                        }
                      }),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationPage()));
                      },
                      child: Text(
                        'Continue as guest',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Row(children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 10),
                      Text('Login!',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
