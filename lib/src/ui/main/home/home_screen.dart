import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/data_shimmer.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/home_widget.dart';
import '../../../bloc/data_bloc.dart';
import '../../../bloc/task_bloc.dart';
import '../tasks/tasks/task_view_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int id) onChange;

  const HomeScreen({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int size = 0;

  @override
  void initState() {
    dataBloc.getAllData();
    taskBloc.getTasksAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          StreamBuilder(
            stream: dataBloc.dataFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.data != null) {
                DataModel info = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      height: 300 * h,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20 * w, right: 20 * w, top: 20 * w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21 * h),
                        color: AppTheme.lightGray,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          info.data.isEmpty
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10 * h),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16 * h,
                                          height: 1.4 * h,
                                          letterSpacing: 0.4,
                                          color: AppTheme.black,
                                        ),
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: "Пустой",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: 265.0 * h,
                                    viewportFraction: 0.94,
                                    //aspectRatio: 16 / 9,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 1000),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    onPageChanged: (i, e) {
                                      size = i;
                                      setState(() {});
                                    },
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: info.data.map((index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TaskViewScreen(
                                              data: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16 * w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  EdgeInsets.only(top: 16 * h),
                                              padding: EdgeInsets.all(12 * h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21),
                                                color: AppTheme.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 0),
                                                    blurRadius: 10,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.1),
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    index.date,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14 * h,
                                                      color: AppTheme.gray,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 12 * h,
                                                  ),
                                                  Text(
                                                    "${index.cityFrom} \n ${index.cityTo} ${index.reverse == 1 ? " \n ${index.cityFrom}" : "\n"}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 22 * h,
                                                      color: AppTheme.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${index.car} \n ${Utils.getCarNumber(index.carNumber)}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 20 * h,
                                                      height: 1.4 * h,
                                                      letterSpacing: 0.4,
                                                      color: AppTheme.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < info.data.length; i++)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.bounceInOut,
                                  height: size == i ? 12 * h : 8 * h,
                                  width: size == i ? 12 * w : 8 * w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 18 * h,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20 * w, vertical: 20 * h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12 * w, vertical: 10 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21 * h),
                        color: AppTheme.lightGray,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Активные заявки",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 22 * h,
                              height: 1.4 * h,
                              letterSpacing: 0.2,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(
                            height: 10 * h,
                          ),
                          Container(
                            height: 180 * h,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: info.data.isEmpty
                                ? const Center(
                                    child: Text("Пустой"),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: info.data.length,
                                    itemBuilder: (_, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TaskViewScreen(
                                                data: info.data[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: getHomeTasks(
                                          context,
                                          info.data[index].date,
                                          "${info.data[index].cityFrom} ${info.data[index].cityTo} ${info.data[index].reverse == 1 ? " \n ${info.data[index].cityFrom}" : ""}",
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
          SizedBox(
            height: 20 * h,
          ),
          StreamBuilder(
            stream: taskBloc.taskFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                TaskModel tasks = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20 * w, vertical: 0 * h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10 * w, vertical: 6 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21 * h),
                    color: AppTheme.lightGray,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Основные разделы",
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20 * h,
                          height: 1.4 * h,
                          letterSpacing: 0.4,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(
                        height: 16 * h,
                      ),
                      getContainer(
                        context,
                        "Всего заявок обработано: ",
                        tasks.data.done,
                        AppTheme.blue,
                        (on) {
                          widget.onChange(0);
                        },
                      ),
                      getContainer(
                        context,
                        "Активные текущие заявки: ",
                        tasks.data.active,
                        AppTheme.green,
                        (onChange) {
                          widget.onChange(1);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
        ],
      ),
    );
  }
}
