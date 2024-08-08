import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTyped: UITextField!
    @IBOutlet weak var passwordTyped: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTyped.delegate = self
        passwordTyped.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTyped.text, !email.isEmpty,
              let password = passwordTyped.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        loginUser(email: email, password: password)
    }

    private func loginUser(email: String, password: String) {
        let url = URL(string: "https://cimjdmqnzdnyiujjwelo.supabase.co/rest/v1/users?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpbWpkbXFuemRueWl1amp3ZWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNjA0NzAsImV4cCI6MjAzNjczNjQ3MH0.6RdN8bkyzkMXqqxNPLozB_Mlq1hvasAnYkNkO8lnMuw", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpbWpkbXFuemRueWl1amp3ZWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNjA0NzAsImV4cCI6MjAzNjczNjQ3MH0.6RdN8bkyzkMXqqxNPLozB_Mlq1hvasAnYkNkO8lnMuw", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(message: "Error logging in: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showAlert(message: "Failed to retrieve data.")
                }
                return
            }
            
            do {
                if let users = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let user = users.first { $0["email"] as? String == email && $0["password"] as? String == password }
                    
                    DispatchQueue.main.async {
                        if let user = user {
                            self.performSegue(withIdentifier: "LoginToChat", sender: user)
                        } else {
                            self.showAlert(message: "Invalid email or password.")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Failed to parse data.")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(message: "Error parsing response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToChat",
           let chatVC = segue.destination as? ChatViewController,
           let user = sender as? [String: Any] {
            chatVC.loggedInUser = ChatUser(id: user["id"] as! Int, email: user["email"] as! String)
        }
    }
}
