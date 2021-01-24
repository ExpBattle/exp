import 'User.dart';

class Profile {
  //var user = <User>[];

  String correctFields(User user){
    // Encoding:
    // 0 = all fields are valid
    // 1 = username field is not valid
    // 2 = email field is not valid
    // 3 = password field is not valid
    // 4 = passwords don't match

    String isValid = 'valid';
    if(user.username.isEmpty){
      isValid = 'Please enter a username';
    }else if(user.email.isEmpty){
      isValid = 'Please, enter an email'; //will be changed to valid email later
    }else if(user.password.isEmpty){
      isValid = 'Please, enter a password';
    }
    else if(user.password != user.confirmedPassword){
      isValid = 'Passwords do not match! '
                'Please enter the same password in the password fields.';
    }
    return isValid;
  }
}