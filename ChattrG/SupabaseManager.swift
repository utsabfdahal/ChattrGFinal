////
////  SupabaseManager.swift
////  ChattrG
////
////  Created by Utsab's Mac on 17/07/2024.
////
//
//import Foundation
//import Supabase
//
//class SupabaseManager {
//    static let shared = SupabaseManager()
//    
//    private let client: SupabaseClient
//    
//    private init() {
//        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "SupabaseURL") as? String,
//              let url = URL(string: urlString),
//              let key = Bundle.main.object(forInfoDictionaryKey: "SupabaseKey") as? String else {
//            fatalError("Supabase URL and Key must be set in Info.plist")
//        }
//        
//        client = SupabaseClient(supabaseURL: url, supabaseKey: key)
//    }
//
////    func signUp(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
////        Task {
////            do {
////                let response = try await client.auth.signUp(email: username, password: password)
////                print("User signed up successfully: \(response)")
////                completion(.success(()))
////            } catch {
////                print("Error signing up: \(error.localizedDescription)")
////                completion(.failure(error))
////            }
////        }
////    }
//
////    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
////        Task {
////            do {
////                let response = try await client.auth.signIn(email: username, password: password)
////                print("User logged in successfully: \(response)")
////                completion(.success(()))
////            } catch {
////                print("Error logging in: \(error.localizedDescription)")
////                completion(.failure(error))
////            }
////        }
////    }
////    
////    func healthCheck(completion: @escaping (Result<String, Error>) -> Void) {
////           Task {
////               do {
////                   // Perform a simple query to verify the connection
////                   let response = try await client.from("users").select().limit(1).execute()
////                   
////                   // Assuming response.data is of type `[YourDataType]` and check if it's not empty
////                   if !response.data.isEmpty {
////                       completion(.success("Connected to Supabase"))
////                   } else {
////                       completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
////                   }
////               } catch {
////                   completion(.failure(error))
////               }
////           }
////       }
//    
//
//}
//
//
