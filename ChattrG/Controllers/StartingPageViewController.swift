//
//  StartingPageViewController.swift
//  ChattrG
//
//  Created by Utsab's Mac on 16/07/2024.
//

import UIKit
import Supabase

class StartingPageViewController: UIViewController {

    
    let client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
//    
//    struct Country: Encodable {
//        let id: Int
//        let name: String
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        Task {
//            await insertCountry()
//        }
        // Do any additional setup after loading the view.
    }
    

//    func insertCountry() async {
//        let country = Country(id: 5, name: "Denfdmhjhark")
//        do {
//            try await client
//                .from("countries")
//                .insert(country)
//                .execute()
//            print("Country inserted successfully")
//        } catch {
//            print("Failed to insert country: \(error)")
//        }
//    }
}
