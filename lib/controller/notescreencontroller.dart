
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colorconstants.dart';

class NoteScreenController{
  static List <Color> colorList =[
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr3
  ];



  static List noteList=[];


  static void addNote(
    {
      required String title,
      required String des,
      required String date,
      int colorindex=0,

    })
    {
    noteList.add({
      "title":title,
      "des":des,
      "date":date,
      "colorindex":colorindex,
    });
  }

  static void deleteNote (int index){
    noteList.removeAt(index);
  }
static void EditNote ({
      required int index,
      required String title,
      required String des,
      required String date,
      int colorindex=0,

    }){
    noteList[index]={
      "title":title,
      "des":des,
      "date":date,
      "colorindex":colorindex,
    };
  }

}