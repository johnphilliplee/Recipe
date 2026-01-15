import SwiftUI

struct ServingsInputView: View {
    @Binding var servings: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Number of Servings")
                .font(.headline)

            Stepper(value: Binding(
                get: { servings ?? 0 },
                set: { newValue in
                    if servings == nil {
                        servings = 1
                    } else {
                        servings = newValue
                    }
                }
            ), in: 1...20) {
                if let servings {
                    Text("\(servings) \(servings == 1 ? "serving" : "servings")")
                } else {
                    Text("No preference")
                }
            }
        }
    }
}

#Preview {
    ServingsInputView(servings: .constant(3))
}
