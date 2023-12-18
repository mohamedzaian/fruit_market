import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/login_cubit.dart';
import 'package:fruit_market/screen/home_screen.dart';
import 'package:fruit_market/utils/custom_text.dart';
import 'package:fruit_market/utils/main_color.dart';

class CompleteInfoScreen extends StatefulWidget {
  CompleteInfoScreen({super.key});

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final name = LoginCubit().name;
  final phone = LoginCubit().phone;
  final address = LoginCubit().adress;

  @override
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('success'),
                backgroundColor: Colors.green,
              ));
              print ('my name is ${name.text}');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }), (route) => false);
            }
            if (state is faild) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red));
              print('the error is ${state.message}');
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is loading) {
                return (Center(
                  child: CircularProgressIndicator(),
                ));
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomText(text: 'Enter Your Name'),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: Color(0xffCCCCCC))),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomText(text: 'Enter Your Phone Number'),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xffCCCCCC))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "the phone can't be empty";
                              }
                              if (value.length < 11 && value.length != 11) {
                                return 'the phone should be 11 number';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomText(text: 'Add Address'),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: address,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: Color(0xffCCCCCC))),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: ElevatedButton(
                              onPressed: () {if (key.currentState!.validate()) {
                                  if (name.text.isEmpty || address.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("the text can't be empty"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 4),
                                    ));
                                  } else {
                                    context.read<LoginCubit>().login();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
