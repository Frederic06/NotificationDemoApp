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
    
    // MARK: - Outlets
    
    @IBOutlet weak var twitterTableView: UITableView!
    
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var quoteImage: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: TweetSearchViewModel!
    
    var locationManager: CLLocationManager?
    
    private lazy var twitterSearchDataSource = TweetSearchDataSource()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    let quote = UIImage(systemName: "quote.bubble.fill")
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.twitterTableView.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind(to: viewModel)
        viewModel.viewDidAppear()
        configureUI()
        
        updateLocation()
        
        bind(to: twitterSearchDataSource)
        
        twitterTableView.dataSource = twitterSearchDataSource
        twitterTableView.delegate = twitterSearchDataSource
    }
    
    // MARK: - Private methods
    
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
                self?.searchIndicator.stopAnimating()
                self?.twitterTableView.isHidden = false
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
        viewModel.activityIndicatorAnimating = { [weak self] state in
            if state == true {
                self?.quoteImage.isHidden = true
            }
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
        print("CONFIGURE UI")
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.1076729968, green: 0.6331808567, blue: 0.9505664706, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "👉Tweet Search"
        
        self.quoteImage.image = quote
    }
}

// MARK: - Extensions

extension TweetSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.didWriteHashtag(text: text)
        self.searchIndicator.startAnimating()
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
        case .denied, .notDetermined, .restricted:
            viewModel.updateAuthorization(status: .denied); presentSettingAlert()
        @unknown default:
            break
        }
        return
    }
    func presentSettingAlert() {
        let alertController = UIAlertController (title: "Title", message: "Go to Settings to allow location?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
