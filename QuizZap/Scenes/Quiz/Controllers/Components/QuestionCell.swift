//
//  QuestionCell.swift
//  QuizZap
//
//  Created by Tales Conrado on 09/02/21.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init() {
        super.init(style: .subtitle, reuseIdentifier: "cell")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleCell()
    }
    
    private func styleCell() {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.selectionStyle = .none
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 12
        layer.shadowOpacity = 0.0
    }
    
    private func setupViews() {
        contentView.addSubview(questionLabel)
        contentView.backgroundColor = .yellowCellBG

        NSLayoutConstraint.activate([
            questionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            questionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func styleDeselect() {
        contentView.backgroundColor = .yellowCellBG
    }
    
    func styleSelected() {
        contentView.backgroundColor = .selectedBG
    }
    
    func styleRightAnswer() {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.contentView.alpha = 0.0
        }) { (_) in
            UIView.animate(withDuration: 0.2) {
                self.contentView.alpha = 1.0
                self.contentView.backgroundColor = .rightBG
                self.layer.shadowColor = UIColor.rightBG.cgColor
                self.layer.shadowOpacity = 0.6
                self.layer.shadowRadius = 10
                self.layer.shadowOffset = CGSize(width: 0, height: 3)
            }
        }
        
    }
    
    func styleWrongAnswer() {
        contentView.backgroundColor = .wrongBG
    }
    
    func showAsRightAnswer() {
        contentView.backgroundColor = .rightBG
    }
}
