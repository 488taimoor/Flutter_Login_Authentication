import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

//Events
abstract class AuthEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class AUTHERIZED_EVENT extends AuthEvents{
  @override
  List<Object> get props => [];
}
class NOTAUTHERIZED_EVENT extends AuthEvents{
  @override
  List<Object> get props => [];
}

//states
class AuthStates extends Equatable{
  @override
  List<Object> get props => [];
}
class AUTH_AUTHERIZED extends AuthStates{}
class AUTH_LOADING extends AuthStates{}
class AUTH_NOTAUTHERIZED extends AuthStates{}


//Bloc
class AuthBloc extends Bloc<AuthEvents, AuthStates> {
//  final AuthBloc _authBloc = new AuthBloc();
//  final AuthRepository _authRepository= new AuthRepository();
  @override
  // TODO: implement initialState
  AuthStates get initialState => AUTH_LOADING();

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async* {
    // TODO: implement mapEventToState
//    return null;
    if (event is AUTHERIZED_EVENT) {
      yield AUTH_AUTHERIZED();
    }else if(event is NOTAUTHERIZED_EVENT){
      yield AUTH_NOTAUTHERIZED();
    }else{
      yield AUTH_LOADING();
    }

  }
}
