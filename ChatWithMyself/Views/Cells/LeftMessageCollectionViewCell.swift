//
//  ChatCollectionViewCell.swift
//  GitHubDM
//
//  Created by Hui, Malachi | DCMS on 2021/08/13.
//

import UIKit

class LeftMessageCollectionViewCell: UICollectionViewCell {
    
    // MARK: UI PROPERTIES
    var leftMessageTextView: UITextView = {
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
    
    let leftTextBubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftTextBubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left_bubble")?.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21)).withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(white: 0.80, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Properties
    var leftTextBubbleWidthAnchor: NSLayoutConstraint?
   
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
        
        addSubview(leftTextBubble)
        leftTextBubble.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 5).isActive = true
        leftTextBubble.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 5).isActive = true
        leftTextBubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        leftTextBubbleWidthAnchor = leftTextBubble.widthAnchor.constraint(equalToConstant: 200)
        leftTextBubbleWidthAnchor?.isActive = true

        leftTextBubble.addSubview(leftTextBubbleImageView)
        leftTextBubbleImageView.topAnchor.constraint(equalTo: leftTextBubble.topAnchor).isActive = true
        leftTextBubbleImageView.leadingAnchor.constraint(equalTo: leftTextBubble.leadingAnchor).isActive = true
        leftTextBubbleImageView.trailingAnchor.constraint(equalTo: leftTextBubble.trailingAnchor).isActive = true
        leftTextBubbleImageView.bottomAnchor.constraint(equalTo: leftTextBubble.bottomAnchor).isActive = true

        leftTextBubble.addSubview(leftMessageTextView)
        leftMessageTextView.topAnchor.constraint(equalTo: leftTextBubble.topAnchor).isActive = true
        leftMessageTextView.leadingAnchor.constraint(equalTo: leftTextBubble.leadingAnchor, constant: 10).isActive = true
        leftMessageTextView.trailingAnchor.constraint(equalTo: leftTextBubble.trailingAnchor).isActive = true
        leftMessageTextView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
