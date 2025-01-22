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
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  String? validateEmail(String? value) {
    // Check if email is empty
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Simple regex to validate the email format
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
          title: Text("Submit form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(hintText: "User name"),
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Selected Courses"),
              SizedBox(
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
                      setState(() {});
                    }
                  },
                  child: const Text("send data"))
            ],
          ),
        ));
  }
}
