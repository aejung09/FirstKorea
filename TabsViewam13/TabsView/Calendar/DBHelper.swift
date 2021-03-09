//
//  DBHelper.swift
//  TabsView
//
//  Created by Derrick on 2021/03/04.
//

import Foundation
import SQLite3
// 코코아팟 없이 걍 이걸로 임포트 ㅋ
class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
        // 테이블이랑 디비 만들어주는거
    }
    let dbPath: String = "myData1.sqlite"
    //let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS scheduler(sno INTEGER PRIMARY KEY, startTime TEXT, endTime TEXT, title TEXT, content TEXT, date TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        print("-----11")
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(sno:Int, startTime:String, endTime:String, title:String, content:String, date:String)
    {
        let schedulers = read(date: date)
        for w in schedulers
        {
            if w.sno == sno
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO scheduler(sno, startTime, endTime, title, content, date) VALUES (NULL, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
          
            sqlite3_bind_text(insertStatement, 1, (startTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (endTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (content as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (date as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read(date:String) -> [scheduler] {
        let queryStatementString = "SELECT * FROM scheduler where date = ?"
        var queryStatement: OpaquePointer? = nil
        var psns : [scheduler] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (date as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let sno = sqlite3_column_int(queryStatement, 0)
                let startTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let endTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let content = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                psns.append(scheduler(sno: Int(sno), startTime: startTime, endTime: endTime, title: title, content: content, date: date))
                print("Query Result:")
                print("\(sno) | \(startTime) | \(endTime) | \(title) | \(content)| \(date)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
    
    func read2(sno:Int) -> [scheduler] {
        let queryStatementString = "SELECT * FROM scheduler where sno = ?"
        var queryStatement: OpaquePointer? = nil
        var psns : [scheduler] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(queryStatement, 1, Int32(sno))

            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let sno = sqlite3_column_int(queryStatement, 0)
                let startTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let endTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let content = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                psns.append(scheduler(sno: Int(sno), startTime: startTime, endTime: endTime, title: title, content: content, date: date))
                print("Query Result:")
                print("\(sno) | \(startTime) | \(endTime) | \(title) | \(content)| \(date)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
    
    
    func deleteByID(sno : Int) {
        let deleteStatementStirng = "DELETE FROM scheduler WHERE sno = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(sno))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
        
    
    // 일정 수정을 하는 경우 날짜를 변경할 필요는 없음 !!
    func updateByID(sno:Int, startTime:String, endTime:String, title:String, content:String) {
        let updateStatementStirng = "UPDATE scheduler set startTime = ?, endTime = ?, title = ?, content = ? WHERE sno = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (startTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (endTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (content as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 5, Int32(sno))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updates row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    
    
}
