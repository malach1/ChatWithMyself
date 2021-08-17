//
//  ChatViewModel.swift
//  GitHubDM
//
//  Created by Hui, Malachi | DCMS on 2021/08/15.
//

import Foundation

class ChatViewModel {
    // MARK: Properties
    var model = [ChatEntity]()
    
    
    func getUserChats(name: String) {
        model = DataManager.shared.getUserChats(username: name)
    }
    
    func createChat(name: String, sender: Bool, message: String) {
        model = DataManager.shared.createChat(name: name, sender: sender, message: message)
    }
}
