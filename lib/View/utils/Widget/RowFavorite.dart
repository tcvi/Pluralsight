import 'package:Pluralsight/Core/models/FavoriteCourse.dart';
import 'package:Pluralsight/View/utils/Widget/Courses.dart';
import 'package:Pluralsight/View/utils/Widget/Favorites.dart';
import 'package:Pluralsight/View/utils/page/MoreFavotite.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

class RowFavoriteCourses extends StatelessWidget {
  final List<FavoriteCourse> favoriteCourses;
  final String title;
  const RowFavoriteCourses({Key key, this.favoriteCourses, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteCourses != null
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoreFavorite(
                                    title: title,
                                  )));
                    },
                    icon: Text(S.current.SeeAll,style: Theme.of(context).textTheme.subtitle1,),
                    label: Icon(
                      Icons.navigate_next,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
              ),
              Favorites(
                courses: favoriteCourses,
              ),
            ],
          )
        : Container();
  }
}
