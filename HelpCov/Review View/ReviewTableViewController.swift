//
//  ReviewTableViewController.swift
//  HelpCov
//
//  Created by Antoine Simon on 04/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController {
        
    private var listReview: ListPoint
    private var viewModel: ReviewViewModelProtocol
    
    var closedPressed: (() -> Void)?
    
    init(list: ListPoint, viewModel: ReviewViewModelProtocol) {
        listReview = list
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: ReviewTableViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: String(describing: ReviewTableViewCell.self), bundle: nil), forCellReuseIdentifier: "reviewCell")
        tableView.register(UINib(nibName: String(describing: ReviewHeaderTableViewCell.self), bundle: nil), forHeaderFooterViewReuseIdentifier: "headerCell")
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell") as? ReviewHeaderTableViewCell else {return UIView()}
        viewModel.configure(header: header, infos: listReview)
        header.closedPressed = closeView
        
        return header
    }

    private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listReview.array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewTableViewCell else { return UITableViewCell() }
        viewModel.configure(cell: cell, review: listReview.array[indexPath.row])
        return cell
    }
}
