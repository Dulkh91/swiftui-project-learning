# Firebase with auth


## RootView:
```swift
struct RootView: View {
    //MARK: - PROPERTY
    @State private var showSignInView: Bool = false
    //MARK: - BODY
    var body: some View {
        ZStack{
            NavigationStack{
                SettingView(showSignInView: $showSignInView)
            }
            .onAppear{
                let authUser = try? AuthenticationManager.shared.getAuthenticateUser()
                self.$showSignInView.wrappedValue = authUser == nil
            }
            
            .fullScreenCover(isPresented: $showSignInView){
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }//: FULLSCREENCOVER
        }//: ZSTACK
    }
}
```
- **NavigationStack** ប្រសិនជា showSignInView គឺ false ត្រូវបានដំណើរការនៃ SettingView()
- **fullScreenCover** វាដូចទៅនឹង .sheet() ដែរដំណើរការនៅពេល showSignInView គឺ true វាគឺដំណើរការ  AuthenticationView()
- **onAppear** វាជា logic ដើម្បីផ្លាស់ប្តូរ showSignInView ថា false ឬក៏ true 


# Email and Password processing:
## 1) AuthenticationView.swift
-> Click Logn In Button -> Form Input emaii & password
```swift
import SwiftUI
struct AuthenticationView: View {
    //MARK: - PROPERTY
    @Binding var showSignInView: Bool
    //MARK: - BODY
    var body: some View {
        VStack {
            NavigationLink{
                SignInEmailView( showSignInView: $showSignInView)
            }label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(10))
            }
            .padding()
            .navigationTitle("Sign In")
            
            Spacer()
        } 
    }
}

//MARK: - PREVIEW
#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}
```
## 2) SignInEmailView.swift
Affter click Logn In Button
```swift
import SwiftUI
internal import Combine

@MainActor
final class SignInEmailModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        let _ = try await AuthenticationManager.shared.creatUser(email: email, password: password)
        
    }//: SignUp
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        let _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }//: SignIn
}

struct SignInEmailView: View {
    //MARK: - PROPERTY
    @StateObject var vm = SignInEmailModel()
    @Binding var showSignInView: Bool
    
    //MARK: - BODY
    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $vm.password)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task{
                    do {
                        try await vm.signUp()
                        showSignInView = false // dismiss SignInEmailView
                    }catch{
                        print("Error signing in: \(error)")
                    }
                    
                    do {
                       try await vm.signIn()
                        showSignInView = false // dismiss SignInEmailView
                    }catch{
                        print("Error signing in: \(error)")
                    }
                    
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(10))
            }

            Spacer()
        }//: VSTACK
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack{
        SignInEmailView( showSignInView: .constant(false))
    }
    
}

```
## 3) AuthenticationManager.swift
Logical of class 
```swift
import SwiftUI
import FirebaseAuth

struct AuthDataResultModel {
    var uid: String
    var email: String?
    var photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
    
}

class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init(){}
    
    func getAuthenticateUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func creatUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDtaResult =  try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDtaResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDtaResult =  try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDtaResult.user)
    }
    
    func resetPassword(password: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: password)
    }
    
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func sigOut()throws{
        try Auth.auth().signOut()
    }
}
```



### NavigationStack នៅ preview live
នៅចំនុច preview យើងដាក់ NavigationStack

View នោះមាន NavigationLink ឬត្រូវការក្នុង context navigation → ត្រូវ wrap វា ក្នុង NavigationStack ដើម្បី preview behavior ត្រឹមត្រូវ។

បើគ្មាន NavigationStack, preview នឹងមិនមាន navigation environment → NavigationLink មិនដំណើរការ។

# Google 
1) **Firebase Configuration**: 
Enabling Google as a sign-in provider in the Firebase console and configuring the project-level settings.

2) **Installing the SDK**: Adding the GoogleSignIn SDK via Swift Package Manager.

3) **URL Scheme Setup**: Configuring the URL Types in Xcode using the reversed client ID from the GoogleService-Info.plist.

4) **Implementing the Button**: Using the native GoogleSignInButton for compliance with Google's UI guidelines.

5) **Handling Auth Logic**: Extracting the ID token and access token from the Google result to pass to Firebase.

## With google sign in

### សង្ខេបដំណើរការ Sign in ជាមួយ Google ក្នុង AuthenticationView.swift

ខាងក្រោមនេះជាដំណើរការសំខាន់ៗរបស់ការចូលប្រើ (login) ជាមួយ Google ហើយជា flow ទាំងមូល។

1) **ViewModel** ទទួលខុសត្រូវធ្វើ Sign-In
ក្នុង AuthentcationViewModel មានមុខងារ signIn() ដែលធ្វើការ sign-in ជាមួយ Google៖

• បង្កើត SignInGoogleHelper() ដែលជាអ្នកជួយ (helper) ដើម្បីដោះស្រាយ UI និង token flow របស់ Google Sign-In។

• ហៅ try await helper.signIn() ដើម្បីបើក Google sign-in flow (UI Google), ហើយទទួលបាន tokens (សម្រាប់ធម្មតា idToken និង accessToken) បន្ទាប់ពីអ្នកប្រើបានអនុញ្ញាត។

• បន្ទាប់មក ផ្ញើ tokens ទៅ AuthenticationManager.shared.signinWithGoogle(tokens: tokens) ដើម្បីបង្កើត/ផ្ទៀងផ្ទាត់ session ជាមួយ Firebase Auth។

ចំណុចសំខាន់: AuthenticationManager ជា layer ដែលភ្ជាប់ទៅ FirebaseAuth ដើម្បីបម្លែង Google tokens ទៅជា Firebase credential ហើយ sign-in ទៅក្នុង Firebase។

2) **View** ប្រើ GoogleSignInButton ហៅទៅ ViewModel
ក្នុង AuthenticationView:

• មាន 
```swift
@StateObject private var viewModel = AuthentcationViewModel() 
```
ដើម្បីគ្រប់គ្រង state sign-in។

• នៅពេលចុច GoogleSignInButton, វាធ្វើ Task { try await viewModel.signIn() }:

   • ប្រសិនបើជោគជ័យ showSignInView = false ដើម្បីបិទ/ចាកចេញពីទំព័រ sign-in។

   • ប្រសិនបើបរាជ័យ វា print កំហុសតាម console។

3) AuthenticationManager ធ្វើការជាមួយ Firebase
ទោះបីជា AuthenticationManager មិនបង្ហាញក្នុងឯកសារនេះក៏ដោយ តាមទម្លាប់៖

• វានឹងទទួល idToken និង accessToken ពី Google។

• បង្កើត AuthCredential របស់ Firebase (ជាធម្មតា GoogleAuthProvider.credential(withIDToken:accessToken:))។

• ហៅ Auth.auth().signIn(with: credential) ដើម្បី sign-in ទៅ Firebase។

• បន្ទាប់ពីជោគជ័យ អ្នកប្រើនឹងមាន Firebase user session ដែលអាចប្រើទិន្នន័យ authenticated នៅក្នុង app។


