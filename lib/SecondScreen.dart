import 'package:flutter/material.dart';
import 'package:flutter_app/network.dart';
import 'package:get/get.dart';

class Secondscreen extends StatefulWidget {
  List<Course> selectedCourse;
  Secondscreen({super.key, required this.selectedCourse});

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Submit form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Selected Courses"),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: widget.selectedCourse.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.selectedCourse[index].name),
                        subtitle: Text(widget.selectedCourse[index].duration),
                      );
                    }),
                ElevatedButton(
                    onPressed: () async {
                      if (name.text == "" || email.text == "") {
                        Get.snackbar("please fill all fields", "fill");
                        return;
                      }
                      if (validateEmail(email.text) != null) {
                        Get.snackbar("email not valid", "fill");

                        return;
                      }
                      var res = await submitCources(
                          name.text,
                          email.text,
                          widget.selectedCourse
                              .map((course) => course.id)
                              .toList());
                      if (res) {
                        Get.snackbar("Success", "Api call successfull");
                        name.text = "";
                        email.text = "";
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("send data"))
              ],
            ),
          ),
        ));
  }
}
