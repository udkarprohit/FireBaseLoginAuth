import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // firebase ka user
    @Published var currentUser: User? //apna vala user
    @Published var isError: Bool = false
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init() {
        Task {
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async {
        if let user = auth.currentUser {
            userSession = user
            await fetchUser(by: user.uid)
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
        } catch {
            isError = true
        }
    }
    
    func createUser(email: String, fullName: String, password: String) async {
        do {
            //auth mai user ki entry kiya
            let authResult = try await auth.createUser(withEmail: email, password: password)
            //db mai user ki extra details store kar rahe ro
            await storeUserInFireStore(uid: authResult.user.uid, email: email, fullName: fullName)
        } catch {
            isError = true
        }
    }
    
    func storeUserInFireStore(uid: String, email: String, fullName: String) async {
        let user = User(uid: uid, email: email, fullName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        }catch {
            isError = true
        }
    }
    
    func fetchUser(by uid: String) async {
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
        } catch {
            isError = true
        }
    }
    
    func signOut() {
        do {
            userSession = nil
            currentUser = nil
            try auth.signOut()
        } catch {
            isError = true
        }
    }
    
}
