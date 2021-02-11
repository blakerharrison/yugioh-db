//
//  CardImageTableViewCell.swift
//  YugiohCardDB
//
//  Created by bhrs on 2/10/21.
//

import UIKit
import SDWebImage

class CardImageTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardImageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cardImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(with viewModel: CardViewModel) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.cardImageView.sd_setImage(with: URL(string: viewModel.imageUrl))
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
