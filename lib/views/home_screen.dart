import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal/controler/home_controller.dart';
import 'package:royal/db_handler.dart';
import 'package:royal/model/user_model.dart';
import 'package:royal/utills/app_utills.dart';
import 'package:royal/views/user_screen.dart';
import 'package:royal/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

UserControler controler = Get.put(UserControler());

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
                label: 'Please enter name',
                inputType: TextInputType.text,
                textEditingController: controler.name),
            TextFieldWidget(
                inputType: TextInputType.number,
                label: 'Please enter age',
                textEditingController: controler.age),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // AppUtils.showLoading();
                    // Future.delayed(Duration(seconds: 2));
                    await DBHandler().insertData(DBHandler().userTable, {
                      'name' : controler.name.text,
                      'age'  : controler.age.text
                    });
                    // AppUtils.hideLoading();
                    AppUtils.showSuccessToast('The data has been inserted');
                  },
                  child: const Text('Insert Data')),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // List<UserModel> users = await DBHandler().readData(DBHandler().userTable);
                    // Get.to(UserListScreen(users: users));
                    Get.to(() => UserListScreen());
                  },
                  child: const Text('read Data')),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
