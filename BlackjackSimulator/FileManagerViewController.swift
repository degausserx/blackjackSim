//
//  FileManagerViewController.swift
//  BlackjackSimulator
//
//  Created by etudiant on 11/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class FileManagerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fileList:[String]!
    
    @IBOutlet weak var TableOutlet: UITableView!

    @IBAction func ButtonLoad(_ sender: UIButton) {
        if let index = self.TableOutlet.indexPathForSelectedRow {
            if let file = fileList[index.row] as String? {
                if (Settings.instance.load(value: file)) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func ButtonCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var ButtonLoadOutlet: UIButton!
    @IBOutlet weak var ButtonCancelOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ButtonLoadOutlet.backgroundColor = UIColor(hex: Colors.Green)
        self.ButtonCancelOutlet.backgroundColor = UIColor(hex: Colors.Red)
        
        self.fileList = Settings.instance.list()
        self.TableOutlet.dataSource = self
        self.TableOutlet.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings manager"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell", for: indexPath) as! FileManagerTableViewCell
        cell.LabelOutlet.text = fileList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if (Settings.instance.delete(value: fileList[indexPath.row])) {
                fileList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}
