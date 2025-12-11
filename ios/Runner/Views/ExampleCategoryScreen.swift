import SwiftUI

struct ExampleCategoryScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 246/255, green: 247/255, blue: 249/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    CategoryTabsView()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.top, 16)
            }
            .navigationTitle("التصنيفات")
            .navigationBarTitleDisplayMode(.large)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    ExampleCategoryScreen()
}
