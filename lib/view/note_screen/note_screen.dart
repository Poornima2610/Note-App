import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/notescreencontroller.dart';
import 'package:flutter_application_1/view/note_screen/widgets/notecard.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    super.key,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  int selectedClrindex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            titleController.clear();
            desController.clear();
            datecontroller.clear();
            custombottomsheet(context: context, isEdit: true);
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index) => NoteCard(
            title: NoteScreenController.noteList[index]['title'],
            des: NoteScreenController.noteList[index]['des'],
            date: NoteScreenController.noteList[index]['date'],
            colorindex: NoteScreenController.noteList[index]['colorindex'],
            onDeletepressed: () {
              NoteScreenController.deleteNote(index);
              setState(() {});
            },
            onEditpressed: () {
              titleController.text =
                  NoteScreenController.noteList[index]["title"];
              desController.text = NoteScreenController.noteList[index]["des"];
              datecontroller.text = NoteScreenController.noteList[index]["date"];
              selectedClrindex =
                  NoteScreenController.noteList[index]["colorindex"];
      
              custombottomsheet(context: context, isEdit: false, index: index);
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: NoteScreenController.noteList.length,
        ),
      ),
    );
  }

  Future<dynamic> custombottomsheet(
      {required BuildContext context, bool isEdit = false, int? index}) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.shade800,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, bottomsetState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit ? "Add Note" : "update note",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: desController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Description",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  controller: datecontroller,
                  decoration: InputDecoration(
                      hintText: "Date",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: InkWell(
                          onTap: () async {
                  final selectedDateTime =await  showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));

                                if(selectedDateTime != null)
                                {
                                  String formatedDate=DateFormat("dd/mmm/yy").format(selectedDateTime);
                                  datecontroller.text = formatedDate.toString();
                                }
                                
                                bottomsetState(() {
                                  
                                },);
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            color: Colors.black,
                            size: 25,
                          ))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      4,
                      (index) => InkWell(
                            onTap: () {
                              selectedClrindex = index;
                              print(selectedClrindex);
                              bottomsetState(() {});
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: selectedClrindex == index ? 5 : 0),
                                  borderRadius: BorderRadius.circular(10),
                                  color: NoteScreenController.colorList[index]),
                            ),
                          )),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (isEdit == false) {
                          NoteScreenController.EditNote(
                            index: index!,
                            title: titleController.text,
                            des: desController.text,
                            date: datecontroller.text,
                            colorindex: selectedClrindex,
                          );
                        } else {
                          NoteScreenController.addNote(
                            title: titleController.text,
                            des: desController.text,
                            date: datecontroller.text,
                            colorindex: selectedClrindex,
                          );
                        }

                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            isEdit == true ? "Add" : "Edit",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
