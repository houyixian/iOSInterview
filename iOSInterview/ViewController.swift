//
//  ViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/4.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!

    private let normalTitleCellIdentifier = "normalTitleCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        navigationController?.navigationBar.isTranslucent = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: normalTitleCellIdentifier)
        let leftConstraints = NSLayoutConstraint(item: tableView as Any, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraints = NSLayoutConstraint(item: tableView as Any, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraints = NSLayoutConstraint(item: tableView as Any, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraints = NSLayoutConstraint(item: tableView as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leftConstraints, rightConstraints, topConstraints, bottomConstraints])
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: normalTitleCellIdentifier, for: indexPath)
        var text = "未完待续"
        switch indexPath.row {
        case 0:
            text = "事件传递和响应者链"
        case 5:
            text = "可拖拽排列的collectionview"
        case 6:
            text = "不规则的渐变视图"
        case 7:
            text = "工作预开发模块"
        default:
            break
        }
        cell.textLabel?.text = text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = EventHandlingHomeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = DragableViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = IrregularGradientViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = WorkPreDevHomeViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

