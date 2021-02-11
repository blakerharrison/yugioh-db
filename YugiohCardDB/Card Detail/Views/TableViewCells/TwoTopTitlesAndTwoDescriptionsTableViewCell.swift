//
//  TwoTopTitlesAndTwoDescriptionsTableViewCell.swift
//  YugiohCardDB
//
//  Created by bhrs on 2/11/21.
//

import UIKit

class TwoTopTitlesAndTwoDescriptionsTableViewCell: UITableViewCell {

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
        addSubview(leftTitleLabel)
        addSubview(leftDescriptionLabel)
        addSubview(rightTitleLabel)
        addSubview(rightDescriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Left Title Label
            leftTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.textFieldTopAndBottomMargin),
            leftTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.margin),
            leftTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            leftTitleLabel.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // Left Description Label
            leftDescriptionLabel.topAnchor.constraint(equalTo: leftTitleLabel.bottomAnchor),
            leftDescriptionLabel.leadingAnchor.constraint(equalTo: leftTitleLabel.leadingAnchor),
            leftDescriptionLabel.widthAnchor.constraint(equalTo: leftTitleLabel.widthAnchor),
            leftDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 42),
            leftDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Dimensions.textFieldTopAndBottomMargin),
            
            // Right Title Label
            rightTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.textFieldTopAndBottomMargin),
            rightTitleLabel.leadingAnchor.constraint(equalTo: leftTitleLabel.trailingAnchor, constant: Dimensions.margin),
            rightTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.margin),
            rightTitleLabel.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // Right Description Label
            rightDescriptionLabel.topAnchor.constraint(equalTo: rightTitleLabel.bottomAnchor),
            rightDescriptionLabel.leadingAnchor.constraint(equalTo: rightTitleLabel.leadingAnchor),
            rightDescriptionLabel.trailingAnchor.constraint(equalTo: rightTitleLabel.trailingAnchor),
            rightDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 42),
            rightDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Dimensions.textFieldTopAndBottomMargin)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private var leftTitleLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    private var leftDescriptionLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 23)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        return textView
    }()
    
    private var rightTitleLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    private var rightDescriptionLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 23)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        return textView
    }()
    
    func updateText(leftTitle: String = "", leftDescription: String = "", rightTitle: String = "", rightTitleDescription: String = "") {
        self.leftTitleLabel.text = leftTitle
        self.leftDescriptionLabel.text = leftDescription
        self.rightTitleLabel.text = rightTitle
        self.rightDescriptionLabel.text = rightTitleDescription
    }
    
}
