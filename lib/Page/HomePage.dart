import 'package:Pluralsight/Components/AppBar.dart';
import 'package:Pluralsight/Components/Courses.dart';
import 'package:Pluralsight/Components/RowCourse.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/MoreCourse.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: myAppbar(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Welcome to Pluraslight!',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                          'With Pluralsight, you can build and apply skills in top technologies. You have free access to skill IQ, Role IQ,a limited library of courses and a weekly rotation of new courses.',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RowCourse(title: 'Software Development',courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(1),),
              RowCourse(title: 'IT Operations',courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(2),),
              RowCourse(title: 'Data Professional',courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(3),),
              RowCourse(title: 'Security Professional',courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(4),),
              RowPathView(title:'My Channels')
            ],
          ),
        ),
      ),
    );
  }
}
