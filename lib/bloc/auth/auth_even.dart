abstract class  RegestrationEvent{}
// can't use directly, abstract class is lable for other class

class Submmited extends RegestrationEvent{
  final String email;
  final String password;
  Submmited({
    required this.email, required this.password
  });
} // this is event class, what event is perform like on click submmit button

class GoogleSignIN extends RegestrationEvent{
 
}

class LoginSubmitted extends RegestrationEvent{
  final String email;
  final String password;
  LoginSubmitted({
    required this.email, required this.password
  });

}


