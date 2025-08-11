import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ListController extends ChangeNotifier {
  String? _listName;
  int? _listId;
  List<dynamic>? _tasks;
  List<dynamic>? _allLists;

  String? get listName => _listName;
  int get listId => _listId!;

  List<dynamic>? get tasks => _tasks;
  List<dynamic>? get allLists => _allLists;
  set allLists (List<dynamic>? value){
    _allLists = value;
    notifyListeners();
  }


  Future<List<dynamic>> fetchAllLists(userId) async {
    List<List<dynamic>> allTasks = [];
    final response= await http.get(Uri.parse('${dotenv.env["LOCALHOST_URL"]}/lists/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    print('RES BODY: ${response.body}');
    try {
      List<dynamic> listNames = jsonDecode(response.body);
      print('LIST NAMES: $listNames');
      for (var list in listNames) {
        List<dynamic> tasks = await fetchTaskNames(list["listId"], userId);
        print('TASKS: $tasks ${list["listId"]}');
        if (tasks.isNotEmpty){
          allTasks.add([list, tasks]);
        }
        else{
          allTasks.add([list, []]);
        }

      }

      //print(allTasks);
      _allLists = allTasks;
      notifyListeners();
      return allTasks;
    } catch (e){
      throw Exception('Failed to load lists $e}');
    }


  }
  Future<List<dynamic>> fetchTaskNames(listId,userId) async {
    final response = await http.get(
      Uri.parse('${dotenv.env["LOCALHOST_URL"]}/tasks/$userId/$listId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 404){
      _tasks = [];
      notifyListeners();
      return [];
    }
    List<dynamic> taskNames = jsonDecode(response.body);
    _tasks = taskNames;
    notifyListeners();
    return taskNames;



  }

  Future<void> selectList(item, userId) async {
    if (item == null){
      _listName = null;
      _listId = null;
      _tasks = [];
      fetchAllLists(userId);
      notifyListeners();
      return;
    }
    _listName = item["listName"];
    _listId = item["listId"];
    _tasks = await fetchTaskNames(item["listId"], item["userId"]);
    print('SELECTED LIST $_listName');
    notifyListeners();
  }


  Future<void> setTaskStatus(task) async {

    final response = await http.patch(Uri.parse('${dotenv
        .env["LOCALHOST_URL"]}/tasks/${task["userId"]}/${task["listId"]}/${task["taskId"]}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'taskStatus': !task["taskStatus"]})
    );

    List<dynamic> taskNames = jsonDecode(response.body);
    _tasks = taskNames;
    fetchAllLists(task["userId"]);
    notifyListeners();
  }

  Future<void> createNewList(listName, userId) async {
    final response = await http.post(
        Uri.parse('${dotenv.env["LOCALHOST_URL"]}/lists'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId,
          'listName': listName}));
    print("new list created");
    _allLists = await fetchAllLists(userId);
    notifyListeners();
  }

  Future <void> createNewTask(taskName, userId, listId) async {
    final response = await http.post(
        Uri.parse('${dotenv.env["LOCALHOST_URL"]}/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId,
          'listId': listId,
          'taskName': taskName
        }));
    print(response.body);
    _tasks = await fetchTaskNames(listId, userId);
    _allLists = await fetchAllLists(userId);
    print('NEW TASK CREATED $_allLists');

    notifyListeners();
  }
  Future<void> deleteTask(userId,listId,taskId) async{
    final response = await http.delete(
        Uri.parse('${dotenv.env["LOCALHOST_URL"]}/tasks/${userId}/${listId}/${taskId}'),
        headers: {'Content-Type': 'application/json'},
        );
    _tasks = await fetchTaskNames(listId, userId);
    _allLists = await fetchAllLists(userId);
    notifyListeners();

  }
  Future<void> deleteList(userId,listId) async{
    final taskResponse = await http.delete(
        Uri.parse('${dotenv.env["LOCALHOST_URL"]}/tasks/${userId}/${listId}'),
        headers: {'Content-Type': 'application/json'},
        );
    final response = await http.delete(
        Uri.parse('${dotenv.env["LOCALHOST_URL"]}/lists/${userId}/${listId}'),
        headers: {'Content-Type': 'application/json'},
        );
    _tasks = [];
    _listName = null;
    _allLists = await fetchAllLists(userId);
    notifyListeners();
  }

}


