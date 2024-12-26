import SwiftUI

public protocol SegmentItem: Equatable, RawRepresentable where RawValue == String {}

private struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

public struct SegmentedControl<Indicator: View, Tab: SegmentItem>: View {
    public var tabs: [Tab]
    @Binding public var activeTab: Tab
    public var height: CGFloat = 45
    // Marks: - Customization
    public var displayAsText: Bool = false
    public var font: Font = .title3
    public var activeTint: Color
    public var inactiveTint: Color
    // MARK: - Indicator View
    @ViewBuilder public var indicatorView: (CGSize) -> Indicator
    
    public init(
        tabs: [Tab],
        activeTab: Binding<Tab>,
        height: CGFloat = 45,
        displayAsText: Bool = false,
        font: Font = .title3,
        activeTint: Color,
        inactiveTint: Color,
        @ViewBuilder indicatorView: @escaping (CGSize) -> Indicator
    ) {
        self.tabs = tabs
        self._activeTab = activeTab
        self.height = height
        self.displayAsText = displayAsText
        self.font = font
        self.activeTint = activeTint
        self.inactiveTint = inactiveTint
        self.indicatorView = indicatorView
    }
    
    /// View Properties
    @State private var minX: CGFloat = .zero
    @State private var excessTabWidth: CGFloat = .zero
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            let containerWidthForEachTab = size.width / CGFloat(tabs.count)
            HStack(spacing: 0) {
                ForEach(tabs, id: \.rawValue) { tab in
                    Group {
                        if displayAsText {
                            Text(tab.rawValue)
                        } else {
                            Image(systemName: tab.rawValue)
                        }
                    }
                    .font(font)
                    .foregroundStyle(
                        activeTab == tab ? activeTint : inactiveTint
                    )
                    .animation(.snappy, value: activeTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .onTapGesture {
                        if let index = tabs.firstIndex(of: tab), let activeIndex = tabs.firstIndex(of: activeTab) {
                            activeTab = tab
                            withAnimation(.snappy) {
                                excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                withAnimation(.snappy) {
                                    minX = containerWidthForEachTab * CGFloat(index)
                                    excessTabWidth = 0
                                }
                            }
                        }
                    }
                    .background(alignment: .leading) {
                        if tabs.first == tab {
                            GeometryReader {
                                let size = $0.size
                                
                                indicatorView(size)
                                    .frame(width: size.width + (excessTabWidth < 0 ? -excessTabWidth : excessTabWidth), height: size.height)
                                    .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                                    .offset(x: minX)
                            }
                        }
                    }
                }
            }
            .preference(key: SizeKey.self, value: size)
            .onPreferenceChange(SizeKey.self) { _ in
                if let index = tabs.firstIndex(of: activeTab) {
                    minX = containerWidthForEachTab * CGFloat(index)
                    excessTabWidth = 0
                }
            }
        }
        .frame(height: height)
    }
}
