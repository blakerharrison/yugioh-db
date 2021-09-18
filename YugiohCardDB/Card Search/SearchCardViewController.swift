//
//  ViewController.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import UIKit

class SearchCardViewController: UIViewController {
    
    private var allCards: [CardViewModel] = []
    private var filteredCards: [CardViewModel] = []
    private var searchTask: DispatchWorkItem?
    private var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }
    
    override func loadView() {
        super.loadView()
        addSubviews()
        setUpConstraints()
        loadAllCards()
    }
    
    private func loadAllCards() {
        allCards = CacheManager.getAllCards()
        filteredCards = allCards
    }
    
    private func addSubviews() {
        view.addSubview(searchTableView)
        searchTableView.addSubview(noResultsLabel)
        setupSearchController()
        setupTableView()
        setupSearchView()
    }
    
    func setupNoResultsLabel() {
        noResultsLabel.frame = searchTableView.frame
    }
    
    func setupSearchView() {
        navigationItem.searchController = searchController
        navigationItem.title = Strings.yugiohDb
        navigationItem.hidesSearchBarWhenScrolling = false
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
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchTableView: UITableView = {
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

    func handleError(_ error: Error? = nil) {
        filteredCards.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.searchTableView.reloadData()
            self?.showEmptyState()
        }
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
}

extension SearchCardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        if !filteredCards.isEmpty {
            hideEmptyState()
            cell.textLabel?.text = filteredCards[indexPath.row].name
            cell.detailTextLabel?.text = filteredCards[indexPath.row].displayTypeName
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
        
        searchController.searchBar.resignFirstResponder()
        let cardDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "cardDetailViewController") as! CardDetailViewController
        cardDetailVC.cardViewModel = filteredCards[indexPath.row]
        self.navigationController?.pushViewController(cardDetailVC, animated: true)
    }
    
}

extension SearchCardViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredCards = allCards
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty == false {
                filteredCards = allCards.filter({$0.searchName.contains(searchText.lowercased())})
            }
            searchTableView.reloadData()
        }
    }
    
}
