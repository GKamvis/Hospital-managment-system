// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});
//
//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _emailController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }
//  Future passwordreset() async {
//     try{
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim(),);
//       showDialog(context: context, builder: (context) {
//         return const AlertDialog(content: Text('email was sent , check your email'),);
//       }
//       );} on FirebaseAuthException catch(e){
//       //print(e);
//       showDialog(context: context, builder: (context) {
//         return AlertDialog(content: Text(e.message.toString()),);
//       },);
//     }
//  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           const Text(
//             "Enter your email we'll send you  a passord reset link ",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 25),
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
//           MaterialButton(
//             onPressed:passwordreset,
//             color: Colors.blueAccent,
//             child: const Text("Send link"),
//           )
//         ],
//       ),
//     );
//   }
// }
