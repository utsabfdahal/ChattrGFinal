import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var loggedInUser: ChatUser?
    var chatRooms: [Chatroom] = []
    var chatroomId: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChatroomCell")

        if let loggedInUser = loggedInUser {
            let saveEmail = loggedInUser.email
            fetchChatRooms(forEmail: saveEmail)
            welcomeText.text = "Welcome, \(saveEmail)"
        }
    }


    func fetchChatRooms(forEmail email: String) {
        let url = supabaseURL.appendingPathComponent("/rest/v1/rpc/fetchchatrooms")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(supabaseKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = ["email_input": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching chat rooms: \(error)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Raw JSON response: \(jsonResponse)") // Log the raw JSON response

                if let jsonArray = jsonResponse as? [[String: Any]] {
                    let chatRooms = jsonArray.compactMap { dict -> Chatroom? in
                        if let name = dict["chatroom_name"] as? String {
                            return Chatroom(id: 0, name: name) // Assuming Chatroom has id and name
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        self.chatRooms = chatRooms
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



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatroomCell", for: indexPath)
        let chatroom = chatRooms[indexPath.row]
        cell.textLabel?.text = chatroom.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChatroom = chatRooms[indexPath.row]
        performSegue(withIdentifier: "ChatToUserChat", sender: selectedChatroom)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatToUserChat",
           let userChatVC = segue.destination as? UserChatViewController,
           let chatroom = sender as? Chatroom {
            userChatVC.loggedInUser = loggedInUser
            userChatVC.chatroom = chatroom
           
        }
    }
}

// Assume you have the following models




