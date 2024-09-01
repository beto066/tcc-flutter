import 'package:flutter/material.dart';
import 'package:tccflutter/util/custom_route_observer.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final String next;
  final CustomRouteObserver observer;

  const MainLayout({super.key, required this.title, required this.observer, this.next = 'Done'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        children: [

          IconButton(icon: const Icon(Icons.add), onPressed: () {
            SurveyDialog.showSurveyDialog(context);
            // Navigator.of(context).pushNamed(next);
          }),
          const Center(child: PersonImage(
            size: 60,
            imageUrl: 'https://media.licdn.com/dms/image/C4D03AQGQSbQ9X96LVw/profile-displayphoto-shrink_200_200/0/1632959045921?e=2147483647&v=beta&t=h5YH3WkLn88QU-1-LK9Kg71ZVCu40eLgCBYY0q3zSMM'
          )),
        ],
      )
    );
  }
}

