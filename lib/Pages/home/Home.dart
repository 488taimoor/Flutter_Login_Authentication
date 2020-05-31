import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Blocs/UserBloc.dart';
import 'package:myapp/Blocs/AuthBloc.dart';
import 'package:myapp/SharedPreference/SharedPref.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(child: Center(
          child: BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
//                final value= json.decode(state.UserData);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello Taimoor!",
                    style: TextStyle(fontSize: 40),
                  ),
                  Text("${state.UserData["data"]["fullName"]}"),
                  RaisedButton(
                    child: Text("LogOut", style: TextStyle(color: Colors.black),),
                    onPressed: () async {
                      SharedPref sharedPref = SharedPref();
                      await sharedPref.remove("userData");
                      _authBloc.add(NOTAUTHERIZED_EVENT());
                    },
                  )
                ],
              ),
            );
          }),
        )
        )
    );
  }
}
