import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_do_it/constants/constants.dart';
import 'package:just_do_it/feature/home/data/bloc/profile_bloc.dart';
import 'package:just_do_it/feature/home/presentation/tasks/bloc_tasks/bloc_tasks.dart';
import 'package:just_do_it/feature/home/presentation/tasks/view/task_page.dart';
import 'package:just_do_it/feature/home/presentation/tasks/view/view_profile.dart';
import 'package:just_do_it/feature/home/presentation/tasks/widgets/item_task.dart';
import 'package:just_do_it/feature/theme/settings_scope.dart';
import 'package:just_do_it/models/order_task.dart';
import 'package:just_do_it/models/task/task.dart';
import 'package:just_do_it/models/user_reg.dart';
import 'package:just_do_it/widget/back_icon_button.dart';

class MyAnswersSelectedAsExecutorView extends StatefulWidget {
  final bool asCustomer;
  final String title;
  const MyAnswersSelectedAsExecutorView(
      {super.key, required this.asCustomer, required this.title});

  @override
  State<MyAnswersSelectedAsExecutorView> createState() =>
      _MyAnswersSelectedAsExecutorViewState();
}

class _MyAnswersSelectedAsExecutorViewState
    extends State<MyAnswersSelectedAsExecutorView> {
  List<Task> taskList = [];
  Task? selectTask;
  Owner? owner;
  late UserRegModel? user;
  @override
  void initState() {
    super.initState();
    user = BlocProvider.of<ProfileBloc>(context).user;
    getListTask();
  }

  void getListTask() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    taskList = BlocProvider.of<TasksBloc>(context).tasks;
    return Scaffold(
      backgroundColor:
          SettingsScope.themeOf(context).theme.mode == ThemeMode.dark
              ? DarkAppColors.blackPrima
              : LightAppColors.greyPrimary,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: SettingsScope.themeOf(context).theme.mode ==
                          ThemeMode.dark
                      ? DarkAppColors.blackPrima
                      : LightAppColors.greyPrimary,
                ),
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
                                if (owner != null) {
                                  owner = null;
                                  setState(() {});
                                } else if (selectTask != null) {
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
                              widget.title,
                              style: SettingsScope.themeOf(context)
                                  .theme
                                  .getStyle(
                                      (lightStyles) =>
                                          lightStyles.sf22w700BlackSec,
                                      (darkStyles) =>
                                          darkStyles.sf22w700BlackSec),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                20.h -
                                10.h -
                                82.h,
                            child: ListView.builder(
                              itemCount:
                                  user?.myAnswersSelectedAsExecutor?.length,
                              padding:
                                  EdgeInsets.only(top: 15.h, bottom: 100.h),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (user?.myAnswersSelectedAsExecutor != []) {
                                  return itemTask(
                                      user!.myAnswersSelectedAsExecutor![index],
                                      (task) {
                                    setState(() {
                                      selectTask = task;
                                    });
                                  }, user!, context);
                                }
                                return Container();
                              },
                            ),
                          ),
                          view(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget view() {
    if (owner != null) {
      return Scaffold(
          backgroundColor: LightAppColors.greyPrimary,
          body: ProfileView(owner: owner!));
    }
    if (selectTask != null) {
      return Scaffold(
        backgroundColor: LightAppColors.greyPrimary,
        body: TaskPage(
          task: selectTask!,
          openOwner: (owner) {
            this.owner = owner;
            setState(() {});
          },
          canEdit: false,
          showResponses: true,
        ),
      );
    }
    return Container();
  }
}
