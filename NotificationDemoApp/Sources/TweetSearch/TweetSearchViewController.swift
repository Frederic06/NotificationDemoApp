//
//  SearchViewController.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 28/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import CoreLocation

class TweetSearchViewController: UIViewController {
    
    @IBOutlet weak var twitterTableView: UITableView!
    
    var viewModel: TweetSearchViewModel!
    
    var locationManager: CLLocationManager?
    
    private lazy var twitterSearchDataSource = TweetSearchDataSource()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind(to: viewModel)
        viewModel.viewDidAppear()
        
        updateLocation()
        
        bind(to: twitterSearchDataSource)
        
        configureUI()
        
        view.backgroundColor = .blue
        
        twitterTableView.dataSource = twitterSearchDataSource
        twitterTableView.delegate = twitterSearchDataSource
    }
    
    
    private func bind(to viewModel: TweetSearchViewModel) {
        
        viewModel.searchPlaceHolder = { [weak self] text in
            self?.searchController.searchBar.placeholder = text
        }
        viewModel.hashtagLabel = { [weak self] hashtag in
            self?.twitterSearchDataSource.udpate(hashtag: hashtag)
            self?.twitterTableView.reloadData()
        }
        viewModel.tweets = { [weak self] tweets in
            DispatchQueue.main.async {
                self?.twitterSearchDataSource.update(tweets: tweets)
                self?.twitterTableView.reloadData()
            }
        }
        viewModel.switchState = { [weak self] state in
            self?.twitterSearchDataSource.update(switchState: state)
            self?.twitterTableView.reloadData()
        }
        viewModel.switchHidden = { [weak self] in
            self?.twitterSearchDataSource.update(switchHidden: true)
            self?.twitterTableView.reloadData()
        }
    }
    
    private func bind(to source: TweetSearchDataSource) {
        source.didSelectTweet = viewModel.didSelectTweet
        source.didSelectLocalisation = viewModel.selectLocation
        source.didUnselectLocalisation = viewModel.unSelectLocation
    }
    
    @objc private func didPressFavorite() {
        viewModel.selectLocation()
    }
    
    func configureUI() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.1076729968, green: 0.6331808567, blue: 0.9505664706, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "👉Tweet Search"
        
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(systemName: "antenna.radiowaves.left.and.right"), for: .normal)
        locationButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationButton)
    }
}

extension TweetSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.didWriteHashtag(text: text)
        DispatchQueue.main.async {
            self.searchController.isActive = false
        }
    }
}

extension TweetSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        viewModel.updateCoordinates(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func updateLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
        
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            viewModel.updateAuthorization(status: .authorized)
        default:
            viewModel.updateAuthorization(status: .denied)
//            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: []) { (state) in
//            }
        }
    }
}
