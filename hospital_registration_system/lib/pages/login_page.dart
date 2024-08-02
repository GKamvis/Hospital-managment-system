// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'Forgot_password_page.dart';
// class LoginPage extends StatefulWidget {
//   final VoidCallback showRegisterPage;
//   const LoginPage({super.key, required this.showRegisterPage});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
// class _LoginPageState extends State<LoginPage> {
//   // Text controllers
//   final _emailController = TextEditingController();
//   final _paswordController = TextEditingController();
//   // signIn method
//   Future signIn() async {
//     //circle loading
//
//     showDialog(context: context , builder: (context) {
// return Center(child: CircularProgressIndicator());
//     },);
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: _emailController.text.trim(),
//       password: _paswordController.text.trim(),
//     );
//     Navigator.of(context).pop();
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _paswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //logon&sign up
//           const SizedBox(height: 45),
//           const Center(
//             child: Text(
//               "Login ",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           //email textfield
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12.5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 21.0),
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Email",
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           //pasword textfield
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12.5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 21.0),
//                 child: TextField(
//                   controller: _paswordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Pasword",
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Center(
//                     child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return ForgotPasswordPage();
//                         },
//                       ),
//                     );
//                   },
//                   child: Text(
//                     "Forgot password",
//                     style: TextStyle(
//                         color: Colors.blueAccent, fontWeight: FontWeight.bold),
//                   ),
//                 )),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           //sign in button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: GestureDetector(
//               onTap: signIn,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.5),
//                   color: Colors.deepPurple,
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(25.0),
//                   child: Center(
//                       child: Text(
//                     'Sign in ',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   )),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // register
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Not a member?"  ,  style: TextStyle(color: Colors.transparent), ),
//               GestureDetector(
//                 onTap: widget.showRegisterPage,
//                 child: const Text(
//                   "  Register Now" ,
//                   style: TextStyle(color: Colors.transparent),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
