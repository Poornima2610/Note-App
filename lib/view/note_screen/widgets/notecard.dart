import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/notescreencontroller.dart';



class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    
  required this.title,
  required this.des,
  required this.date,
  required this.colorindex,
  this.onDeletepressed,
  this.onEditpressed
  
  });



  final String title;
  final String des;
  final String date;
  final int colorindex;
  final void Function()? onDeletepressed;
    final void Function()? onEditpressed;

  @override
  Widget build(BuildContext context) {
    var clr2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: NoteScreenController.colorList[colorindex], borderRadius: BorderRadius.circular(13)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  InkWell(
                    onTap: onEditpressed,
                    child: Icon(Icons.edit)),
                  SizedBox(width: 15),
                  InkWell(
                    onTap:onDeletepressed,
                    child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(des),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(date), SizedBox(width: 20), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
