// class UserUProfile {
//   final String uid;
//   final String userName;
//   final String email;
//   final String dob;

//   UserProfile(
//       {required this.userName,
//       required this.email,
//       required this.dob,
//       required this.uid});

//   UserProfile.fromData(Map<String, dynamic> data)
//       : uid = data['uid'],
//         userName = data['userName'],
//         email = data['email'],
//         dob = data['dob'];

//   Map<String, dynamic> toJson(){
//     return {
//       'uid' : uid,
//       'userName' : userName,
//       'email' : email,
//       'dob': dob
//     };
//   }
// }

class UserProfile {
  final String uid;

  UserProfile({required this.uid});
}
