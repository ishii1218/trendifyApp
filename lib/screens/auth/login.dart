import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users_en/consts/validator.dart';
import 'package:shopsmart_users_en/root_screen.dart';
import 'package:shopsmart_users_en/screens/auth/forgot_password.dart';
import 'package:shopsmart_users_en/screens/auth/register.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/dashboard_screen.dart';
import 'package:shopsmart_users_en/screens/loading_manager.dart';
import 'package:shopsmart_users_en/widgets/app_name_text.dart';
import 'package:shopsmart_users_en/widgets/subtitle_text.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';

import '../../services/my_app_functions.dart';
import '../../widgets/auth/google_btn.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });

        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "Login Successful",
          textColor: Colors.white,
        );
        if (!mounted) return;
        // Check if the email is admin's
        if (_emailController.text.trim() == "admin@gmail.com") {
          // Navigate to DashboardScreen if email is admin
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        } else {
          // Otherwise, navigate to RootScreen
          Navigator.pushReplacementNamed(context, RootScreen.routeName);
        }
      } on FirebaseException catch (error) {
        await MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
      } catch (error) {
        await MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const AppNameTextWidget(
                    fontSize: 30,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: TitlesTextWidget(label: "Welcome back!")),
                  const SizedBox(
                    height: 180,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            filled: true, // Enable the fill color
                            fillColor: Color.fromARGB(255, 245, 245, 245),
                            hintText: "Email",
                            prefixIcon: Icon(
                              IconlyLight.message,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          obscureText: obscureText,
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true, // Enable the fill color
                            fillColor: Color.fromARGB(255, 245, 245, 245),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: "***********",
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                            ),
                          ),
                          onFieldSubmitted: (value) async {
                            await _loginFct();
                          },
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                ForgotPasswordScreen.routeName,
                              );
                            },
                            child: const SubtitleTextWidget(
                              label: "Forgot password?",
                              // fontStyle: FontStyle.italic,
                              fontSize: 14,
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                                255, 80, 200, 120), // The background color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: double
                                .infinity, // To make the button fill the available width
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 80, 200,
                                    120), // Match the color of the DecoratedBox
                                padding: const EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation:
                                    0, // Remove default elevation for a flat look
                              ),
                              label: const Text("Login",
                                  style: TextStyle(
                                      color: Colors
                                          .white)), // Optional: change text color
                              onPressed: () async {
                                await _loginFct();
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 60.0,
                        ),
                        // const SubtitleTextWidget(
                        //   label: "or continue with",
                        // ),

                        // SizedBox(
                        //   height: kBottomNavigationBarHeight + 10,
                        //   child: Row(
                        //     children: [
                        //       const Expanded(
                        //         flex: 2,
                        //         child: SizedBox(
                        //           height: kBottomNavigationBarHeight,
                        //           child: FittedBox(
                        //             child: GoogleButton(),
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       Expanded(
                        //         child: SizedBox(
                        //           height: kBottomNavigationBarHeight,
                        //           child: ElevatedButton(
                        //             style: ElevatedButton.styleFrom(
                        //               padding: const EdgeInsets.all(12.0),
                        //               // backgroundColor: Colors.red,
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(
                        //                   12.0,
                        //                 ),
                        //               ),
                        //             ),
                        //             child: const Text("Guest?"),
                        //             onPressed: () async {
                        //               Navigator.of(context)
                        //                   .pushNamed(RootScreen.routeName);
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          // height: kBottomNavigationBarHeight + 10,
                          child: Column(
                            children: [
                              // Text for "or continue with"
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "or continue with",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Google Button
                                  Expanded(
                                    child: SizedBox(
                                      height: kBottomNavigationBarHeight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            side: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                        ),
                                        onPressed: () {
                                          // Add Google sign-in logic here
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // children: [
                                          //   Image.asset(
                                          //     'assets/icons/google.png', // Path to Google logo
                                          //     height: 20.0,
                                          //   ),
                                          //   const SizedBox(width: 10),
                                          //   const Text(
                                          //     "Google",
                                          //     style: TextStyle(
                                          //         color: Colors.black),
                                          //   ),
                                          // ],
                                          children: [
                                            Icon(
                                              Icons
                                                  .g_mobiledata, // Placeholder for Google icon (use appropriate icon if available)
                                              color: Colors
                                                  .red, // Google's branding color
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              "Google",
                                              style: TextStyle(
                                                color: Colors
                                                    .black, // Text color for Google branding
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Facebook Button
                                  Expanded(
                                    child: SizedBox(
                                      height: kBottomNavigationBarHeight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                        ),
                                        onPressed: () {
                                          // Add Facebook sign-in logic here
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.facebook,
                                                color: Colors.white),
                                            const SizedBox(width: 5),
                                            const Text(
                                              "Facebook",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Apple Button
                                  Expanded(
                                    child: SizedBox(
                                      height: kBottomNavigationBarHeight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                        ),
                                        onPressed: () {
                                          // Add Apple sign-in logic here
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.apple,
                                                color: Colors.white),
                                            const SizedBox(width: 5),
                                            const Text(
                                              "Apple",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              // const SizedBox(height: 10),
                              // Sign-in text

                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.routName);
                                },
                                child: const Text(
                                  "Already have an account? Sign in",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // const SizedBox(
                        //   height: 16.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const SubtitleTextWidget(label: "New here?"),
                        //     TextButton(
                        //       child: const SubtitleTextWidget(
                        //         label: "Sign up",
                        //         fontStyle: FontStyle.italic,
                        //         textDecoration: TextDecoration.underline,
                        //       ),
                        //       onPressed: () {
                        //         Navigator.of(context)
                        //             .pushNamed(RegisterScreen.routName);
                        //       },
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
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
