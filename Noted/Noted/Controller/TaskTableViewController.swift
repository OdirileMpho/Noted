//
//  TaskTableViewController.swift
//  Noted
//
//  Created by Odirile Kekana on 2021/09/08.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController {
    
    var taskArray = [Task]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // print(dataFilePath)
        loadTasks()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.done ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        taskArray[indexPath.row].done = !taskArray[indexPath.row].done
        saveTasks()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            context.delete(taskArray[indexPath.row])
            taskArray.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }

    
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add task", style: .default) { action in
            
            let newTask = Task(context: self.context)
            newTask.title = textField.text!
            
            self.taskArray.append(newTask)
            self.tableView.reloadData()
            self.saveTasks()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new task"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
   
    //function to save items to core data
    func saveTasks() {
        
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    //function to view the tasks in the tableview after they've been persisted
    func loadTasks() {
        
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            
            taskArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        
    }
}
