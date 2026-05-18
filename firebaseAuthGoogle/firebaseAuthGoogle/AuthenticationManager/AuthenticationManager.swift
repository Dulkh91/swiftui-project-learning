//
//  AuthenticationManager.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    var uid: String
    var email: String?
    var photo: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photo = user.photoURL?.absoluteString
    }
    
}

enum AuthProviderOptions: String{
    case email = "password"
    case google = "google.com"
}


class AuthenticationManager{
    static var shared = AuthenticationManager()
    init(){}
    
    func getAuthenticationUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func sigOut() throws {
       try Auth.auth().signOut()
    }
    
    
    
    // នេះករណីមាន Login email និង google
    // គឺសម្រាប់ទៅសួរនាំ Firebase ថា៖ "តើគណនីរបស់អ្នកប្រើប្រាស់ដែលកំពុង Login ម្នាក់នេះបានភ្ជាប់ (Link) ជាមួយវិធីសាស្ត្រ Sign In មួយណាខ្លះ?"
    func getProviders() throws -> [AuthProviderOptions]{
            // ១. ទៅឆែកមើលទិន្នន័យ providerData ពី Firebase របស់អ្នកប្រើប្រាស់បច្ចុប្បន្ន
                guard let providerData = Auth.auth().currentUser?.providerData else{
                    throw URLError(.badServerResponse)
                }
                
                var providers: [AuthProviderOptions] = []
            
            // ២. ដោយសារអ្នកប្រើប្រាស់ម្នាក់អាចភ្ជាប់បានច្រើនវិធីសាស្ត្រ ទើបប្រើ "for loop" ដើម្បីដើរពិនិត្យម្តងមួយៗ
                for provider in providerData{
                    
                    // ៣. provider.providerID គឺជា String ដែលបានមកពី Firebase (ឧទាហរណ៍៖ "google.com" ឬ "apple.com")
                    // បន្ទាត់នេះយក String នោះមកបំប្លែងទៅជា Enum (AuthProviderOptions) ដែលអ្នកបានបង្កើតឡើងខ្លួនឯង ដើម្បីងាយស្រួលប្រើក្នុង Swift
                    if let option  = AuthProviderOptions(rawValue: provider.providerID){
                        providers.append(option) // បើស្គាល់ គឺថែមវាចូលក្នុងបញ្ជី
                    }else{
                        // បើជួប Provider ណាដែលប្លែក ហើយ Enum របស់អ្នកមិនទាន់ស្គាល់ វានឹងលោត Warning ប្រាប់អ្នកក្រៅ (ពេលកំពុង Develop)
                        assertionFailure("Provider option not found: \(provider.providerID)")
                    }
                }
                // ៤. បញ្ជូនបញ្ជីវិធីសាស្ត្រទាំងអស់ដែលរកឃើញត្រឡប់ទៅវិញ
                return providers
            }
    
}


extension AuthenticationManager{
    @discardableResult
    func signInWithGoogle(token: GoogleSignInResultModel ) async throws -> AuthDataResultModel{
        let credentail = GoogleAuthProvider
            .credential(withIDToken: token.idToken, accessToken: token.accessToken)
        
        return try await signin(creditail: credentail )
    }
    
    @discardableResult
    func signin(creditail: AuthCredential) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().signIn(with: creditail)
        
        return AuthDataResultModel(user: authResult.user)
    }
}
