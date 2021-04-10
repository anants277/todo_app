//
//  TableView.swift
//  ToDos
//
//  Created by Creo Server on 17/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
import  UIKit
import CoreData
class TableViewController: UITableViewController
{
    //to check saved state
    var isSaved: Bool = false
    
    //to check if we went in edit state
    var wentInEditAction: Bool = false
    
    //to check if alreadycreated list
    var alreadyCreated: Bool = false
    
    //textField for our tableName
    var tableNameField: UITextField!
    
    //our date instance
    var getDate = GetDate()
    
    //instance of toDoData
    var toDoData = ToDoData()
    
//Core Data Stuffs
    
    //creating our var of type UserData
    var userDatas = [UserData]()
    
    //using dependency injection
    let persistenceManager : PersistenceManager
    init(persistenceManager: PersistenceManager)
    {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //function to create new userdata i.e new ToDo list
    func createUserData(aTableData: ToDoDataClass)
    {
        let userData = UserData(context: persistenceManager.context)
        userData.toDoList = aTableData
    
        persistenceManager.save()
    }
    
    //function to update existing userdata list
    func updateUserData()
    {
        persistenceManager.save()
    }
    
    //function to delete userData list
//    func deleteUserData()
//    {
//        persistenceManager.save()
//    }
    
    //function to get userdata from coredata
    func getUserData()
    {
        print("in getUserdata")
        if let userDatas = try? persistenceManager.context.fetch(UserData.fetchRequest()) as? [UserData]
        {
            self.userDatas = userDatas
            userDatas.forEach({print("$$$$$$$$$$$$$$$$$$",$0.toDoList.data)})
        }
        else
        {
            print("nooooo")
        }
    }

    
    
    //save barItembutton and its action
    var saveButton: UIBarButtonItem!
    @objc func endToDosEditing()
    {
        if self.tableView.numberOfRows(inSection: 0) > 2
        {
            getUserData()
            print("in action saving")
            print("@@@@@",toDoData.data)
            toDoData.data.remove(at: 0)
            toDoData.cutdata.remove(at: 0)
            print(tableView.numberOfRows(inSection: 0)-2)
            toDoData.data.remove(at: tableView.numberOfRows(inSection: 0)-2)
            toDoData.cutdata.remove(at: tableView.numberOfRows(inSection: 0)-2)
            toDoData.tableName = tableNameField.text!
            tableNameField.isUserInteractionEnabled = false
            print("#####",toDoData.data)
            print("#####",toDoData.cutdata)
            print("#####",toDoData.tableName)
            isSaved = true
            self.tableView.reloadData()
            self.tableView.setEditing(false, animated: false)
            saveButton.isEnabled = false
            self.navigationItem.rightBarButtonItem = editButton
            
            //if we came here by touching a row then update the existing data
            if let touchedRow = AllToDosTableViewController.touchedRow
            {
                print(touchedRow)
                let updatedDataClass = ToDoDataClass(data: toDoData.data, cutdata: toDoData.cutdata, tableNane: toDoData.tableName)
                let userDataToUpdate = userDatas[touchedRow]
                userDataToUpdate.toDoList = updatedDataClass
                updateUserData()
                wentInEditAction = false

            }
            //if we came here by touching add button then create new to do list
            else
            {
                if tableNameField.text!.count <= 1
                {
                    print("getting default name of table")
                    toDoData.tableName = getDate.timeString()
                }
                //copy our data to ToDoDataClass
                let aTableData = ToDoDataClass(data: toDoData.data, cutdata: toDoData.cutdata, tableNane: toDoData.tableName)
                createUserData(aTableData: aTableData)
                //getUserData()
                alreadyCreated = true
            }
        }
    }
    
    //edit barItembutton and its action
    var editButton: UIBarButtonItem!
    @objc func startToDosEditing()
    {
        tableNameField.isUserInteractionEnabled = true
        print("in action editing ")
        print("@@@@@",toDoData.data)
        toDoData.data.insert("#", at: 0)
        toDoData.cutdata.insert(false, at : 0)
        print(tableView.numberOfRows(inSection: 0)-2)
        toDoData.data.append("#")
        toDoData.cutdata.append(false)
        tableNameField.isUserInteractionEnabled = true
        print("----#####",toDoData.data)
        print("----#####",toDoData.cutdata)
        isSaved = false
        self.tableView.reloadData()
        self.tableView.setEditing(true, animated: true)
        saveButton.isEnabled = true
        self.navigationItem.rightBarButtonItem = saveButton
        wentInEditAction = true
    
    }
    
    //called when our view will disappear or when we presss back button
    override func viewWillDisappear(_ animated: Bool)
    {
        getUserData()
        
        //if we went in editAction and pressed back button without saving then ...
        if wentInEditAction == true
        {
            toDoData.data.remove(at: 0)
            toDoData.cutdata.remove(at: 0)
            toDoData.data.remove(at: tableView.numberOfRows(inSection: 0)-2)
            toDoData.cutdata.remove(at: tableView.numberOfRows(inSection: 0)-2)
            toDoData.tableName = tableNameField.text!
        }
        
        //if we came here by touching a row
        if let touchedRow = AllToDosTableViewController.touchedRow
        {
            print(touchedRow)
            let updatedDataClass = ToDoDataClass(data: toDoData.data, cutdata: toDoData.cutdata, tableNane: toDoData.tableName)
            let userDataToUpdate = userDatas[touchedRow]
            userDataToUpdate.toDoList = updatedDataClass
            updateUserData()
        }
        
        //if we came here by touching add button
        else
        {
            if alreadyCreated == false
            {
                //if table name is not given by user
                if tableNameField.text!.count <= 1
                {
                    print("getting default name of table")
                    tableNameField.text = getDate.timeString()
                }
                toDoData.data.remove(at: 0)
                toDoData.cutdata.remove(at: 0)
                toDoData.data.remove(at: tableView.numberOfRows(inSection: 0)-2)
                toDoData.cutdata.remove(at: tableView.numberOfRows(inSection: 0)-2)
                toDoData.tableName = tableNameField.text!
                let newDataClass = ToDoDataClass(data: toDoData.data, cutdata: toDoData.cutdata, tableNane: toDoData.tableName)
                createUserData(aTableData: newDataClass)
            }
            
        }
        
        //update the touchedRow to nil
        AllToDosTableViewController.touchedRow = nil

    }

    //called when out view 	 load
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        tableView.register(ToDosTableViewCell.self, forCellReuseIdentifier: "mainCell")
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: "addCell")
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(endToDosEditing))
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startToDosEditing))
        self.navigationItem.rightBarButtonItem = saveButton
        
        isSaved = false
        alreadyCreated = false
        
        tableNameField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        tableNameField.backgroundColor = .white
        tableNameField.placeholder = "Enter the List name"
        tableNameField.textAlignment = .center
        tableNameField.isUserInteractionEnabled = true
        self.navigationItem.titleView = tableNameField
        
        //if we came here by touching a row then update our dataModel for table
        if let touchedRow = AllToDosTableViewController.touchedRow
        {
            toDoData.data = AllToDoData.allData[touchedRow].data
            toDoData.cutdata = AllToDoData.allData[touchedRow].cutdata
            toDoData.tableName = AllToDoData.allData[touchedRow].tableName
            print(">>>>>>>>>>>>>.",toDoData.tableName)
            isSaved = true
            self.navigationItem.rightBarButtonItem = editButton
            tableNameField.text = toDoData.tableName
            
        }
        
        self.tableView.tableFooterView = UIView()
        self.setEditing(true, animated: true)
        self.tableView.allowsSelectionDuringEditing = true
        tableView.reloadData()
    }
}

//extension for delegate
extension TableViewController
{
    //if selected row at particular indexpath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //if touched 1st row when in editing mode
        if indexPath.row == 0 && isSaved == false
        {
            toDoData.insertAtBeg(newData: "")
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            //alert popup
            //define alert with title and style
            //add textfield to it
            let alert = UIAlertController(title: "ADD ITEM", message: "", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField) in
                textField.becomeFirstResponder()
            }
            
            //add button and its handler
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (UIAlertAction) in
                self.toDoData.data.remove(at: 1)
                self.toDoData.cutdata.remove(at: 1)
                tableView.reloadData()
            }))
            
            //add button and its handler
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                if let newText =  alert.textFields?[0].text, newText.count > 0
                {
                    self.toDoData.data[indexPath.row+1] = newText
                    print(indexPath.row)
                    print("--------",self.toDoData.data)
                    print("--------",self.toDoData.cutdata)
                    tableView.reloadData()
                }
                else
                {
                    print("''''''''''",self.toDoData.data)
                    self.toDoData.data.remove(at: 1)
                    self.toDoData.cutdata.remove(at: 1)
                    tableView.reloadData()
                    print(",,,,,,,,,,,",self.toDoData.data)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
            
        //if selected last row when in editing mode
        else if indexPath.row == tableView.numberOfRows(inSection: 0)-1 && isSaved == false
        {
            toDoData.insertAtEnd(newData: "")
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: tableView.numberOfRows(inSection: 0)-1, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            //alert popup
            let alert = UIAlertController(title: "ADD ITEM", message: "", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField) in
                textField.becomeFirstResponder()
            }
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (UIAlertAction) in
                self.toDoData.data.remove(at: self.toDoData.data.count-2)
                self.toDoData.cutdata.remove(at: self.toDoData.data.count-2)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                if let newText =  alert.textFields?[0].text, newText.count > 0
                {
                    self.toDoData.data[indexPath.row] = newText
                    print(indexPath.row)
                    print("+++++++++++",self.toDoData.data)
                    tableView.reloadData()
                }
                else
                {
                    self.toDoData.data.remove(at: self.toDoData.data.count-2)
                    self.toDoData.cutdata.remove(at: self.toDoData.data.count-2)
                    tableView.reloadData()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
            
        //if touched row to write toDos and when in editing mode
        else if  isSaved == false
        {
            //add alert and action and handler
            let alert = UIAlertController(title: "UPDATE ITEM", message: "", preferredStyle: .alert)
                let cell = tableView.cellForRow(at: indexPath) as! ToDosTableViewCell
                alert.addTextField { (textField: UITextField) in
                    textField.becomeFirstResponder()
                    textField.text = cell.label.text
                }
                alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (UIAlertAction) in
                    tableView.reloadData()
                }))
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    
                    if let newText =  alert.textFields?[0].text, newText.count > 0
                    {
                        self.toDoData.data[indexPath.row] = newText
                        print(indexPath.row)
                        print("=========",self.toDoData.data)
                        tableView.reloadData()
                    }
                }))
                self.present(alert, animated: true, completion: nil)
        }
        
        //when in saved sate
        else if isSaved == true
        {

            print(toDoData.data)
            print(toDoData.cutdata)
            print("in saved", isSaved)
            print(indexPath.row)

            //create NSMutableAttributedString for strikeThrough
            let attributeString =  NSMutableAttributedString(string: toDoData.data[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            let removedAttributeString = NSMutableAttributedString(string: toDoData.data[indexPath.row])
            removedAttributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, removedAttributeString.length))

            //if the text is not cut
            if toDoData.cutdata[indexPath.row] == false
            {
                let cell = tableView.cellForRow(at: indexPath) as! ToDosTableViewCell
                print(attributeString)
                print("iscut false")
                cell.label.attributedText = attributeString
                toDoData.cutdata[indexPath.row] = true
                print(toDoData.data)
                print(toDoData.cutdata)
            }

            //if the text is already cut
            else if toDoData.cutdata[indexPath.row] == true
            {
                let cell = tableView.cellForRow(at: indexPath) as! ToDosTableViewCell
                print(removedAttributeString)
                print("iscut true")
                cell.label.attributedText = removedAttributeString
                toDoData.cutdata[indexPath.row] = false
                print(toDoData.data)
                print(toDoData.cutdata)
            }
        }
    }
    
    //setting up editing style for rows at different indexPath
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        if isSaved == false
        {
            if indexPath.row == 0 || indexPath.row == tableView.numberOfRows(inSection: 0)-1
            {
                return .none
            }
            else
            {
                return .delete
            }
        }
        else
        {
            return .none
        }
        
    }
    
    //setting up indentatin for rows
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    {
        if isSaved == false
        {
            if indexPath.row == 0 || indexPath.row == tableView.numberOfRows(inSection: 0)-1
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            return false
        }
        
    }
    
    //setting up height for rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if UIDevice.current.orientation == .portrait
        {
            return UIScreen.main.bounds.height/17
        }
        else if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
        {
            return UIScreen.main.bounds.height/8
        }
        return UIScreen.main.bounds.height/17
    }
  
}


//extension for datasource
extension TableViewController
{
    //defining no. of sections
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //defining no. of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return toDoData.data.count
    }
    
    //method for getting the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        //if want 1st row in edit state
        if indexPath.row == 0 && isSaved == false
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddTableViewCell
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
            return cell
        }
            
        //if want last row in edit state
        else if indexPath.row == tableView.numberOfRows(inSection: 0)-1 && isSaved == false
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddTableViewCell
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
            return cell
        }
        
        //if want main data row
        else
        {
            let attributeString =  NSMutableAttributedString(string: toDoData.data[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            let removedAttributeString = NSMutableAttributedString(string: toDoData.data[indexPath.row])
            removedAttributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, removedAttributeString.length))
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! ToDosTableViewCell
            
            //if text is cut then cut label text
            if toDoData.cutdata[indexPath.row] == true
            {
                cell.label.attributedText = attributeString
            }
            //if not cut write notcut text
            else if toDoData.cutdata[indexPath.row] == false
            {
                cell.label.attributedText = removedAttributeString
            }
            //else write normal data from data array
            else
            {
                cell.label.text = toDoData.data[indexPath.row]
            }
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
            return cell
        }
    }
    
    //grant and restrict movement of row at indexpath
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        if isSaved == false
        {
            if indexPath.row == 0 || indexPath.row == tableView.numberOfRows(inSection: 0)-1
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            return false
        }
        
    }
    
    
    //function to delete, insert the rows from table view
    override func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete && isSaved == false
        {
            //we also need to delete data from data source
            toDoData.data.remove(at: indexPath.row)
            toDoData.cutdata.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("!!!!!",toDoData.data)
            print("!!!!!",toDoData.cutdata)
        }
    }
    
    
    //function to move row in table view
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        print("in move.....",sourceIndexPath.row, destinationIndexPath.row)
        print(tableView.numberOfRows(inSection: 0)-2)
        if destinationIndexPath.row > 0 && destinationIndexPath.row < tableView.numberOfRows(inSection: 0)-1
        {
            let temp = toDoData.data[destinationIndexPath.row]
            let tempcut = toDoData.cutdata[destinationIndexPath.row]
            print("temp=",temp)
            print("source data",toDoData.data[sourceIndexPath.row])
            toDoData.data[destinationIndexPath.row] = toDoData.data[sourceIndexPath.row]
            toDoData.cutdata[destinationIndexPath.row] = toDoData.cutdata[sourceIndexPath.row]
            if sourceIndexPath.row < destinationIndexPath.row
            {
                for index in stride(from: sourceIndexPath.row, to: destinationIndexPath.row, by: 1)
                {
                    print("if")
                    toDoData.data[index] = toDoData.data[index+1]
                    toDoData.cutdata[index] = toDoData.cutdata[index+1]
                }
                toDoData.data[destinationIndexPath.row-1] = temp
                toDoData.cutdata[destinationIndexPath.row-1] = tempcut
                tableView.reloadData()
            }
            else if destinationIndexPath.row < sourceIndexPath.row
            {
                
                for index in stride(from: sourceIndexPath.row, to: destinationIndexPath.row, by: -1)
                {
                    print("else")
                    toDoData.data[index] = toDoData.data[index-1]
                    toDoData.cutdata[index] = toDoData.cutdata[index-1]
                }
                toDoData.data[destinationIndexPath.row+1] = temp
                toDoData.cutdata[destinationIndexPath.row+1] = tempcut
                tableView.reloadData()
            }
            print("->->->->",toDoData.data)
        }
        else
        {
            tableView.reloadData()
        }
    }
    
}
