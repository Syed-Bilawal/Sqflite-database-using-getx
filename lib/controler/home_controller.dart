import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal/db_handler.dart';
import 'package:royal/model/user_model.dart';

class UserControler extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController updateName = TextEditingController();
  TextEditingController updateAge = TextEditingController();
    var users = <UserModel>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchUsers();
  // }

  void fetchUsers() async {
    // Fetch users from the database
    // List<UserModel> fetchedUsers = await DBHandler().readData(DBHandler().userTable);
     List<Map<String, dynamic>> userData =  await DBHandler().readData(DBHandler().userTable);
                    List<UserModel> fetchedUsers = userData.map((data) => UserModel.fromJson(data)).toList();
    users.value = fetchedUsers;
  }

  void deleteUser(int id) async {
    await DBHandler().deleteData(DBHandler().userTable,id);
    users.removeWhere((user) => user.id == id);
  }

   Future<void> updateUser(int id, String name, int age) async {
    try {
      await DBHandler().updateData(DBHandler().userTable , id, name, age);
      // Update the user in the list
      int index = users.indexWhere((user) => user.id == id);
      if (index != -1) {
        users[index] = UserModel(id: id, name: name, age: age);
      }
    } catch (e) {
      // Handle error
      print('Update failed: $e');
    }
  }
}
