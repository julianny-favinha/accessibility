//
//  ListViewController.swift
//  DynamicType
//
//  Created by Julianny Favinha on 01/11/19.
//  Copyright © 2019 Julianny Favinha. All rights reserved.
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    let texts: [String] = ["Caption 2", "Caption 1", "Footnote", "Subhead", "Body", "Head", "Title 3", "Title 2", "Title 1"]

    let styles: [UIFont.TextStyle] = [.caption2, .caption1, .footnote, .subheadline, .body, .headline, .title3, .title2, .title1]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = ListView(dataSource: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Items"
        print(UIAccessibility.isReduceMotionEnabled)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(texts.count, styles.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }


        cell.configure(text: texts[indexPath.row], style: styles[indexPath.row])

        return cell
    }
}
