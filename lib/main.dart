import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Blocs/AuthBloc.dart';
import 'package:myapp/Blocs/UserBloc.dart';
import 'package:myapp/AuthLoading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(
              create: (BuildContext context) => UserBloc(),
            ),
            BlocProvider<AuthBloc>(
              create: (BuildContext context) => AuthBloc(),
            ),
          ],
          child: AuthLoading(),

        )
      ),
    );
  }
}


