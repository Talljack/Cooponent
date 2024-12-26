import SwiftUI
import Segment

public struct SegmentedControlExample: View {
    public enum Tab: String, SegmentItem {
        case home = "house.fill"
        case search = "magnifyingglass"
        case profile = "person.fill"
        case settings = "gear"
    }
    
    @State private var selectedTab: Tab = .home
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 示例 1: 默认样式的图标分段控制器
                SegmentedControl(
                    tabs: [.home, .search, .profile, .settings],
                    activeTab: $selectedTab,
                    activeTint: Color.blue,
                    inactiveTint: Color.gray
                ) { size in
                    Capsule()
                        .fill(Color.blue.opacity(0.2))
                }
                .frame(height: 50)
                
                // 示例 2: 文本模式的分段控制器
                SegmentedControl(
                    tabs: [.home, .search, .profile, .settings],
                    activeTab: $selectedTab,
                    displayAsText: true,
                    font: .headline,
                    activeTint: Color.white,
                    inactiveTint: Color.gray
                ) { size in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                }
                .frame(height: 45)
                
                // 示例 3: 自定义指示器的分段控制器
                SegmentedControl(
                    tabs: [.home, .search, .profile, .settings],
                    activeTab: $selectedTab,
                    height: 55,
                    activeTint: Color.orange,
                    inactiveTint: Color.gray.opacity(0.5)
                ) { size in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            LinearGradient(
                                colors: [Color.orange.opacity(0.2), Color.orange.opacity(0.1)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                        }
                }
            }
            .padding()
            .navigationTitle("Segmented Control Examples")
        }
    }
}

struct SegmentedControlExample_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlExample()
    }
}
