//
//  EditViewController.swift
//  AssessmentTest
//
//  Created by Михаил Юранов on 02.10.2020.
//  Copyright © 2020 Михаил Юранов. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var edit1: UITextField!
    @IBOutlet weak var edit2: UITextField!
    
    var notice: Notices?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edit1.text = notice?.noticeTitle
        edit2.text = notice?.noticeText
    }
    
    @IBAction func onClick(_ sender: Any) {
        
        if notice != nil {
            notice?.noticeTitle = edit1.text
            notice?.noticeText = edit2.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        } else {
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let ent = NSEntityDescription.insertNewObject(forEntityName: "Notices", into: context) as! Notices
            ent.noticeTitle = edit1.text
            ent.noticeText = edit2.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
    
}
