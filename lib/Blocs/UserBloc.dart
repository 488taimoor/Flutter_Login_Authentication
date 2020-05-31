import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
//import 'package:myapp/Pages/Auth_Page/Auth_Bloc.dart';
//import 'package:myapp/Pages/Auth_Repository.dart';
//import 'package:myapp/SQFlite/authHelper.dart';
//import 'package:myapp/Services/Service.dart';

//Events
abstract class UserEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class SETDATA extends UserEvents{
  final Object data;

  SETDATA({
    @required this.data
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() =>
      'API_CALL data';
}

//states
class UserStates extends Equatable{
  @override
  List<Object> get props => [];
  var UserData = null;
}
class NEW extends UserStates{}
class LOADING extends UserStates{}
class SUCCESS extends UserStates{
  final Data;
  SUCCESS(this.Data);
  dynamic get UserData=>Data;
  @override
  // TODO: implement props
  List<Object> get props => [Data];
}
class FAILED extends UserStates{
  final message;
  FAILED(this.message);
  dynamic get UserData => message;

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


//Bloc
class UserBloc extends Bloc<UserEvents, UserStates> {
//  final AuthBloc _authBloc = new AuthBloc();
//  final AuthRepository _authRepository= new AuthRepository();
  @override
  // TODO: implement initialState
  UserStates get initialState => NEW();

  @override
  Stream<UserStates> mapEventToState(UserEvents event) async* {
    // TODO: implement mapEventToState
//    return null;
    if (event is SETDATA) {
      print('this is Userg data ${event.data} $state');
      yield SUCCESS(event.data);
    }

  }
}
