import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal/controler/home_controller.dart';
import 'package:royal/db_handler.dart';
import 'package:royal/model/user_model.dart';
import 'package:royal/widgets/text_field_widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserControler userController = Get.put(UserControler());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stored Data'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (userController.users.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        return ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            UserModel user = userController.users[index];
            return ListTile(
              leading: Text('ID: ${user.id ?? "N/A"}'),
              title: Text(user.name),
              subtitle: Text('Age: ${user.age}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      Get.dialog(Dialog(
                        child: SizedBox(
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFieldWidget(
                                    inputType: TextInputType.text,
                                    label: 'please enter the name',
                                    textEditingController:
                                        userController.updateName),
                                TextFieldWidget(
                                    inputType: TextInputType.number,
                                    label: 'please enter the age',
                                    textEditingController: userController.age),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Cencel')),
                                          ElevatedButton(
                                         onPressed: () async {
                                        // Retrieve updated values from controllers
                                        String updatedName = userController.updateName.text;
                                        int updatedAge = int.tryParse(userController.age.text) ?? user.age;
                                        
                                        await userController.updateUser(user.id!, updatedName, updatedAge);
                                        Get.back(); // Close the dialog
                                      },
                                        child: const Text('Submit')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                      // final updatedUser = await _editUser(context, user);
                      // if (updatedUser != null) {
                      //   userController.editUser(updatedUser);
                      // }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      userController.deleteUser(user.id!);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Future<UserModel?> _editUser(BuildContext context, UserModel user) async {
    // Handle edit functionality here
    // Example: open a dialog to edit user information
    return null; // Return the updated user model if changes are made
  }
}
