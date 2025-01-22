import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/SecondScreen.dart';
import 'package:flutter_app/network.dart';
import 'package:flutter_app/stateController.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => stateController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  List<Course> courses = [];

  TextEditingController search = new TextEditingController();

  getCourses() async {
    var data = await getCoursesApi();
    context.read<stateController>().setCourses(data);
    print(context.read<stateController>().courses);
  }

  @override
  void initState() {
    getCourses();
  }

  List<Course> selectedCourse = [];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: pageIndex == 1
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: const Icon(Icons.arrow_back))
                : null,
            title: const Text("Course Management"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //         child: TextField(
                //       controller: search,
                //       decoration: const InputDecoration(hintText: "Search"),
                //     )),
                //     IconButton(
                //         onPressed: () {
                //           String query = search.text;
                //         },
                //         icon: const Icon(Icons.search)),
                //   ],
                // ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context.watch<stateController>().courses.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        onChanged: (value) {
                          if (value == true) {
                            selectedCourse.add(Provider.of<stateController>(
                                    context,
                                    listen: false)
                                .courses[index]);
                          } else {
                            selectedCourse.remove(Provider.of<stateController>(
                                    context,
                                    listen: false)
                                .courses[index]);
                          }
                          setState(() {});
                        },
                        title: Text(Provider.of<stateController>(
                          context,
                        ).courses[index].name),
                        subtitle: Text(Provider.of<stateController>(
                          context,
                        ).courses[index].duration),
                        value: selectedCourse
                            .contains(Provider.of<stateController>(
                          context,
                        ).courses[index]),
                      );
                    }),
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                        transition: Transition.leftToRight,
                        Secondscreen(
                          selectedCourse: selectedCourse,
                        ));
                    // setState(() {
                    //   pageIndex = 1;
                    // });
                  },
                  child: const Text("Continue"),
                ),
              ],
            ),
          )),
    );
  }
}
