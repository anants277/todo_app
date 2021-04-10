//
//  AllToDosTableViewController.swift
//  ToDos
//
//  Created by Creo Server on 19/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit

class AllToDosTableViewController: UITableViewController
{
    //our button to add list and its action
    var addButton: UIBarButtonItem!
    @objc func addNewToDo()
    {
        let tvc = TableViewController(persistenceManager: PersistenceManager.shared)
        self.navigationController?.pushViewController(tvc, animated: true)
    }
    
    //instancer of toDoData
    var toDoData = ToDoData()
    
    //var to keep track of touched row
    static var touchedRow: Int?
    
    //Core Data Stuffs
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
    
    //getting back userData from core data
    func getUserData()
    {
        print("in all getUserdata")
        if let userDatas = try? persistenceManager.context.fetch(UserData.fetchRequest()) as? [UserData]
        {
            var icount = 0
            userDatas.forEach({AllToDoData.allDataDict[$0.toDoList.tableName] = $0.toDoList})
            AllToDoData.allData.removeAll()
            //userDatas.forEach({AllToDoData.allData.append($0.toDoList)})
            userDatas.forEach({AllToDoData.allData.insert($0.toDoList, at: icount); icount += 1})
            //userDatas.forEach({AllToDoData.allData[icount] = $0.toDoList ; icount += 1})
            userDatas.forEach({print("all $$$$$$$$$$$$$$$$$$",$0.toDoList.data)})
        }
        else
        {
            print("all nooooo")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        tableView.register(AllToDoCell.self, forCellReuseIdentifier: "allMainCell")
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewToDo))
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    //when our view will appear we will get back the user data from core data and reload the data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("in top viewWillAppear")
        getUserData()
        tableView.reloadData()
    }
}



//for dataSource
extension AllToDosTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       AllToDoData.allData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allMainCell", for: indexPath) as! AllToDoCell
        cell.allLabel.text = AllToDoData.allData[indexPath.row].tableName
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.9274827249, blue: 0.6415239935, alpha: 1)
        return cell
    }
    
}

//for tableView delegate
extension AllToDosTableViewController
{
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //setting the static value of touched row
        AllToDosTableViewController.touchedRow = indexPath.row
        let tvc = TableViewController(persistenceManager: PersistenceManager.shared)
        self.navigationController?.pushViewController(tvc, animated: true)
    }
}

//for UINavigationControllerDelegate
extension AllToDosTableViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        viewController.viewWillAppear(true)
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
    {
        viewController.viewDidAppear(true)
    }
}
