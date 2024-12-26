# Cooponent

A collection of beautiful and reusable SwiftUI components.

## Features

- **SegmentedControl**: A highly customizable segmented control component that supports both text and icon modes.

## Requirements

- iOS 15.0+ / macOS 13.0+
- Swift 5.7+
- Xcode 14.0+

## Installation

### Swift Package Manager

Add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/Talljack/Cooponent.git", from: "1.0.0")
```

Then include "Cooponent" as a dependency for your target:

```swift
.target(
    name: "YourTarget",
    dependencies: ["Cooponent"]
)
```

## Usage

### SegmentedControl

```swift
import SwiftUI
import Cooponent

struct ContentView: View {
    enum Tab: String, SegmentItem {
        case home = "house.fill"
        case search = "magnifyingglass"
        case profile = "person.fill"
        case settings = "gear"
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        // Default style with icons
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
        
        // Text mode
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
    }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
