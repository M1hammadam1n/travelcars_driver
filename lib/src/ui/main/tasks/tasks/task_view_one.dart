import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/main.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import '../../../../model/api_model/data_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/profile_widget.dart';

class TaskViewOneScreen extends StatefulWidget {
  final Datum data;

  const TaskViewOneScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TaskViewOneScreenState createState() => _TaskViewOneScreenState();
}

class _TaskViewOneScreenState extends State<TaskViewOneScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 8 * w,
              right: 8 * w,
              top: 16,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Заказчик",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18 * h,
                      height: 1.4 * h,
                      color: AppTheme.black,
                    ),
                  ),
                  getTextController(
                    context,
                    widget.data.userName,
                    "Имя",
                  ),
                  getTextController(
                    context,
                    widget.data.price,
                    "Стоимость поездки",
                  ),
                  getTextController(
                    context,
                    widget.data.paid == ""
                        ? listMoney[0]
                        : widget.data.paid == "cash"
                            ? listMoney[1]
                            : widget.data.paid == "uzcard"
                                ? listMoney[2]
                                : widget.data.paid == "transfer"
                                    ? listMoney[3]
                                    : widget.data.paid == "visa"
                                        ? listMoney[4]
                                        : listMoney[5],
                    "Статус оплаты",
                  ),
                  getTextController(
                    context,
                    // ignore: unrelated_type_equality_checks
                    " ${widget.data.rating == "" ? "нет" : widget.data.rating}",
                    "Отзыв",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskViewTwoScreen extends StatefulWidget {
  final Datum data;

  const TaskViewTwoScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TaskViewTwoScreenState createState() => _TaskViewTwoScreenState();
}

class _TaskViewTwoScreenState extends State<TaskViewTwoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 8 * w,
              right: 8 * w,
              top: 14,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Детали поездки",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18 * h,
                      height: 1.4 * h,
                      color: AppTheme.black,
                    ),
                  ),
                  getTextController(
                    context,
                    "${widget.data.car} (${widget.data.carNumber})",
                    "Авто",
                  ),
                  getTextController(
                    context,
                    widget.data.date,
                    "Дата поездки",
                  ),
                  getTextController(
                    context,
                    widget.data.cityFrom,
                    "Пункт А",
                  ),
                  getTextController(
                    context,
                    widget.data.cityTo,
                    "Пункт Б",
                  ),
                  getTextController(
                    context,
                    widget.data.comment == ""
                        ? "Нет комментариев"
                        : widget.data.comment,
                    "Комментарий заказчика",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
