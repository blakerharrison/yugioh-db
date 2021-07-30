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
    
    private let monsterCardDetailsCells: [CardDetailCellType] = [
        .image,
        .name,
        .levelAndAttribute,
        .raceAndType,
        .attackAndDefense,
        .description
    ]
    
    private let spellOrTrapCardDetailsCells: [CardDetailCellType] = [
        .image,
        .name,
        .raceAndType,
        .description,
    ]
    
    enum CardDetailsCellId: String {
        case cardImageCell
        case textWithDescriptionCell
        case twoTopTitlesAndTwoDescriptionsTableViewCell
        case detailTextWithDescriptionCell
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.title = "Card Details"
        addSubviewes()
        setupTableView()
    }
    
    //MARK: - Methods
    //MARK: Setup
    private func addSubviewes() {
        view.addSubview(cardDetailTableView)
    }
    
    private func setupTableView() {
        cardDetailTableView.frame = view.safeAreaLayoutGuide.layoutFrame
        cardDetailTableView.dataSource = self
        cardDetailTableView.delegate = self
        cardDetailTableView.allowsSelection = false
        cardDetailTableView.showsVerticalScrollIndicator = false
        cardDetailTableView.separatorStyle = .none
        registerCells()
    }
    
    private func registerCells() {
        cardDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cardDetailTableView.register(CardImageTableViewCell.self, forCellReuseIdentifier: CardDetailsCellId.cardImageCell.rawValue)
        cardDetailTableView.register(TopTitleWithDescriptionTextTableViewCell.self, forCellReuseIdentifier: CardDetailsCellId.textWithDescriptionCell.rawValue)
        cardDetailTableView.register(TwoTopTitlesAndTwoDescriptionsTableViewCell.self, forCellReuseIdentifier: CardDetailsCellId.twoTopTitlesAndTwoDescriptionsTableViewCell.rawValue)
        cardDetailTableView.register(TopTitleWithDescriptionTextTableViewCell.self, forCellReuseIdentifier: CardDetailsCellId.detailTextWithDescriptionCell.rawValue)
    }
    
    //MARK: Views
    private var cardDetailTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
}

// MARK: - UITableViewDataSource
extension CardDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModel?.type == CardType.monster ? monsterCardDetailsCells.count : spellOrTrapCardDetailsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = cardViewModel else { return UITableViewCell() }
        let cellTypes = viewModel.type == CardType.monster ? monsterCardDetailsCells : spellOrTrapCardDetailsCells
        return getConfiguredCell(with: tableView, cardDetailCellType: cellTypes[indexPath.row], viewModel: viewModel, indexPath: indexPath)
    }
    
}

// MARK: - UITableViewDelegate
extension CardDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if monsterCardDetailsCells[indexPath.row] == .image { return view.safeAreaLayoutGuide.layoutFrame.height }
        return tableView.intrinsicContentSize.height
    }
    
}

// MARK: - Cell Configuration
extension CardDetailViewController {
    
    func getConfiguredCell(with tableView: UITableView, cardDetailCellType: CardDetailCellType, viewModel: CardViewModel, indexPath: IndexPath) -> UITableViewCell {
        
        switch cardDetailCellType {
        
        case .attackAndDefense:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.twoTopTitlesAndTwoDescriptionsTableViewCell.rawValue, for: indexPath) as! TwoTopTitlesAndTwoDescriptionsTableViewCell
            if let attack = viewModel.attack, let defense = viewModel.defense { cell.updateText(leftTitle: Strings.attack, leftDescription: String(attack), rightTitle: Strings.defense, rightTitleDescription: String(defense)) }
            return cell
            
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.cardImageCell.rawValue, for: indexPath) as! CardImageTableViewCell
            cell.loadImage(with: viewModel.imageUrl)
            return cell
            
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.textWithDescriptionCell.rawValue, for: indexPath) as! TopTitleWithDescriptionTextTableViewCell
            cell.updateText(with: Strings.name, description: viewModel.name, styleAsHeader: true)
            return cell
            
        case .levelAndAttribute:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.twoTopTitlesAndTwoDescriptionsTableViewCell.rawValue, for: indexPath) as! TwoTopTitlesAndTwoDescriptionsTableViewCell
            if let level = viewModel.level, let attribute = viewModel.attribute { cell.updateText(leftTitle: Strings.level, leftDescription: String(level), rightTitle: Strings.attribute, rightTitleDescription: attribute) }
            return cell
            
        case .raceAndType:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.twoTopTitlesAndTwoDescriptionsTableViewCell.rawValue, for: indexPath) as! TwoTopTitlesAndTwoDescriptionsTableViewCell
            if let race = viewModel.race { cell.updateText(leftTitle: Strings.race, leftDescription: race, rightTitle: Strings.type, rightTitleDescription: viewModel.displayTypeName) }
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsCellId.detailTextWithDescriptionCell.rawValue, for: indexPath) as! TopTitleWithDescriptionTextTableViewCell
            cell.updateText(with: Strings.description, description: viewModel.description)
            return cell
            
        }
    }
    
}
