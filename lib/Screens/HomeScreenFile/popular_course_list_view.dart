import 'package:bedesten/Screens/HomeScreenFile/Model/category.dart';
import 'package:bedesten/Screens/HomeScreenFile/course_info_screen.dart';
import 'package:bedesten/Screens/HomeScreenFile/design_course_app_theme.dart';
import 'package:bedesten/Screens/HomeScreenFile/home_design_course.dart';
import 'package:flutter/material.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose(); // AnimationController dispose ediliyor
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutunu al
    var screenSize = MediaQuery.of(context).size;
    // Ekran genişliğine göre crossAxisCount değerini belirle
    int crossAxisCount = screenSize.width > 600 ? 3 : 2; // 600px'den geniş ekranlar için 4 sütun, diğerleri için 2 sütun
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: () {
                List<Widget> courseWidgets = [];
                int foundIndex = -1; // Aranan öğe için indeks
                for (int index = 0; index < Category.popularCourseList.length; index++) {
                  final Category category = Category.popularCourseList[index];

                  // Arama terimine göre filtreleme yap
                  if (searchQuery.isNotEmpty &&
                      category.title.toLowerCase().contains(searchQuery.toLowerCase())) {
                    foundIndex = index; // Aranan öğenin indeksini kaydet
                  }

                  // GridView'e öğeyi ekleyin
                  final int count = Category.popularCourseList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  courseWidgets.add(
                    CategoryView(
                      callback: widget.callBack,
                      category: category,
                      animation: animation,
                      animationController: animationController,
                      index: index,
                    ),
                  );
                }

                // Aranan öğeyi 1. sıraya taşı
                if (foundIndex != -1) {
                  final foundWidget = courseWidgets.removeAt(foundIndex);
                  courseWidgets.insert(0, foundWidget);
                }

                return courseWidgets.where((widget) => widget != const SizedBox()).toList();
              }(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: screenSize.width > 600 ? 1 : 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
        this.category,
        this.animationController,
        this.animation,
        this.callback, required this.index})
      : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => CourseInfoScreen(
                      eventName: category!.title,
                      logoIndex: category!.imagePath, // index değerini bu şekilde aktarabilirsiniz
                      UrunSayisi: category!.urunsayisi,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 20,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              //Color(0xFFF8FAFB)
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Color(0xFFF8FAFB),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Text(
                                              category!.title,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis, // Metin sığmadığında üç nokta ekler
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : DesignCourseAppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16,bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : DesignCourseAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                              aspectRatio: 1.0, // Adjust this value based on the desired width-to-height ratio
                              child: Image.asset(category!.imagePath, fit: BoxFit.cover), // BoxFit.cover to ensure the image covers the entire area
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
