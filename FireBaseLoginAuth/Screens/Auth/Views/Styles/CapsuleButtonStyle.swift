import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(.teal))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
