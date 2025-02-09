import SwiftUI

struct CreateAccountView: View {
    
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            //text
            Text("Please complete all information to create an account")
                .foregroundStyle(.gray)
                .font(.headline).fontWeight(.medium)
                .multilineTextAlignment(.center)
            //text fields
            InputView(
                placeholder: "Enter the email address",
                text: $email
            )

            InputView(
                placeholder: "Full Name",
                text: $fullName
            )

            InputView(
                placeholder: "Password",
                isSecuredField: true,
                text: $password
            )
            
            ZStack(alignment: .trailing) {
                InputView(
                    placeholder: "Confirm Password",
                    isSecuredField: true,
                    text: $confirmPassword
                )
                
                Spacer()
                if !password.isEmpty && !confirmPassword.isEmpty {
                    Image(systemName: "\(isValidPassword ? "checkmark" : "xmark").circle.fill"
                    )
                    .imageScale(.large)
                    .fontWeight(.bold)
                    .foregroundColor(isValidPassword ? Color(.systemGreen) :
                        Color(.systemRed)
                    )
                }
                
            }
            
            Spacer()
            //button
            
            Button {
                Task {
                    await authViewModel.createUser(
                        email: email,
                        fullName: fullName,
                        password: password
                    )
                }
            } label: {
                Text("Create account :)")
            }
            .buttonStyle(CapsuleButtonStyle())
        }
        .navigationTitle("Set Up Your Account")
        .padding()
        .toolbarRole(.editor)
    }
    
    var isValidPassword: Bool {
        confirmPassword == password
    }
}

#Preview {
    CreateAccountView()
}
