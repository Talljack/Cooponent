//
//  CustomButton.swift
//  Cooponent
//
//  Created by Yugang Cao  on 2024/12/26.
//

import SwiftUI

public struct CustomButton: View {
	private let title: String
	private let action: () -> Void
	private let buttonColor: Color

	public init(
		title: String,
		color: Color = .blue,
		action: @escaping () -> Void
	) {
		self.title = title
		self.buttonColor = color
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Text(title)
				.foregroundColor(.white)
				.padding(.horizontal, 20)
				.padding(.vertical, 10)
				.background(buttonColor)
				.cornerRadius(8)
		}
	}
}

#Preview {
	VStack(spacing: 20) {
		CustomButton(title: "默认按钮") {}
		CustomButton(title: "红色按钮", color: .red) {}
	}
	.padding()
}
