import SwiftUI

struct DietaryAttributesView: View {
    let selectedAttributes: Set<DietaryAttribute>
    let showNonSelected: Bool
    let onToggle: ((DietaryAttribute) -> Void)?
    let title: String?

    private let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                Text(title)
                    .font(.headline)
            }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(filteredAttributes, id: \.self) { attribute in
                    AttributeChip(
                        attribute: attribute,
                        isSelected: selectedAttributes.contains(attribute),
                        onTap: { onToggle?(attribute) }
                    )
                }
                .allowsHitTesting(onToggle != nil)
            }
        }
    }

    // Helper: decide which attributes to show
    private var filteredAttributes: [DietaryAttribute] {
        if showNonSelected {
            return Array(DietaryAttribute.allCases)
        } else {
            return Array(selectedAttributes)
        }
    }
}

#Preview {
    DietaryAttributesView(
        selectedAttributes: [.vegetarian, .glutenFree],
        showNonSelected: true,
        onToggle: nil,
        title: "Dietary preferences"
    )
}
