import SwiftUI

struct StateMessageView: View {
    enum StateType {
        case empty
        case error
    }

    var type: StateType
    var title: String
    var message: String
    var systemImage: String
    var onRetry: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 48))
                .foregroundColor(type == .error ? .red : .secondary)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if type == .error, let onRetry {
                Button(action: onRetry) {
                    Text("Try Again")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StateMessageView(
        type: .empty,
        title: "No recipes",
        message: "Please try again",
        systemImage: "magnifyingglass"
    )
}
