//
//  DataManager.swift
//  GitHubDM
//
//  Created by Hui, Malachi | DCMS on 2021/08/15.
//

import UIKit
import CoreData

class DataManager {
    // MARK: PROPERTIES
    static let shared = DataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var model = [ChatEntity]()
    
    func getUserChats(username: String) -> [ChatEntity] {
        do {
            model = try context.fetch(ChatEntity.fetchRequest()).filter { $0.username == username }
        } catch {
            print("Error: Unable to get user chats.")
        }
        return model
    }
    
    func createChat(name: String, sender: Bool, message: String) ->  [ChatEntity] {
        let newChat = ChatEntity(context: context)
        newChat.username = name
        newChat.sender = sender
        newChat.message = message
        
        do {
            try context.save()
        } catch {
            print("Error: Unable to get create chat.")
        }
        return getUserChats(username: name)
    }
}
