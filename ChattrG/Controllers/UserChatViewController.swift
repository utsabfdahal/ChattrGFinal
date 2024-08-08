import UIKit
import Supabase

class UserChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    var loggedInUser: ChatUser?
    var chatroom: Chatroom?
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           messageTextField.delegate = self
           setupTableView()
           fetchMessages()
          
       }

       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
//           client.removeSubscriptions()
       }
   

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
    }

    func fetchMessages() {
        
        guard let chatroomName = chatroom?.name else { return }
        
        let url = supabaseURL.appendingPathComponent("/rest/v1/rpc/fetch_messages")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(supabaseKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = ["chatroom_name": chatroomName]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching messages: \(error)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                print("Raw JSON response: \(jsonResponse)") // Print the raw JSON response

                if let fetchedMessages = jsonResponse as? [[String: String]] {
                    let messages = fetchedMessages.compactMap { dict -> Message? in
                        if let sender = dict["sender"], let message = dict["message"] {
                            return Message(sender: sender, message: message)
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        self.messages = messages
                        self.tableView.reloadData()
                    }
                } else {
                    print("Failed to parse JSON response")
                }
            } catch {
                print("Error parsing response: \(error)")
            }
        }

        task.resume()
    }

  
    @IBAction func sendMessage(_ sender: UIButton) {
        Task { @MainActor in
            //        var chatrro: String = chatroom!.name
            //        print(chatrro)
            guard let messagetext = messageTextField.text, !messagetext.isEmpty,
                  let userid = loggedInUser?.id,
                  let chatroomname = chatroom?.name else {
                return
            }
            //        print(userId)
            //        print(messageText)
            //        print(chatroomName)
            
            await insertMessage(userid: userid, chatroomname: chatroomname, messagetext: messagetext)
        }
    }
    private func insertMessage(userid: Int, chatroomname: String, messagetext: String) async {
        do {
            self.messageTextField.text = ""
            try await client
                .rpc("insert_chats", params: [
                    "userid": String(userid),
                    "chatroomname": chatroomname,
                    "messagetext": messagetext
                ])
                .execute()
            self.fetchMessages()
            print("Chat inserted successfully.")
        } catch {
            print("Failed to insert chat: \(error)")
        }

    }

    // TableView DataSource and Delegate methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let message = messages[indexPath.row]
        cell.textLabel?.text = "\(message.sender): \(message.message)"
        return cell
    }
}

// Assume you have the following models


