//
//  CardDetailViewController.swift
//  YugiohCardDB
//
//  Created by bhrs on 2/10/21.
//

import UIKit

class CardDetailViewController: UIViewController {

    //MARK: - Properties
    var cardViewModel: CardViewModel?
    
    let cellId = "cellId"
    
    var cardDetailCells: [UITableViewCell] = []
    
    //MARK: - Views
    private var cardImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: TableView
    var cardDetailTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviewes()
        setupTableView()
    }
    
    func addSubviewes() {
//        view.addSubview(cardImageView)
        view.addSubview(cardDetailTableView)
    }
    
    func setupTableView() {
        cardDetailTableView.frame = view.frame
        cardDetailTableView.dataSource = self
        cardDetailTableView.delegate = self
        cardDetailTableView.allowsSelection = false
        cardDetailTableView.showsVerticalScrollIndicator = false
        setupCells()
    }
    
    func setupCells() {
        cardDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cardDetailTableView.register(CardImageTableViewCell.self, forCellReuseIdentifier: "cardImageCell")
        let cardImageTableViewCell = CardImageTableViewCell()
        cardDetailCells.append(cardImageTableViewCell)
        cardDetailTableView.reloadData()
    }
    
    

}

extension CardDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardDetailCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = cardViewModel else { return UITableViewCell() }
        if cardDetailCells.isEmpty == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardImageCell", for: indexPath) as! CardImageTableViewCell
            cell.loadImage(with: viewModel)
            return cell
        }
        return UITableViewCell()
    }

    
}

extension CardDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cardDetailCells.isEmpty == false {
//            cardDetailCells
            return view.frame.height
        }
        return 0
    }
    
}
