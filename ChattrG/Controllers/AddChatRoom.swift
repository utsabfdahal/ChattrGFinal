//
//  AddChatRoom.swift
//  ChattrG
//
//  Created by Utsab's Mac on 05/08/2024.
//

import UIKit
import Supabase

class AddChatRoom: UIViewController {
    
    let client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    
    @IBOutlet weak var chatroomNameInserted: UITextField!
    
    @IBOutlet weak var usernameChatroomInserted: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    
    @IBAction func createChatroom(_ sender: UIButton) {
        print(usernameChatroomInserted.text!)
        print(chatroomNameInserted.text!)
     
        
        Task { @MainActor in
            guard let user = usernameChatroomInserted.text, !user.isEmpty,
                  let chatroomname = chatroomNameInserted.text, !chatroomname.isEmpty else {
                fetchingfunctions.showAlert(on: self,message: "Please enter all the fields")
                return
            }
            
            await managechatrooms(chatroomname: chatroomname, username: user)
        }

        
    }
    
    private func managechatrooms(chatroomname: String, username: String) async {
        do {
            self.usernameChatroomInserted.text = ""
            
            try await client
                .rpc("manage_chatroom", params: [
                  
                    "chatroom_name": chatroomname,
                    "user_email": username
                    
                ]
                )
                .execute()
                fetchingfunctions.showAlert(on: self,message: "Done")
        } catch {
            print("Failed to insert chat: \(error)")
            fetchingfunctions.showAlert(on: self,message: "Error : \(error.localizedDescription)")
        }

    }
    
    
    
    
    @IBAction func deleteChatRoom(_ sender: UIButton) {
        guard let chatroomName = chatroomNameInserted.text, !chatroomName.isEmpty else {
            fetchingfunctions.showAlert(on: self, message: "Please enter all the fields")
            return
        }
        
        Task {
            do {
                try await client
                
                  .from("chatrooms")
                  .delete()
                  .eq("name", value: chatroomName)
                  .execute()
                   
                fetchingfunctions.showAlert(on: self, message: "Chatroom deleted successfully.")
                print("Chatroom deleted successfully.")
            } catch {
                print("Failed to delete chatroom: \(error)")
                fetchingfunctions.showAlert(on: self, message: "Failed to delete chatroom.")
            }
        }
    }

}
