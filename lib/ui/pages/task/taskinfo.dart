import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/domain/controllers/task.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/domain/models/task.dart';
import 'package:yss_todo/ui/pages/task/widgets/appbar.dart';
import 'package:yss_todo/ui/pages/task/widgets/datepicker.dart';
import 'package:yss_todo/ui/pages/task/widgets/priorityswitcher.dart';
import 'package:yss_todo/ui/pages/task/widgets/taskdeletebtn.dart';

import '../../../domain/controllers/home.dart';
import '../../../i18n/strings.g.dart';

// Страница используется как для отображения диалога нового таска так и для
// отображения информации о существующего таска
class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    logger.i('Opening the task page');
    // получаем id
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // если id отсутствует, то страница считается страницей создания таска
    var id = arguments != null ? (arguments as Map)['id'] : null;
    
    var task = id != null
        ? GetIt.I<HomeController>()
            .taskList
            .firstWhere((element) => element.id == id)
        : TaskModel();

    logger.i(id == null ? 'Its new task' : 'Task id: $id');

    logger.i('Task controller initialization');
    var controller = TaskController(task);

    logger.i('Drawing task page widgets');
    // Тут не скафолд потому что эта страница может отображаться в ботомщите, а скафолд занимает всё пространство
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: appPadding * 2),
            TaskAppBar(controller: controller),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// Поле для ввода названия таска
                  Card(
                    margin: const EdgeInsets.all(appPadding * 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: appPadding * 2),
                      child: TextField(
                        minLines: 5,
                        maxLines: null,
                        controller: controller.nameControl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: t.taskpage.name,
                        ),
                      ),
                    ),
                  ),
                  // Переключатель приоритета
                  PrioritySwitcher(controller: controller),
                  const Divider(height: 0),
                  // Выбор сроков
                  DueDatePicker(controller: controller),
                  
                  // Если это страница существующего таска отображаем кнопку удаления
                  if (id != null) const Divider(height: 0),
                  if (id != null) TaskDeleteButton(model: task),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
