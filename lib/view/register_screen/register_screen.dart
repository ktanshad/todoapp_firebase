
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/contants.dart';
import 'package:todo/helpers/colors.dart';
import 'package:todo/view/controller/auth_provider.dart';
import 'package:todo/widgets/mybutton_widget.dart';
import 'package:todo/widgets/mytextfiled_widget.dart';


class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundcolor,
      body: Form(
        key: formkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kHeigt25,

                  //email textfield
                  MyTextField(
                    controller: authprovider.registerEmailTextController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                    },
                  ),
                  kHeigt25,

                  //password textfield
                  MyTextField(
                    controller: authprovider.registerPassWordTextController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter password';
                      } else if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                    },
                  ),

                  kHeigt10,

                  //conform password textfiled
                  MyTextField(
                    controller:
                        authprovider.registerConformPasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter confirm password';
                      } else if (authprovider
                              .registerPassWordTextController.text !=
                          authprovider
                              .registerConformPasswordTextController.text) {
                        return 'Passwords do not match!';
                      }
                    },
                  ),

                  kHeigt10,

                  //sign in button
                  MyButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          final authprovider =
                              Provider.of<AuthProvider>(context, listen: false);
                          if (authprovider
                                  .registerPassWordTextController.text !=
                              authprovider
                                  .registerConformPasswordTextController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match!"),
                              ),
                            );
                            return;
                          }
                          try {
                            await authprovider.signUpWithEmailandPassword(
                                authprovider.registerEmailTextController.text,
                                authprovider
                                    .registerPassWordTextController.text);
                            authprovider.registerEmailTextController.clear();
                            authprovider.registerPassWordTextController.clear();
                            authprovider.registerConformPasswordTextController
                                .clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'The email addresss is already use by another account'),
                              ),
                            );
                          }
                        }
                      },
                      text: 'Sign Up'),
                  kHeigt10,

                  //or continue with
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      Text('Or continue with',style: TextStyle(color: kbuttonColor),),
                      kHeigt10,
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),

                  //google button
                  GestureDetector(
                    onTap: (){
                      authprovider.signInWithGoogle();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('asset/google_icon.jpg',height: 72,)),
                  ),
                  kHeigt25,

                  // go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                          onTap: onTap,
                          child: Text(
                            "Login now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kbuttonColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
