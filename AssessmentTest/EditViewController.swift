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
        
        let activityView = UIView(frame: view.bounds)
        activityView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        let activity = UIActivityIndicatorView(style: .large)
        activityView.addSubview(activity)
        activity.center = activityView.center
        view.addSubview(activityView)
        activity.startAnimating()

        var uC = URLComponents(string: "https://www.purgomalum.com/service/plain")
        let qi = URLQueryItem(name: "text", value: edit2.text)
        uC?.queryItems = [qi]
        URLSession.shared.dataTask(with: uC!.url!) { (data: Data?, response: URLResponse?, error) in
            DispatchQueue.main.async {
                activityView.removeFromSuperview()
                if error == nil {
                    let str = String(data: data!, encoding: .utf8)
                    if self.notice != nil {
                        self.notice?.noticeTitle = self.edit1.text
                        self.notice?.noticeText = str
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        self.navigationController?.popViewController(animated: true)
                    } else {
                    
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        let ent = NSEntityDescription.insertNewObject(forEntityName: "Notices", into: context) as! Notices
                        ent.noticeTitle = self.edit1.text
                        ent.noticeText = str
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    let ac = UIAlertController(title: "Ошибка", message: "Ошибка валидации данных", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    ac.addAction(action)
                    self.present(ac, animated: true, completion: nil)
                }

            }
        }.resume()
    }
    
}
