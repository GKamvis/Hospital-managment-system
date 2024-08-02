// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class RegisterPage extends StatefulWidget {
//   final VoidCallback showLoginPage;
//
//   const RegisterPage({super.key, required this.showLoginPage});
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
// class _RegisterPageState extends State<RegisterPage> {
//   final _emailController = TextEditingController();
//   final _paswordController = TextEditingController();
//   final _confrimPaswordController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _ageController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _paswordController.dispose();
//     _confrimPaswordController.dispose();
//     _nameController.dispose();
//     _lastNameController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }
//
//
//   Future signUp() async {
//     if(passwordconfrimed()){
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _paswordController.text.trim());
//       // create user
//       addUserDetails(
//           _nameController.text.trim(),
//           _lastNameController.text.trim(),
//           _emailController.text.trim(),
//           int.parse(_ageController.text.trim()),
//
//
//       );
//
//
//
//     }
//
//
//   }
//
//   Future addUserDetails(String Name, String LastName , String Email , int Age) async{
//     await FirebaseFirestore.instance.collection('users').add({
//       'name': Name,
//       'last name': LastName,
//       'email':Email,
//       'age': Age,
//     });
//   }
//
//
//
//  bool passwordconfrimed(){
//     if (_paswordController.text.trim()==_confrimPaswordController.text.trim()){
//       return true;
//     }
//     else{
//       return false;
//     }
//  }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //logon&sign up
//             const SizedBox(height: 45),
//             const Center(
//               child: Text(
//                 "Sign Up",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             //name textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Name",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Last name text field
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _lastNameController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Last name",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             //age  textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _ageController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Age",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             //email textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Email",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             //pasword textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _paswordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Pasword",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//         //confirm pasword
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.5),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 21.0),
//                   child: TextField(
//                     controller: _confrimPaswordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: " Confrim new pasword",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: GestureDetector(
//                 onTap: signUp,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.5),
//                     color: Colors.deepPurple,
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(25.0),
//                     child: Center(
//                         child: Text(
//                       'Sign Up ',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // register
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Im a member?"),
//                 GestureDetector(
//                   onTap: widget.showLoginPage,
//                   child: const Text(
//                     "  Login Now",
//                     style: TextStyle(color: Colors.deepPurple),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
