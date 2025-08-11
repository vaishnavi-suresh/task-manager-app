
import 'package:flutter/material.dart';
import 'package:learn_flutter/features/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_flutter/utils/constants.dart';
import 'package:learn_flutter/features/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



//Do a full rebuild
class _HomeScreenState extends State<HomeScreen> {
  final User user = Auth().currentUser!;


  Future <void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  String _userId() {
    print(user.uid);
    return user.uid;
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("sign out"));
  }
  late final ListController selectListController;
  late  Future<List<dynamic>> allLists;

  void initState()  {
    super.initState();
    selectListController = ListController();
    allLists = selectListController.fetchAllLists(user.uid);
  }

  void _refresh(){
    setState(() {
      allLists = selectListController.fetchAllLists(user.uid);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //TO DO: add background and formatting
        child: FutureBuilder<List<dynamic>?>(
          future: selectListController.fetchAllLists(_userId()),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>?> snapshot) {
            // It's good practice to handle connection states and errors here
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                children: [
                  ...snapshot.data!.map<Widget>((list)  =>

                          ListTile(

                          title: Text(list[0]['listName']),
                          // Added null check
                          titleTextStyle: FontStyles.body,
                          onTap: () async {
                            await selectListController.selectList(list[0], list[0]['userId']);
                            Navigator.pop(
                                context);
                            _refresh();
                          },
                          )

                  ),
                  ElevatedButton(
                      onPressed: () async => {await Auth().signOut()},
                      child: Text("Sign Out"))
                ],
              );
            }
            return Center(child: Text("No lists")); // Fallback for no data
          },
        ),
      ),
      appBar: AppBar(
        title: GestureDetector(child: Text('Task Manager'),onTap: () {
          selectListController.selectList(null, user.uid);
          _refresh();}),
        titleTextStyle: FontStyles.heading,
        backgroundColor: AllColors.primaryAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: AllColors.cardBackground,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: selectListController.fetchAllLists(_userId()),
        // Make sure user is not null here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data != null) {
            if (selectListController.listName !=
                null) {
              print('LIST NAMES ${selectListController
                  .listName}'); // This implies _selectListController.selectedList is reflected in _selectListController
              return SingleChildScrollView( // Added for potentially long lists
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${selectListController.listName}',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ...?selectListController.tasks?.map(
                          (task) =>
                          CheckboxListTile(
                              title: Text(task["taskName"] ),
                              value: task["taskStatus"] ,
                              secondary: IconButton(onPressed: () async {
                                await selectListController.deleteTask(task['userId'], task['listId'], task['taskId']);
                                _refresh();
                              }, icon: Icon(Icons.delete)),
                              onChanged: (status) {
                                selectListController.setTaskStatus(task);
                                _refresh();
                              },

                            ),

                          ),


                    genericInputForm(hint: "New Task Name", onSubmitted: (value) {
                      selectListController.createNewTask(value, _userId(), selectListController.listId);
                      _refresh();})

                  ],
                ),
              );
            } else if (selectListController.allLists!.isNotEmpty) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(children:[Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectListController.allLists!.map<Widget>((list) {
                    return
                      Dismissible(key: Key(list[0]["listId"].toString()),
                    confirmDismiss: (direction) async {
                        await selectListController.deleteList(list[0]['userId'], list[0]['listId']);
                        _refresh();
                    },
                    child: Card( // Added Card for better visual separation of lists
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${list[0]["listName"]}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            ...list[1]
                                .map<Widget>(
                                  (task) =>
                                  CheckboxListTile(
                                    title: Text(
                                        task["taskName"] ?? 'Unnamed Task'),
                                    value: task["taskStatus"],
                                    secondary: IconButton(onPressed: () async {
                                      await selectListController.deleteTask(task['userId'], task['listId'], task['taskId']);
                                      _refresh();
                                    }, icon: Icon(Icons.delete)),
                                    onChanged: (status) {

                                      selectListController.setTaskStatus(task);
                                      selectListController.fetchAllLists(_userId());
                                      _refresh();
                                    },
                                  ),
                            ),
                            SizedBox(height: 8),
                            genericInputForm(hint: "New Task Name", onSubmitted: (value) {
                              selectListController.createNewTask(value, _userId(), list[0]["listId"]);
                              _refresh();
                            }),

                          ],
                        ),
                      ),
                    ));

                  }).toList(),

                ),
                  genericInputForm(
                      hint: "enter list name", onSubmitted: (value) {
                    selectListController.createNewList(value, _userId());
                    _refresh();
                  }),
              ]));
            } else {
              print(selectListController.allLists);
              // No lists exist yet, show option to create one
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No lists found. Create one to get started!"),
                    genericInputForm(
                        hint: "enter list name", onSubmitted: (value) {
                      selectListController.createNewList(value, _userId());
                      _refresh();
                    }),

                    SizedBox(height: 20),

                  ],
                ),
              );
            }
          }
          // Fallback for when snapshot has no data but no error (e.g., future returns null)
          return Center(child: Text("Loading data or no data available."));
        },
      ),
    );
  }
}



//TO DO: top home button to reset selected list
//TO DO: delete functionality



class genericInputForm extends StatefulWidget {
  final String hint;
  final void Function(String)? onSubmitted;

  const genericInputForm({super.key, required this.hint, this.onSubmitted});

  @override
  State<genericInputForm> createState() => _genericInputFormState();
}



class _genericInputFormState extends State<genericInputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newListController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
          controller: _newListController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hint,
          ),
            onFieldSubmitted: (value) {
            if (_formKey.currentState!.validate()){
              widget.onSubmitted?.call(value.trim());
              }
            },

  ),

    ],
    )
    );
  }
}


      //ADD IN INPUT FUNCTIONALITY

