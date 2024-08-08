//
//  RegisterPageViewController.swift
//  ChattrG
//
//  Created by Utsab's Mac on 16/07/2024.
//

import UIKit

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Dismiss the keyboard when return is pressed
           textField.resignFirstResponder()
           return true
       }

    @IBOutlet weak var emailTyped: UITextField!
    
    @IBOutlet weak var passwordTyped: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkDatabaseConnection()
        emailTyped.delegate = self
        passwordTyped.delegate = self
        
        // Do any additional setup after loading the view.
    }
   
    

        
       
    
    @IBAction func signUPpressed(_ sender: UIButton) {
        //print("Hello")
        print(emailTyped.text!)
        guard let email = emailTyped.text, !email.isEmpty,
              let password = passwordTyped.text, !password.isEmpty else {
            showAlert( message: "Please enter both email and password.")
            return
        }
        
        signUpUser(email: email, password: password)
        
        
    }
    
    
    private func signUpUser(email: String, password: String) {
            let url = URL(string: "https://cimjdmqnzdnyiujjwelo.supabase.co/rest/v1/users")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpbWpkbXFuemRueWl1amp3ZWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNjA0NzAsImV4cCI6MjAzNjczNjQ3MH0.6RdN8bkyzkMXqqxNPLozB_Mlq1hvasAnYkNkO8lnMuw", forHTTPHeaderField: "apikey")
            request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpbWpkbXFuemRueWl1amp3ZWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNjA0NzAsImV4cCI6MjAzNjczNjQ3MH0.6RdN8bkyzkMXqqxNPLozB_Mlq1hvasAnYkNkO8lnMuw", forHTTPHeaderField: "Authorization")
            
            let user = ["email": email, "password": password]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: user, options: []) else {
                return
            }
            
            request.httpBody = httpBody
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Error signing up user: \(error.localizedDescription)")
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Failed to sign up user.")
                    }
                    return
                }
                
                if response.statusCode == 201 {
                    DispatchQueue.main.async {
                        self.showAlert(message: "User signed up successfully!")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Failed to sign up user. Status code: \(response.statusCode)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
