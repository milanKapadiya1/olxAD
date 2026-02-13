abstract class RegestrationState{}

class RegestrationInitial extends RegestrationState{}
class RegestrationLoading extends RegestrationState{}
class RegestrationSuccess extends RegestrationState{}
class RegestrationFailure extends RegestrationState{
  final String error;
  RegestrationFailure({
    required this.error
  });
}



