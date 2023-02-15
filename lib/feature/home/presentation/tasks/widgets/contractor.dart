import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_do_it/constants/colors.dart';
import 'package:just_do_it/constants/svg_and_images.dart';
import 'package:just_do_it/constants/text_style.dart';
import 'package:just_do_it/feature/auth/widget/button.dart';

class Contractor extends StatelessWidget {
  final Size size;
  const Contractor({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1.0),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const AllTasks()));
          //   },
          //   child: Container(
          //     height: 70.h,
          //     width: size.width,
          //     margin: EdgeInsets.symmetric(horizontal: 24.w),
          //     padding: EdgeInsets.symmetric(horizontal: 10.w),
          //     decoration: BoxDecoration(
          //       color: Colors.grey[200],
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: Row(
          //       children: [
          //         const Icon(
          //           Icons.book,
          //           color: ColorStyles.yellowFFD70A,
          //         ),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: const [
          //             Text(
          //               '322 задания',
          //               style: TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             Text('Все задания')
          //           ],
          //         ),
          //         const Spacer(),
          //         const Icon(Icons.keyboard_arrow_right_rounded),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 16.h),
          Container(
            height: 55.h,
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: ColorStyles.greyF9F9F9,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImg.task,
                  color: ColorStyles.yellowFFCA0D,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '322 задания',
                      style: CustomTextStyle.grey_13_w400,
                    ),
                    Text(
                      'Все задания',
                      style: CustomTextStyle.black_13_w400_171716,
                    )
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorStyles.greyBDBDBD,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 55.h,
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: ColorStyles.greyF9F9F9,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImg.archive,
                  color: ColorStyles.yellowFFCA0D,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '322 задания',
                      style: CustomTextStyle.grey_13_w400,
                    ),
                    Text(
                      'В архиве',
                      style: CustomTextStyle.black_13_w400_171716,
                    )
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorStyles.greyBDBDBD,
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Вас выбрали в 3 заданиях',
              style: CustomTextStyle.black_17_w500_171716,
            ),
          ),
          SizedBox(height: 30.h),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                height: 40.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          SvgImg.inProgress,
                          height: 18.h,
                          width: 18.h,
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выполняются',
                          style: CustomTextStyle.black_13_w400_000000,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '1 задания',
                          style: CustomTextStyle.grey_13_w400,
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorStyles.greyBDBDBD,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: const Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ],
          ),

          Column(
            children: [
              SizedBox(height: 18.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                height: 40.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          SvgImg.complete,
                          height: 18.h,
                          width: 18.h,
                        )
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выполнены',
                          style: CustomTextStyle.black_13_w400_000000,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '1 задания',
                          style: CustomTextStyle.grey_13_w400,
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorStyles.greyBDBDBD,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: const Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 18.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                height: 40.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          SvgImg.needSuccess,
                          height: 18.h,
                          width: 18.w,
                        )
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ждут подтверждения',
                          style: CustomTextStyle.black_13_w400_000000,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '1 задания',
                          style: CustomTextStyle.grey_13_w400,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorStyles.greyBDBDBD,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: const Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 102.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 15.h),
          //   child: const Divider(
          //     height: 1,
          //     indent: 20,
          //     endIndent: 20,
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20.w),
          //   height: 55.h,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: const [
          //           Icon(
          //             Icons.archive_sharp,
          //             color: Colors.amber,
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: const [
          //           Text(
          //             'Ждут подтверждения',
          //             style: TextStyle(
          //               color: Colors.black,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Text(
          //             '1 задания',
          //             style: TextStyle(
          //               color: Colors.grey,
          //             ),
          //           )
          //         ],
          //       ),
          //       const Spacer(),
          //       const Icon(
          //         Icons.keyboard_arrow_right_rounded,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 15.h),
          //   child: const Divider(
          //     height: 1,
          //     indent: 20,
          //     endIndent: 20,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomButton(
              onTap: () {},
              btnColor: ColorStyles.yellowFFD70A,
              textLabel: Text(
                'Создать новое',
                style: CustomTextStyle.black_15_w600_171716,
              ),
            ),
          ),
          SizedBox(height: 34.h),
        ],
      ),
    );
  }
}
