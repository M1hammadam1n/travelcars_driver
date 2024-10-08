   import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/task_model.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  Repository repository = Repository();
  final _tasksFetch = BehaviorSubject<TaskModel>();

  Stream<TaskModel> get taskFeedback => _tasksFetch.stream;

  getTasksAll() async {
    try {
      HttpResult response = await repository.getTask();
      if (response.isSuccess) {
        TaskModel data = taskModelFromJson(
          json.encode(response.result),
        );
        _tasksFetch.sink.add(data);
        return response;
      }
    } catch (_) {}
  }

  dispose() {
    _tasksFetch.close();
  }
}

final taskBloc = TaskBloc();
