import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()

            if let currentUser = authViewModel.currentUser {
                Text(currentUser.fullName)
            } else {
                ProgressView("Profile incoming...")
            }
            
            Spacer()
            
            Button("Sign Out :(") {
                authViewModel.signOut()
            }
        }
    }
}

#Preview {
    ProfileView()
}
