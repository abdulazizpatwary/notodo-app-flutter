import 'package:flutter/material.dart';
import 'package:notdoapp/model/nodo_item.dart';
import 'package:notdoapp/util/database_client.dart';

import '../util/date_formatter.dart';
class NotoDoScreen extends StatefulWidget {
  const NotoDoScreen({super.key});

  @override
  State<NotoDoScreen> createState() => _NotoDoScreenState();
}

class _NotoDoScreenState extends State<NotoDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var db= DatabaseClient();
  final List<NoDoItem> _itemList=<NoDoItem>[];
  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: _itemList.length,
                  itemBuilder: (_,int index){
                  return Card(
                    color: Colors.white10,
                    child: ListTile(
                      title: _itemList[index],
                      onLongPress: ()=>_updateItem(_itemList[index],index),
                      trailing: Listener(key: Key(_itemList[index].itemName.toString()),
                      child: Icon(Icons.remove_circle,color: Colors.redAccent,),
                      onPointerDown: (pointerEvent)=>_deleteNoDo(_itemList[index].id,index),),
                    ),
                  );

              }),
          ),
           Divider(height: 1.0,)
        ],

      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add item",
          backgroundColor: Colors.redAccent,
          onPressed: _showFormDialog,
          child: ListTile(
            title: Icon(Icons.add),
          )),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: TextField(controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                    hintText: "eg. Dont buy stuff",
                icon: Icon(Icons.note_add)
              ),)
          )
        ],
      ),
      actions: <Widget>[
        TextButton(onPressed: (){
          Navigator.pop(context);
          _handleSubmit(_textEditingController.text);
          _textEditingController.clear();
        }, child: Text("Save")),
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel"))
      ],
    );
    showDialog(context: context, builder:(_){
      return alert;

    });
  }

  void _handleSubmit(String text) async{
    if (text.trim().isEmpty) return;
    _textEditingController.clear();
    NoDoItem noDoItem= NoDoItem(text.trim(), dateFormatted());
    int savedItem = await db.saveItem(noDoItem);
    NoDoItem? addedItem = await db.getItem(savedItem);
    if(addedItem !=null){
      setState(() {
        _itemList.insert(0, addedItem);
      });
    }


  }
  _readNoDoList()async{
    List items = await db.getItems();
    items.forEach((item){
      setState(() {
        _itemList.add(NoDoItem.map(item));
      });

    });
  }

  void _deleteNoDo(int? id,int index) async{
    await db.deleteItem(id!);
    setState(() {
      _itemList.removeAt(index);
    });

  }

  void _updateItem(NoDoItem item, int index) {
    var alert = AlertDialog(
      title: Text("Update Item"),
      content: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Item",
                  hintText: "eg. don't buy stuff"
                    ,
                  icon: Icon(Icons.update)
                ),
              )
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: ()async{
              Navigator.pop(context);
              NoDoItem updatedItem= NoDoItem.fromMap(
               {
                 "itemName":_textEditingController.text,
                 "dateCreated": dateFormatted(),
                 "id":item.id
               }
              );
              _handleUpdate(index,item);
              await db.updateItem(updatedItem);
              setState(() {
                _readNoDoList();
              });
            }, 
            child: Text("Update")
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel")
        )
      ],
    );
    showDialog(context: context, builder: (_){
      return alert;
    });
  }

  void _handleUpdate(int index, NoDoItem item) {
    setState(() {
      _itemList.removeWhere((_element)=> _itemList[index].itemName== item.itemName);
    });
  }
}
