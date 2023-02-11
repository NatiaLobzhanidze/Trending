//
//  HomeSceneViewController.swift
//  Trending
//
//  Created by Natia's Mac on 08.02.23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SkeletonView

protocol HomeSceneDisplayLogic: AnyObject {
    func displayData(viewModel: HomeScene.GetDetails.ViewModel)
    func displayErrorMessage(error: HomeScene.GetDetails.Error)
}

class HomeSceneViewController: UIViewController {
    let interactor: HomeSceneBusinessLogic
    let router: (HomeSceneRoutingLogic & HomeSceneDataPassing)
    
    let tableview = UITableView()
    var dataSource = [Item]()

    // MARK: Object lifecycle
    
    init(interactor: HomeSceneBusinessLogic, router: (HomeSceneRoutingLogic & HomeSceneDataPassing)) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isSkeletonable = true
        tableview.isSkeletonable = true
        setUpUI()
        fetchData()
        configureTableView()
        self.view.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          self.view.hideSkeleton()
        }
    }
    // MARK: Methods
    
    private func configureTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.registerClass(class: HomeTableViewCell.self)
    }
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        title = "Trending"
        view.addSubview(tableview)
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 5, paddingBottom: 10, paddingRight: 5)
    }
        
    private func fetchData() {
        let request = HomeScene.GetDetails.Request()
        interactor.getData(request: request)
    }
    private func fillDataSource(with items: [Item]) {
        dataSource = items
        tableview.reloadData()
    }
}

extension HomeSceneViewController: HomeSceneDisplayLogic {
    func displayErrorMessage(error: HomeScene.GetDetails.Error) {
        router.routToErrorAnimation()
    }
    
    func displayData(viewModel: HomeScene.GetDetails.ViewModel) {
        self.fillDataSource(with: viewModel.data)
    }
}

extension HomeSceneViewController: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.deque(class: HomeTableViewCell.self, for: indexPath)
        let data = dataSource[indexPath.row]
        cell.configureCell(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.indexPathForSelectedRow?.row == indexPath.row ? UITableView.automaticDimension : 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableview.cellForRow(at: indexPath)
        if cell?.isSelected == true {
            tableview.deselectRow(at: indexPath, animated: true)
            tableView.rowHeight = 90
            tableView.beginUpdates()
            tableView.endUpdates()
            return nil
        } else {
           return  indexPath
        }
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeTableViewCell"
    }
}
