//
//  ChatCollectionViewCell.swift
//  GitHubDM
//
//  Created by Hui, Malachi | DCMS on 2021/08/13.
//

import UIKit

class RightMessageCollectionViewCell: UICollectionViewCell {
    
    // MARK: UI PROPERTIES

    var rightMessageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Default left message from textview"
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let rightTextBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightTextBubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_bubble")?.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21)).withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
  
    // MARK: Properties
    var rightTextBubbleWidthAnchor: NSLayoutConstraint?

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutCell() {
        let safeAreaGuide = contentView.safeAreaLayoutGuide
        
        addSubview(rightTextBubbleView)
        rightTextBubbleView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        rightTextBubbleView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -6).isActive = true
        rightTextBubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        rightTextBubbleWidthAnchor = rightTextBubbleView.widthAnchor.constraint(equalToConstant: 200)
        rightTextBubbleWidthAnchor?.isActive = true
 
        rightTextBubbleView.addSubview(rightTextBubbleImageView)
        rightTextBubbleImageView.topAnchor.constraint(equalTo: rightTextBubbleView.topAnchor).isActive = true
        rightTextBubbleImageView.leadingAnchor.constraint(equalTo: rightTextBubbleView.leadingAnchor).isActive = true
        rightTextBubbleImageView.trailingAnchor.constraint(equalTo: rightTextBubbleView.trailingAnchor).isActive = true
        rightTextBubbleImageView.bottomAnchor.constraint(equalTo: rightTextBubbleView.bottomAnchor).isActive = true

        rightTextBubbleView.addSubview(rightMessageTextView)
        rightMessageTextView.topAnchor.constraint(equalTo: rightTextBubbleView.topAnchor, constant: 5).isActive = true
        rightMessageTextView.leadingAnchor.constraint(equalTo: rightTextBubbleView.leadingAnchor, constant: 10).isActive = true
        rightMessageTextView.trailingAnchor.constraint(equalTo: rightTextBubbleView.trailingAnchor, constant: -5).isActive = true
        rightMessageTextView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
