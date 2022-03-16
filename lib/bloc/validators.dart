
import 'package:gmoney/util/utils.dart';



class Validators{

 String? emailValidate(String email){
    if(Utils.instance.emailReg(email)){
      return null;
    }else{
      return "Please enter valid email";
    }
  }

 String? passwordValidate(String password){
   if(password.length > 5){
     return null;
   }else{
     return "Password must be at least 6 characters";
   }
 }

 String? nameValidate(String name){
        if(name.length > 0){
        return null;
        }else{
        return "Enter your name";
        }

 }
 String? titleValidate(String title){
        if(title.length > 0){
        return null;
        }else{
        return "*Please enter title";
        }

 }
 String? messageValidate(String message){
        if(message.length > 0){
        return null;
        }else{
        return "*Please enter message";
        }

 }



String? phoneValidate(String phone) {
  if (phone.length >= 10) {
    return null;
  } else {
    return "phone number must be at least 10 digits";
  }
}

}