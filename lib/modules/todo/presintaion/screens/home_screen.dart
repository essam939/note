import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    notificationServices  =
    LocalNotificationServices(context: context);
    selectedColor = colorsList.first;
    todoBloc = TodoBloc(sl(), sl(), sl(), sl());
    todoBloc.add(GetToDoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      key: _key,
      appBar: AppBar(
        title: Text("ToDo"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            resetdata();
          }, icon: Icon(Icons.menu))
        ],
      ),
      endDrawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NEW TASK"),
              Text("Color"),
              SizedBox(
                height: 28,
                child: ListView.builder(
                  itemCount: colorsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedColor = colorsList[index];
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: selectedColor == colorsList[index]
                            ? Colors.amber
                            : null,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(colorsList[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text("name"),
              TextFormField(
                controller: name,
              ),
              Text("Description"),
              TextFormField(
                controller: description,
              ),
              Text("Date"),
              TextFormField(
                controller: date,
              ),
              Text("Time"),
              TextFormField(
                controller: time,
              ),
              if (!isEdit)
                ElevatedButton(
                    onPressed: () {
                      todoBloc.add(CreateNoteEvent(
                          id: counter,
                          name: name.text,
                          description: description.text,
                          date: date.text,
                          color: selectedColor.toString()));
                      _key.currentState!.openEndDrawer();
                      todoBloc.add(GetToDoListEvent());
                      notificationServices.showNotificationSchedule(id: 1,body: description.text,title: name.text,scheduledTime: DateTime.now().add(Duration(seconds: 1),));
                    },
                    child: Text("Add")),
              if (isEdit)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          todoBloc.add(DeleteNoteEvent(
                            id: uniId,
                          ));
                          _key.currentState!.openEndDrawer();
                          todoBloc.add(GetToDoListEvent());
                        },
                        child: Text("delete")),
                    ElevatedButton(
                        onPressed: () {
                          todoBloc.add(UpdateNoteEvent(
                              id: uniId,
                              name: name.text,
                              description: description.text,
                              date: date.text,
                              color: selectedColor.toString()));
                          resetdata();
                          todoBloc.add(GetToDoListEvent());
                        },
                        child: Text("update")),
                  ],
                ),
            ],
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
        child: Icon(Icons.add),
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
