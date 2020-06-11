//
//  DataViewController.swift
//  FirebaseDemo
//
//  Created by Rani Singh on 01/06/20.
//  Copyright © 2020 InnoCric. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    var messages: [ChatModel] = []
    let db = Firestore.firestore()
    
    //MARK: - IBOutlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
  //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "⚡️Messages"
        
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
    }
    
  //MARK: - IBActions
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text,
            let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: ["sender": messageSender, "body": messageBody, "date": Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                }else {
                    print("Successfully save data")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }    }
    
    
    func loadMessages() {
        
        db.collection("messages").order(by: "date").addSnapshotListener() { (querySnapshot, err) in
            
            self.messages = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                        let newMessage = ChatModel(sender: messageSender, body: messageBody)
                        self.messages.append(newMessage)
                        
                        
                        DispatchQueue.main.async {
                            self.chatTableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            
                        }
                    }
                }
            }
        }
    }
 
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //This message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
             cell.label.textColor = UIColor(named: "BrandPurple")
        }
        
        //This message from another user
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: "BrandPurple")
             cell.label.textColor = UIColor(named: "BrandLightPurple")
        }
        
        return cell
    }
}


