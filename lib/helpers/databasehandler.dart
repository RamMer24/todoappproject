



import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databasehandler
{
  Database? db;

  Future<Database> create_db() async
  {
     if(db!=null)
       {
         return db!;
       }
     else
       {
         Directory dir = await getApplicationDocumentsDirectory();
         String dbpath = join(dir.path,"todo_db");
         var db =await openDatabase(dbpath,version: 1,onCreate:create_table);
         return db;
       }
  }

  create_table(Database db,int version)
  {
    db.execute("create table todo(tid integer primary key autoincrement,title text,remark text,date double, )");
    print("table created");
  }
  Future<int> insertitle(title,remark,date)async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into todo(title,remark,date)"
        "values(?,?,?)",[title,remark,date]);
    return id;
  }
  Future<List> viewtitle()async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from todo");
    return data.toList();
  }

  Future<int> deleteNote(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from todo where tid=?",[id]);
    return status;
  }

  Future<List> getsinleproduct(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from todo where tid=?",[id]);
    return data.toList();
  }

  Future<int> updatenotes(title,remark,date,updateid) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update todo set title=?,remark=?,date=? where tid=?",[title,remark,date,updateid]);
    return status;
  }

}