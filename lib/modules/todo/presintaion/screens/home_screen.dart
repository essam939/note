import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:notes/core/services/local_notifcation.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/todo/domain/entities/todo_item.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_bloc.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_event.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<int> colorsList = [
    0xffFF008D,
    0xff0DC4F4,
    0xffCF28A9,
    0xff3D457F,
    0xff00CF1C
  ];
  late int selectedColor;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  late TodoBloc todoBloc;
  List todoItems = [];
  bool isEdit = false;
  late int uniId;
  late int counter = 0;
  late LocalNotificationServices notificationServices;
  @override
  void initState() {
    notificationServices = LocalNotificationServices(context: context);
    selectedColor = colorsList.first;
    todoBloc = TodoBloc(sl(), sl(), sl(), sl());
    todoBloc.add(GetToDoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawerEnableOpenDragGesture: false,
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "ToDo",
          style: TextStyle(color: Color(0xff181743), fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                resetdata();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      endDrawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
        child: Drawer(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEW TASK",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 31),
                  Text(
                    "Color",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: colorsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedColor = colorsList[index];
                              });
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  selectedColor == colorsList[index]
                                      ? Colors.amber
                                      : Color(colorsList[index]),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(colorsList[index]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "name",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    maxLines: 5,
                    controller: description,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Date",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      DatePickerBdaya.showDatePicker(context,
                          onChanged: (value) {
                        date.text = value.toString().substring(0, 11);
                      });
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: date,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      DatePickerBdaya.showTimePicker(context,
                          showSecondsColumn: false, onChanged: (value) {
                        time.text = value.toString().substring(11, 16);
                      });
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: time,
                    ),
                  ),
                  Spacer(),
                  if (!isEdit)
                    InkWell(
                      onTap: () {
                        todoBloc.add(CreateNoteEvent(
                            id: counter,
                            name: name.text,
                            description: description.text,
                            date: date.text,
                            color: selectedColor.toString()));
                        _key.currentState!.openEndDrawer();
                        todoBloc.add(GetToDoListEvent());
                        notificationServices.showNotificationSchedule(
                            id: 1,
                            body: description.text,
                            title: name.text,
                            scheduledTime: DateTime.now().add(
                              Duration(seconds: 1),
                            ));
                      },
                      child: Container(
                        width: 132,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                                stops: [0, 1],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(0, 255, 255, 1),
                                  Color.fromRGBO(37, 77, 222, 1),
                                ])),
                        child: Center(
                            child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  if (isEdit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            todoBloc.add(DeleteNoteEvent(
                              id: uniId,
                            ));
                            _key.currentState!.openEndDrawer();
                            resetdata();
                            todoBloc.add(GetToDoListEvent());
                          },
                          child: Container(
                            width: 120,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: Text(
                              "delete",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            todoBloc.add(UpdateNoteEvent(
                                id: uniId,
                                name: name.text,
                                description: description.text,
                                date: date.text,
                                color: selectedColor.toString()));
                            todoBloc.add(GetToDoListEvent());
                          },
                          child: Container(
                            width: 120,
                            height: 46,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    stops: [0, 1],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromRGBO(0, 255, 255, 1),
                                      Color.fromRGBO(37, 77, 222, 1),
                                    ])),
                            child: Center(
                                child: Text(
                              "update",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: BlocBuilder<TodoBloc, ToDoState>(
            bloc: todoBloc,
            builder: (context, state) {
              if (state.getNoteState == RequestState.loading) {
                return const CircularProgressIndicator();
              } else if (state.getNoteState == RequestState.loaded) {
                counter = state.toDoListResponse!.length + 1;
                return ListView.builder(
                    itemCount: state.toDoListResponse!.length,
                    itemBuilder: (context, index) {
                      var note = state.toDoListResponse![index];
                      return Container(
                          child: ListTile(
                        onTap: () {
                          editNote(note);
                        },
                        leading: CircleAvatar(
                          backgroundColor: Color(int.parse(note.color)),
                        ),
                        title: Text(note.name),
                        trailing: Text(note.date),
                      ));
                    });
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => resetdata(),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  stops: [0, 1],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(0, 255, 255, 1),
                    Color.fromRGBO(37, 77, 222, 1),
                  ])),
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void editNote(ToDo note) {
    setState(() {
      isEdit = true;
      uniId = note.id;
    });
    name.text = note.name;
    description.text = note.description;
    date.text = note.date;
    _key.currentState!.openEndDrawer();
  }

  void resetdata() {
    setState(() {
      isEdit = false;
    });
    name.clear();
    description.clear();
    date.clear();
    _key.currentState!.openEndDrawer();
  }
}
