import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(spacing: 16) {
                    //logo
                    logo
                    //title
                    titleView
                    
                    Spacer().frame(height: 12)

                    //textfields
                    InputView(placeholder: "Enter the email address", text: $email)

                    InputView(placeholder: "Enter the Password", isSecuredField: true, text: $password)

                    //forgotbutton
                    forgotButton

                    //button view or
                    loginButton
                    
                    Spacer()

                    HStack(spacing: 16) {
                        line
                        Text("or")
                            .fontWeight(.semibold)
                        line
                    }
                    .foregroundColor(.gray)
                    
                    //footer
                    footerView
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)
        .padding(.vertical, 8)
        }
    }
    
    private var logo: some View {
        Image("login_image")
            .resizable()
            .scaledToFit()
    }
    
    private var titleView: some View {
        Text("Join with Us!")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    private var forgotButton: some View {
        HStack{
            Spacer()
            
            Button {
                
            } label: {
                Text("Forgot password?")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
    
    private var loginButton: some View {
        Button {
            
        } label: {
            Text("Login")
        }
        .buttonStyle(CapsuleButtonStyle())
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1) }
    }
    
    private var footerView: some View {
        NavigationLink {
            
        } label: {
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.black)
                Text("Sign Up")
                    .fontWeight(.semibold)
                    .foregroundStyle(.teal)
            }
        }
    }
}

#Preview {
    LoginView()
}
