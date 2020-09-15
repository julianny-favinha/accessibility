//
//  ListCell.swift
//  DynamicType
//
//  Created by Julianny Favinha on 01/11/19.
//  Copyright © 2019 Julianny Favinha. All rights reserved.
//

import Cartography
import Foundation
import UIKit

final class ListCell: UITableViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        let customFont =
//        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
//        label.adjustsFontForContentSizeCategory = true
//        return label
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func setup() {
        addSubview(label)

        constrain(label, self) { title, superview in
            title.edges == inset(superview.edges, 20)
        }
    }
}

extension ListCell {
    func configure(text: String, style: UIFont.TextStyle) {
        label.font =  UIFont.fontSulSans(textStyle: style, fontStyle: .regular)
        label.adjustsFontForContentSizeCategory = true
        label.text = "\(text): \(UIFontDescriptor.preferredFontDescriptor(withTextStyle: style).pointSize)"
    }
}
