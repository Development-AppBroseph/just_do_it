import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_do_it/constants/constants.dart';
import 'package:just_do_it/core/firebase/fcm.dart';
import 'package:just_do_it/core/utils/toasts.dart';
import 'package:just_do_it/feature/auth/bloc/auth_bloc.dart';
import 'package:just_do_it/feature/auth/view/apple_sign_in.dart';
import 'package:just_do_it/feature/auth/view/google_sign_in.dart';
import 'package:just_do_it/feature/auth/widget/widgets.dart';
import 'package:just_do_it/feature/home/data/bloc/profile_bloc.dart';
import 'package:just_do_it/helpers/router.dart';
import 'package:just_do_it/widget/back_icon_button_black.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final visiblePasswordController = StreamController<bool>();
  bool visiblePassword = false;
  bool forgotPassword = false;

  TextEditingController loginController = TextEditingController();
  TextEditingController signinLoginController = TextEditingController();
  TextEditingController signinPasswordController = TextEditingController();

  FocusNode focusNodeLogin = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeResetLogin = FocusNode();

  CustomAlert customAlert = CustomAlert();

  @override
  void dispose() {
    visiblePasswordController.close();
    super.dispose();
  }

  void requestStage1() {
    if (signinLoginController.text.isEmpty) {
      focusNodeLogin.requestFocus();
    } else if (signinPasswordController.text.isEmpty) {
      focusNodePassword.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: BlocBuilder<AuthBloc, AuthState>(buildWhen: (previous, current) {
        Loader.hide();
        if (current is ResetPasswordSuccessState) {
          Navigator.of(context).pushNamed(AppRoute.confirmPhoneCode,
              arguments: [loginController.text]);
        } else if (current is ResetPasswordErrorState) {
          customAlert.showMessage('user_not_found'.tr());
        } else if (current is SignInSuccessState) {
          BlocProvider.of<ProfileBloc>(context).setAccess(current.access);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.home, ((route) => false));
        } else if (current is SignInErrorState) {
          customAlert.showMessage('wrong_credentials_or_usernotfound'.tr());
        } else if (current is GoogleSignInSuccessState) {
          BlocProvider.of<ProfileBloc>(context).setAccess(current.accessToken);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.home, (route) => false);
        } else if (current is GoogleSignInErrorState) {
          customAlert.showMessage(current.errorMessage);
        } else if (current is AppleSignInSuccessState) {
          BlocProvider.of<ProfileBloc>(context).setAccess(current.accessToken);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.home, (route) => false);
        } else if (current is AppleSignInErrorState) {
          customAlert.showMessage(current.errorMessage);
        }
        return false;
      }, builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      CustomIconButtonBlack(
                        onBackPressed: () {
                          if (forgotPassword) {
                            forgotPassword = !forgotPassword;
                            setState(() {});
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Center(
                      child: Text(
                        'jobyfine'.toUpperCase(),
                        style: CustomTextStyle.sf22w700(
                                LightAppColors.blackSecondary)
                            .copyWith(
                          fontSize: 39,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'SFBold',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 82.h),
                  forgotPassword ? secondStage() : firstStage(),
                  const Spacer(),
                  Column(
                    children: [
                      CustomButton(
                        onTap: () async {
                          if (!mounted) return;

                          if (forgotPassword &&
                              loginController.text.isNotEmpty) {
                            showLoaderWrapper(context);
                            BlocProvider.of<AuthBloc>(context)
                                .add(RestoreCodeEvent(loginController.text));
                          } else {
                            final token = await getFcmToken();
                            if (!context.mounted) return;

                            showLoaderWrapper(context);
                            BlocProvider.of<AuthBloc>(context).add(
                              SignInEvent(
                                signinLoginController.text,
                                signinPasswordController.text,
                                token.toString(),
                              ),
                            );
                          }
                        },
                        textLabel: Text(
                          forgotPassword ? 'send'.tr() : 'sign_in'.tr(),
                          style: CustomTextStyle.sf17w600(
                              LightAppColors.blackSecondary),
                        ),
                        btnColor: LightAppColors.yellowPrimary,
                      ),
                      SizedBox(height: 18.h),
                      CustomButton(
                        onTap: () {
                          if (forgotPassword) {
                            setState(() {
                              loginController.text = '';
                              forgotPassword = false;
                            });
                          } else {
                            Navigator.of(context).pushNamed(AppRoute.signUp);
                          }
                        },
                        textLabel: Text(
                          forgotPassword ? 'back'.tr() : 'registration'.tr(),
                          style: CustomTextStyle.sf17w400(
                              LightAppColors.blackAccent),
                        ),
                        btnColor: LightAppColors.greyError,
                      ),
                    ],
                  ),
                  SizedBox(height: 34.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget firstStage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'entrance'.tr(),
          style: CustomTextStyle.sf22w700(LightAppColors.blackSecondary),
        ),
        SizedBox(height: 18.h),
        CustomTextField(
          hintText: 'phone_or_mail'.tr(),
          height: 50.h,
          focusNode: focusNodeLogin,
          textEditingController: signinLoginController,
          hintStyle: CustomTextStyle.sf15w400(LightAppColors.greySecondary),
          onFieldSubmitted: (value) {
            requestStage1();
          },
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        ),
        SizedBox(height: 18.h),
        CustomTextField(
          hintText: 'password'.tr(),
          height: 50.h,
          focusNode: focusNodePassword,
          obscureText: !visiblePassword,
          onFieldSubmitted: (value) {
            requestStage1();
          },
          suffixIcon: GestureDetector(
            onTap: () {
              visiblePassword = !visiblePassword;
              setState(() {});
            },
            child: visiblePassword
                ? const Icon(Icons.remove_red_eye_outlined)
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/eye_close.svg',
                        height: 18.h,
                      ),
                    ],
                  ),
          ),
          textEditingController: signinPasswordController,
          hintStyle: CustomTextStyle.sf15w400(LightAppColors.greySecondary),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  forgotPassword = true;
                });
              },
              child: Text(
                '${'forgot_your_password'.tr()}?',
                style: CustomTextStyle.sf17w400(LightAppColors.blackAccent),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleSignInButton(),
            SizedBox(
              width: 10,
            ),
            AppleSignInButton(),
          ],
        ),
      ],
    );
  }

  Widget secondStage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'restoring_access'.tr(),
              style: CustomTextStyle.sf22w700(LightAppColors.blackSecondary),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        CustomTextField(
          hintText: 'phone_or_mail'.tr(),
          height: 50.h,
          focusNode: focusNodeResetLogin,
          textEditingController: loginController,
          hintStyle: CustomTextStyle.sf15w400(LightAppColors.greySecondary),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 85.h,
          child: Text(
            'to_reset_the_password_enter_the_phone_number_or_mail'.tr(),
            style: CustomTextStyle.sf17w400(LightAppColors.blackAccent),
          ),
        )
      ],
    );
  }
}
