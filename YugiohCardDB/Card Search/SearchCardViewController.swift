//
//  ViewController.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import UIKit

class SearchCardViewController: UIViewController {
    
    //MARK: - Properties
    var searchResults: [CardViewModel] = []
    var searchTask: DispatchWorkItem?
    var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }
    var isLoading = false

    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        addSubviews()
        setUpConstraints()
      }

    //MARK: Setups
    private func addSubviews() {
        view.addSubview(searchTableView)
        searchTableView.addSubview(noResultsLabel)
        setupSearchController()
        setupTableView()
        setupSearchView()
        setupNoResultsLabel()
    }
    
    func setupNoResultsLabel() {
        noResultsLabel.frame = searchTableView.frame
    }
    
    func setupSearchView() {
        navigationItem.searchController = searchController
        navigationItem.title = Strings.yugiohDb
        definesPresentationContext = true
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.searchCards
        searchController.searchBar.returnKeyType = .done
    }
    
    func setupTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: Views
    private let searchController = UISearchController(searchResultsController: nil)

    private var searchTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var noResultsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.noResultsFound
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.isHidden = true
        return label
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView?
    
    //MARK: - Methods
    
    private func showActivityIndicator() {
        if activityIndicatorView == nil {
            activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
            guard let activityIndicatorView = activityIndicatorView else { return }
            activityIndicatorView.startAnimating()
            activityIndicatorView.style = .large
            view.addSubview(activityIndicatorView)
        }
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView = nil
    }

    private func showEmptyState() {
        noResultsLabel.isHidden = false
        searchTableView.separatorStyle = .none
        searchTableView.isUserInteractionEnabled = false
    }
    
    private func hideEmptyState() {
        noResultsLabel.isHidden = true
        searchTableView.separatorStyle = .singleLine
        searchTableView.isUserInteractionEnabled = true
    }
    
    private func buildViewModels(cardsData: CardsData?, error: Error?) {
        guard let cardsData = cardsData else {
            handleError(error)
            return
        }
        
        guard error == nil else {
            handleError(error)
            return
        }
        
        var result = cardsData.data
        
        if result.count >= 50 {
            result = Array(cardsData.data[0..<50])
        }
        
        for cardData in result {
            searchResults.append(CardViewModel(cardData))
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.searchTableView.reloadData()
            self?.isLoading = false
        }
        
    }
    
    //MARK: - Handlers
    // TODO: Create HANDLE SUCCESS
    
    func handleError(_ error: Error? = nil) {
        searchResults.removeAll()
        isLoading = false
        DispatchQueue.main.async { [weak self] in
            self?.searchTableView.reloadData()
            self?.showEmptyState()
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchCardViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")

    if !searchResults.isEmpty {
        hideEmptyState()
        cell.textLabel?.text = searchResults[indexPath.row].name
        cell.detailTextLabel?.text = searchResults[indexPath.row].displayTypeName
    } else {
        showEmptyState()
    }
    
    return cell
  }

}

extension SearchCardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !isLoading {
            searchController.searchBar.resignFirstResponder()
            let cardDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "cardDetailViewController") as! CardDetailViewController
            cardDetailVC.cardViewModel = searchResults[indexPath.row]
            self.navigationController?.pushViewController(cardDetailVC, animated: true)
        }
    }
    
}

//MARK: - UISearchResultsUpdating
extension SearchCardViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    
    if !isSearchBarEmpty {
        searchResults.removeAll()
        searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            YGOPRODeckService.fuzzySearch(with: searchController.searchBar.text ?? "", completion: self!.buildViewModels)
        }
        
        self.searchTask = task
        
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + 0.5,
            execute: task
        )
        isLoading = true
    } else {
        searchResults.removeAll()
        searchTask?.cancel()
        searchTableView.reloadData()
    }
  }

}
