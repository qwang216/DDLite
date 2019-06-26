//
//  ExploreListController.swift
//  DDLite
//
//  Created by Jason wang on 6/20/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

class ExploreListController: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var exploreViewModel = ExploreViewModel(merchants: [])
    var dataServices: ExploreDataServiceable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }
    
    func setupNavBar() {
        title = exploreViewModel.exploreTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        let mapButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(handleMapButtonTapped))
        mapButton.image = UIImage(named: "nav-address")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = mapButton
    }
    
    @objc
    func handleMapButtonTapped() {
        // TODO: coordinator should handle this
        let mapController = DeliveryMapController()
        mapController.delegate = self
        let nav = UINavigationController(rootViewController: mapController)
        navigationController?.present(nav, animated: true, completion: nil)
    }
    
    func fetchExploreData(atLng lng: Double, lat: Double) {
        dataServices?.fetchExploreDataAt(lng, lat: lat, onCompletion: { [unowned self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let vm):
                    self.exploreViewModel = vm
                    self.tableView.reloadData()
                case .failure(let err):
                    self.showAlertView(title: "Error", message: "Unable to fetch local resurants. Error: \(err.errorDescription ?? "NA")")
                }
            }
        })
    }
    
    func setupTableView() {
        view.addSubviews(tableView)
        tableView.fillToSuperView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ExploreCell.self)
    }
    
}

extension ExploreListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreViewModel.merchantCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exploreCell = tableView.dequeueCell(indexPath: indexPath) as ExploreCell
        exploreCell.merchantVM = exploreViewModel.merchantVMAt(indexPath.row)
        return exploreCell
    }
    
}

extension ExploreListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ExploreListController: DeliverMapControllerDelegate {
    func userSelectedLocation(at lng: Double, lat: Double) {
        fetchExploreData(atLng: lng, lat: lat)
    }
}
