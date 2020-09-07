import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TitleContentItem extends StatefulWidget {

  String title;

  String content;
  
  VoidCallback onTap;

  TitleContentItem({
    
    Key key,

    this.title,

    this.content,

    this.onTap,

  }) : super (key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    
    return _TitleContentItemState();
  }

}


class _TitleContentItemState extends State<TitleContentItem> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return GestureDetector(

      onTap: widget.onTap,

      child: Container(

        margin: EdgeInsets.only(left: 24, right: 24),

        height: 48,

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            Text(widget.title),

            Text(widget.content),

          ],

        ),

        decoration: BoxDecoration(

          border: Border(
            
            bottom: BorderSide(

              width: 1,
              
            ),
          
          ),

        ),
        
      ),

    );    

  }

}