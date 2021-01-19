import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/DownLoad/ManagerData.dart';
import 'package:Pluralsight/Core/models/DownloadModel.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/utils/page/CourseDetail.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CourseListTitle extends StatelessWidget {
  final CourseInfor course;
  final bool isLoaded;

  const CourseListTitle({Key key, this.course, this.isLoaded = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool islogin =
        Provider.of<AccountInf>(context, listen: false).isAuthorization();
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey[600],
        )),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseDetail(
                        course: course,
                      )));
        },
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            image: DecorationImage(
                image: (course.imageUrl!=null)? NetworkImage(course.imageUrl):AssetImage('assets/images/DownloadPage/category1.jpg'), fit: BoxFit.cover),
          ),
          child: Consumer<FavoriteCourses>(
            builder: (context, provider, _) => Align(
              alignment: Alignment.topLeft,
              child: provider.isFavorite(courseId: course.id) && islogin
                  ? Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 15,
                    )
                  : Container(),
            ),
          ),
        ),
        title: Text(
          course.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${course.instructorUserName!=null?course.instructorUserName:course.status.toLowerCase()}",
              style: Theme.of(context).textTheme.subtitle2,
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Format.getInstantDateFormat().format(course.updatedAt),
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
                Text(
                  Format.printDuration(course.totalHours),
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarIndicator(
                  rating: course.ratedNumber * 1.0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    //size: 15,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  direction: Axis.horizontal,
                ),
                 course.price == 0
                     ? Text(S.current.Free,
                         style: Theme.of(context).textTheme.subtitle1)
                     : Text(NumberFormat.currency(locale: "vi")
                         .format(course.price==null?0:course.price), style: Theme.of(context).textTheme.subtitle1)
              ],
            )
          ],
        ),
        isThreeLine: true,
        trailing: Consumer<FavoriteCourses>(
          builder: (context, provider, _) {
            //bool isDownload = provider.containsCourse(course.ID);
            return PopupMenuButton(
                offset: Offset(0, 35),
                captureInheritedThemes: false,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (value) async {
                  switch (value) {
                    case 0:
                      String token =
                          Provider.of<AccountInf>(context, listen: false).token;
                      if (token != null) {
                        Response res = await UserService.likeCourse(
                            token: token, courseId: course.id);
                        if (res.statusCode == 200) {
                          provider.likeCourse(courseInfor: course);
                        } else if (res.statusCode == 401) {
                          Provider.of<AccountInf>(context, listen: false)
                              .logout();
                          print('Chưa Đăng Nhập');
                        }
                      } else {
                        print('Chưa Đăng Nhập');
                      }
                      break;
                    case 1:
                      //HandleAdd2Channel.openDialog(context, course.ID);
                      break;
                    case 2:
                      ManagerData managerData=new ManagerData();
                      await managerData.openDatabase();
                      await managerData.deleteCourse(courseID: course.id,userID: Provider.of<AccountInf>(context,listen: false).userInfo.id);

                      break;
                    case 3:
                      // Provider.of<MyChannelListModel>(context, listen: false)
                      //     .removeCourseInChannel(indexChannel, course.ID);
                      break;
                    default:
                  }
                },
                color: Theme.of(context).popupMenuTheme.color,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        value: 0,
                        child: Text(
                          provider.isFavorite(courseId: course.id)
                              ? S.current.Unlike
                              : S.current.Like,style: Theme.of(context).textTheme.subtitle1,
                        )),
                    isLoaded
                        ? PopupMenuItem(
                            value: 2,
                            child: Text(
                              S.current.Remove,style: Theme.of(context).textTheme.subtitle1,
                            ))
                        : PopupMenuItem(
                            child: Container(),
                            height: 0,
                          ),
                  ];
                });
          },
        ),
      ),
    );
  }
}
