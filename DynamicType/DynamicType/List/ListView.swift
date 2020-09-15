//
//  ListView.swift
//  DynamicType
//
//  Created by Julianny Favinha on 01/11/19.
//  JCopyright © 2019 Julianny Favinha. All rights reserved.
//

import Cartography
import Foundation
import UIKit

final class ListView: UIView {
    let contentSizeCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = UIApplication.shared.preferredContentSizeCategory.rawValue
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        table.allowsSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.tableFooterView = UIView()
        table.allowsSelection = false
        table.tableHeaderView = nil
        return table
    }()

    init(dataSource: UITableViewDataSource) {
        super.init(frame: UIScreen.main.bounds)

        tableView.dataSource = dataSource
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    private func setup() {
        backgroundColor = .white

        addSubview(contentSizeCategoryLabel)
        addSubview(tableView)

        constrain(contentSizeCategoryLabel, tableView, self) { label, table, superview in
            label.leading == superview.leading + 20
            label.top == superview.top + 90
            label.trailing == superview.trailing - 20
            label.bottom == table.top - 20

            table.leading == superview.leading
            table.trailing == superview.trailing
            table.bottom == superview.bottom
        }
    }
}
