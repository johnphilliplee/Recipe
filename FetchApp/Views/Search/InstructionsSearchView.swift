import SwiftUI

struct InstructionsSearchView: View {
    @Binding var searchText: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Search in Instructions")
                .font(.headline)

            HStack {
                TextField("Enter keyword or phrase", text: Binding(
                    get: { searchText ?? "" },
                    set: { searchText = $0.isEmpty ? nil : $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled(true)
                .keyboardType(.default)

                if let text = searchText, !text.isEmpty {
                    Button(action: {
                        searchText = nil
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    })
                }
            }
        }
    }
}

#Preview {
    InstructionsSearchView(searchText: .constant(""))
}
