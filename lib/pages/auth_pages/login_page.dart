import 'package:flutter/material.dart';
import 'package:link/components/custom_button.dart';
import 'package:link/components/custom_fields.dart';
import 'package:link/pages/auth_pages/register_page.dart';
import 'package:link/pages/other_pages/navigation_page.dart';
import 'package:link/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  Text('Login',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25)),
                  const SizedBox(height: 10),
                  //Logo
                  const SizedBox(
                    width:double.infinity,
                    height:200,
                    child: Center(child: Image(image: AssetImage('assets/images/link_logo.png')))),
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
                  CustomButton(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonText: 'Sign up',
                      onTap: () async {
                        if(passwordController.text.length>=8&&passwordController.text.isNotEmpty){
                          final message=await AuthService().loginUser(username: usernameController.text, email: emailController.text, password: passwordController.text);
                          if (message!.contains('Success')){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=> const NavigationPage())
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Password is too short or empty')));
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
                      child: Text('Continue as guest',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary))),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: Row(children: [
                      const Text('Do not have an account?'),
                      const SizedBox(width: 20),
                      Text('Register!',
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
