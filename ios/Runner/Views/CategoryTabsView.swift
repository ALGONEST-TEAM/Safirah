import SwiftUI

struct CategoryTabsView: View {
    @State private var selectedCategory: String = "المراكز"
    
    let categories = ["المراكز", "المباريات", "اخبار", "احصائيات", "قمصان باكمام طويلة"]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(categories, id: \.self) { category in
                CategoryTab(
                    title: category,
                    isSelected: selectedCategory == category,
                    onTap: {
                        selectedCategory = category
                    }
                )
            }
        }
        .frame(height: 36)
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct CategoryTab: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.custom("IBMPlexSansArabic-Regular", size: 12))
                .lineSpacing(20 - 12)
                .foregroundColor(isSelected ? Color.white : Color(red: 56/255, green: 67/255, blue: 84/255))
                .padding(.horizontal, 5)
                .padding(.vertical, isSelected ? 8 : getPadding(for: title))
                .frame(height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color(red: 207/255, green: 156/255, blue: 10/255) : Color.white)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getPadding(for title: String) -> CGFloat {
        switch title {
        case "قمصان باكمام طويلة":
            return 3
        case "احصائيات":
            return 2
        default:
            return 4
        }
    }
}

#Preview {
    ZStack {
        Color(red: 246/255, green: 247/255, blue: 249/255)
            .ignoresSafeArea()
        
        CategoryTabsView()
            .padding()
    }
}
