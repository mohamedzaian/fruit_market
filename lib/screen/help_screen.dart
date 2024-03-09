import 'package:flutter/material.dart';
import 'package:fruit_market/utils/main_color.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }
  int selectedStars = 0;
  String date = DateFormat.yMEd('en_US').format(DateTime.now());
  String dateHour=DateFormat.Hm('en_US').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
          title: Text(
            'Help',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
            color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: Text(
                '''Lorem Ipsum is simply dummy text of the printing
and typesetting industry. Lorem Ipsum has been
the industry’s standard dummy text ever since the
1500s, when an unknown printer took a galley of
type and scrambled it to make a type specimen
book. It has survived not only five centuries, but
also the leap into electronic typesetting, remaining
essentially unchanged. It was popularised in the
1960s with the release of Letraset sheets containing
Lorem Ipsum passages, and more recently with
desktop publishing software like Aldus PageMaker
including versions of Lorem Ipsum.
        ''',
                style: TextStyle(fontSize: 14, color: Colors.black,
                fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 18,),
            Text(date),
            SizedBox(height: 18,),
            Text(dateHour)


          ],
        ),
      ),
    );
  }
}
