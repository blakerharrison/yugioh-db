//
//  TopTitleWithDescriptionTextTableViewCell.swift
//  YugiohCardDB
//
//  Created by bhrs on 2/10/21.
//

import UIKit

class TopTitleWithDescriptionTextTableViewCell: UITableViewCell {

    private struct Dimensions {
        static let margin: CGFloat = 20
        static let textFieldTopAndBottomMargin: CGFloat = 15
        static let textFieldHeight: CGFloat = 20
        static let cellHeight: CGFloat = 60
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .green
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.textFieldTopAndBottomMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.margin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.margin),
            titleLabel.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 42),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Dimensions.textFieldTopAndBottomMargin)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private var titleLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .lightGray
        textLabel.font = UIFont.systemFont(ofSize: 15)
        return textLabel
    }()
    
    private var descriptionLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 23)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        return textLabel
    }()
    
    func updateText(with title: String = "", description: String = "", styleAsHeader: Bool = false) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        if styleAsHeader { applyHeaderStyling() }
    }
    
    private func applyHeaderStyling() {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 28)
    }
    
}
