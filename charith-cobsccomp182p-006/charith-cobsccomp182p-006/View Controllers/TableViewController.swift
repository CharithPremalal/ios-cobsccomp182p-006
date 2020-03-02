//
//  TableViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/27/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import Kingfisher

struct cell{
    
    var eventtitle : String
    var eventdes : String
    var eventimgurl : String
    
}

class TableViewController: UITableViewController {
    
    var cellArr = [cell](){
        
        didSet{
            tableView.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        cellData()
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cells = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cells.EventTitle.text = cellArr[indexPath.row].eventtitle
        cells.EventDesc.text = cellArr[indexPath.row].eventdes
        
        let img = URL(string: cellArr[indexPath.row].eventimgurl)
        cells.EventImg.kf.setImage(with: img)
        
        
        return cells
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellArr.count
    }
    
    func cellData(){
        
        let db = Firestore.firestore()
        db.collection("Events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let EventTitle = document.data()["EventTitle"] as? String
                    let EventDesc = document.data()["EventDescription"] as? String
                    let email = document.data()["FirstName"] as! String
                    let imgurl =  document.data()["eventimgurl"] as? String
                    let events = cell(eventtitle: EventTitle!, eventdes: EventDesc!, eventimgurl: imgurl!)
                    
                    self.cellArr.append(events)
                    self.tableView.reloadData()
                    
                    print(events)
                }
            }
            
            print(self.cellArr)
            
            
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Home = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        Home?.Ename = cellArr[indexPath.row].eventtitle
        Home?.Edescription = cellArr[indexPath.row].eventdes
        Home?.Eimgurl = cellArr[indexPath.row].eventimgurl
        
        self.navigationController?.pushViewController(Home!, animated:true)
        
    }
    
    
}


