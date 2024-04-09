import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/utility/custom_form_field.dart';
import 'package:praktitask/utility/custom_toast.dart';
import 'package:praktitask/utility/styles.dart';
import 'dart:math' as math;

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  TextEditingController usernameController = TextEditingController();
  ValueNotifier<bool> loadingListener = ValueNotifier(false);
  ValueNotifier<bool> searchUserListener = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    fetchLastUsername();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void handleSaveUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loadingListener.value = true;
    if (usernameController.text.isEmpty) {
      loadingListener.value = false;
      if (!mounted) return;
      CustomToast().error(context, "Please enter a username");
      return;
    }
    pref.setString("username", usernameController.text);
    if (!mounted) return;
    CustomToast().success(context, "Welcome to the club...");
    loadingListener.value = false;
    context.go("/home");
  }

  void fetchLastUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    searchUserListener.value = true;
    if (pref.getString('username') == null) {
      searchUserListener.value = false;
    } else {
      searchUserListener.value = false;
      context.go("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 0.14.sh,
              ),
              Center(
                child: Transform.rotate(
                  angle: -math.pi / 20,
                  child: Image.asset(
                    "assets/onboard.png",
                    width: 0.8.sw,
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder(
              valueListenable: searchUserListener,
              builder: (context, value, child) {
                if (value) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                    height: 0.4.sh,
                    width: 1.sw,
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpacingDiagonal,
                        Text(
                          "Just PraktiTask..",
                          style: bold.copyWith(fontSize: 25.sp),
                        ),
                        const Spacer(),
                        Text(
                          "Searching last username data...",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        10.verticalSpacingDiagonal,
                        SizedBox(
                            width: 20.dg,
                            height: 20.dg,
                            child: const CircularProgressIndicator(
                              strokeWidth: 5,
                            )),
                        const Spacer(),
                        SizedBox(
                            height: 40.dg,
                            width: 1.sw,
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                onPressed: null,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text("Get Started"),
                                    10.horizontalSpaceDiameter,
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20.sp,
                                    )
                                  ],
                                )))
                      ],
                    ),
                  );
                }
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                  height: 0.4.sh,
                  width: 1.sw,
                  padding: EdgeInsets.all(16.dg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpacingDiagonal,
                      Text(
                        "Just PraktiTask..",
                        style: bold.copyWith(fontSize: 25.sp),
                      ),
                      10.verticalSpacingDiagonal,
                      Text(
                        "I think you'r new here, Please write your name below and click the blue button..",
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      10.verticalSpacingDiagonal,
                      CustomFormField(
                          controller: usernameController, title: "Username", hint: "Your Username"),
                      const Spacer(),
                      ValueListenableBuilder(
                        valueListenable: loadingListener,
                        builder: (context, value, child) => SizedBox(
                            height: 40.dg,
                            width: 1.sw,
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                onPressed: value ? null : handleSaveUsername,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text("Get Started"),
                                    10.horizontalSpaceDiameter,
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20.sp,
                                    )
                                  ],
                                ))),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
