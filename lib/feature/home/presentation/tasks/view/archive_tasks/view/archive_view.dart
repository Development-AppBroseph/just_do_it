import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_do_it/constants/constants.dart';
import 'package:just_do_it/feature/auth/widget/widgets.dart';
import 'package:just_do_it/feature/home/data/bloc/profile_bloc.dart';
import 'package:just_do_it/feature/home/presentation/tasks/view/create_task/view/create_task_page.dart';
import 'package:just_do_it/feature/home/presentation/tasks/view/view_task.dart';
import 'package:just_do_it/feature/home/presentation/tasks/widgets/item_task.dart';
import 'package:just_do_it/models/task.dart';
import 'package:just_do_it/network/repository.dart';
import 'package:just_do_it/widget/back_icon_button.dart';

class ArchiveTasksView extends StatefulWidget {
  ArchiveTasksView({super.key});

  @override
  State<ArchiveTasksView> createState() => _ArchiveTasksViewState();
}

class _ArchiveTasksViewState extends State<ArchiveTasksView> {
  List<Task> taskList = [];
  Task? selectTask;

  @override
  void initState() {
    super.initState();
    getListTask();
  }

  void getListTask() async {
    List<Task> res = await Repository()
        .getMyTaskList(BlocProvider.of<ProfileBloc>(context).access!);
    taskList.clear();
    taskList.addAll(res.reversed);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomIconButton(
                          onBackPressed: () {
                            if (selectTask != null) {
                              selectTask = null;
                              setState(() {});
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: SvgImg.arrowRight,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'В архиве',
                          style: CustomTextStyle.black_22_w700_171716,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                selectTask == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height -
                            20.h -
                            10.h -
                            77.h,
                        child: ListView.builder(
                          itemCount: taskList.length,
                          padding: EdgeInsets.only(top: 15.h, bottom: 100.h),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return itemTask(
                              taskList[index],
                              (task) {
                                setState(() {
                                  selectTask = task;
                                });
                              },
                            );
                          },
                        ),
                      )
                    : TaskView(
                        selectTask: selectTask!,
                        openOwner: (owner) {},
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 34.h),
              child: CustomButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CeateTasks(customer: true);
                      },
                    ),
                  );
                },
                btnColor: ColorStyles.yellowFFD70A,
                textLabel: Text(
                  'Создать новое',
                  style: CustomTextStyle.black_16_w600_171716,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
