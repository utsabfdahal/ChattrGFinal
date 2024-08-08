import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        let supabaseURL = URL(string: "https://cimjdmqnzdnyiujjwelo.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpbWpkbXFuemRueWl1amp3ZWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNjA0NzAsImV4cCI6MjAzNjczNjQ3MH0.6RdN8bkyzkMXqqxNPLozB_Mlq1hvasAnYkNkO8lnMuw"
        client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
}
