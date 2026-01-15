import SwiftUI

struct AttributeChip: View {
    let attribute: DietaryAttribute
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(attribute.rawValue.capitalized)
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.orange : Color.gray.opacity(0.2))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
            .onTapGesture { onTap() }
    }
}

#Preview {
    AttributeChip(attribute: .vegetarian, isSelected: true, onTap: {})
}
