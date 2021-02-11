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
        cardDetailTableView.frame = view.safeAreaLayoutGuide.layoutFrame
        cardDetailTableView.dataSource = self
        cardDetailTableView.delegate = self
        cardDetailTableView.allowsSelection = false
        cardDetailTableView.showsVerticalScrollIndicator = false
        cardDetailTableView.separatorStyle = .none
        setupCells()
    }
    
    func setupCells() {
        cardDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cardDetailTableView.register(CardImageTableViewCell.self, forCellReuseIdentifier: "cardImageCell")
        cardDetailTableView.register(TopTitleWithDescriptionTextTableViewCell.self, forCellReuseIdentifier: "textWithDescriptionCell")
        cardDetailTableView.register(TwoTopTitlesAndTwoDescriptionsTableViewCell.self, forCellReuseIdentifier: "twoTopTitlesAndTwoDescriptionsTableViewCell")
        
        let cardImageTableViewCell = CardImageTableViewCell()
        cardDetailCells.append(cardImageTableViewCell)
        let topTitleWithDescriptionCell = TopTitleWithDescriptionTextTableViewCell()
        cardDetailCells.append(topTitleWithDescriptionCell)
        let twoTopTitlesAndTwoDescriptionsTableViewCell = TwoTopTitlesAndTwoDescriptionsTableViewCell()
        cardDetailCells.append(twoTopTitlesAndTwoDescriptionsTableViewCell)
        cardDetailCells.append(twoTopTitlesAndTwoDescriptionsTableViewCell)
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
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cardImageCell", for: indexPath) as! CardImageTableViewCell
                cell.loadImage(with: viewModel.imageUrl)
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textWithDescriptionCell", for: indexPath) as! TopTitleWithDescriptionTextTableViewCell
                cell.updateText(with: "Name", description: viewModel.name, styleAsHeader: true)
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "twoTopTitlesAndTwoDescriptionsTableViewCell", for: indexPath) as! TwoTopTitlesAndTwoDescriptionsTableViewCell
                if let level = viewModel.level, let attribute = viewModel.attribute {
                    cell.updateText(leftTitle: "Level", leftDescription: String(level), rightTitle: "Attribute", rightTitleDescription: attribute)
                }
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "twoTopTitlesAndTwoDescriptionsTableViewCell", for: indexPath) as! TwoTopTitlesAndTwoDescriptionsTableViewCell
                if let race = viewModel.race {
                    cell.updateText(leftTitle: "Race", leftDescription: race, rightTitle: "Type", rightTitleDescription: viewModel.displayTypeName)
                }
                return cell
            }
        }
        return UITableViewCell()
    }

}

extension CardDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cardDetailCells.isEmpty == false {
            if indexPath.row == 0 { return view.safeAreaLayoutGuide.layoutFrame.height }
        }
        return tableView.intrinsicContentSize.height
    }
    
}
