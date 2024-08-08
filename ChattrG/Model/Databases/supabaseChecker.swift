//
//  supabaseChecker.swift
//  ChattrG
//
//  Created by Utsab's Mac on 04/08/2024.
//

import UIKit
import Supabase

class SupabaseCheckerViewController: UIViewController {
    let client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    
    struct Country: Encodable {
        let id: Int
        let name: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await insertCountry()
        }
    }
    
    func insertCountry() async {
        let country = Country(id: 1, name: "Denmark")
        do {
            try await client
                .from("countries")
                .insert(country)
                .execute()
            print("Country inserted successfully")
        } catch {
            print("Failed to insert country: \(error)")
        }
    }
}
