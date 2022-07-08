import 'package:flutter/material.dart';
import 'src/global_bloc.dart';
import 'src/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MedicineReminder());
}

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({Key key}) : super(key: key);

  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
   GlobalBloc globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
