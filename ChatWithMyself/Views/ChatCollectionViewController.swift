//
//  ViewController.swift
//  ChatWithMyself
//
//  Created by Malachi Hul on 2021/08/17.
//

import UIKit

class ChatCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    let rightMessageCellID = "rightMessage"
    let leftMessageCellID = "leftMessage"
    var username = ""
    var bottomConstraint: NSLayoutConstraint?
    let chatViewModel = ChatViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum ChatProperties: CGFloat {
        case chatHeightOffset = 32
        case chatWidthOffset = 50
        case chatHeightDefault = 80
    }
    
    enum KeyboardProperties: CGFloat {
        case textFieldWithKeyboardOffset = 35
    }
    
    // MARK: UI Properties
    
    let textInputView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.lighter(by: 25)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Aa"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(8.0)
        textField.setRightPaddingPoints(8.0)
        textField.clearButtonMode = .whileEditing
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textField
    }()

    // MARK: LIFECYCLE

    init() {
         super.init(collectionViewLayout: UICollectionViewFlowLayout())
     }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupChat()
        setupBottomTextField()
        guard let username = self.title else { return }
        chatViewModel.getUserChats(name: username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: Assist Methods
    private func setupChat() {
        title = "Chat With Myself"
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.backgroundColor = .white
        
        // register cells
        guard let chatCollectionView = self.collectionView else { return }
        chatCollectionView.register(RightMessageCollectionViewCell.self, forCellWithReuseIdentifier: rightMessageCellID)
        chatCollectionView.register(LeftMessageCollectionViewCell.self, forCellWithReuseIdentifier: leftMessageCellID)
    }
    
    private func setupBottomTextField() {
        view.addSubview(textInputView)
        textInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = textInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        if let bottomTextConstraint = bottomConstraint {
            bottomTextConstraint.isActive = true
        }

        textInputView.addSubview(inputTextField)
        inputTextField.topAnchor.constraint(equalTo: textInputView.topAnchor, constant: 7).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor, constant: 10).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor, constant: -60).isActive = true

        textInputView.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: textInputView.topAnchor, constant: 5).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor, constant: -10).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(inputHandler), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func inputHandler(notification: NSNotification) {
        showHideKeyboardListener()
        
        guard let userInfo = notification.userInfo, let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        bottomConstraint?.constant = -keyboardSize.height + KeyboardProperties.textFieldWithKeyboardOffset.rawValue
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
        
    func showHideKeyboardListener(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
        bottomConstraint?.constant = 0
    }
    
    @objc func sendButtonTapped() {
        guard let text = inputTextField.text else { return }
        guard let username = self.title else { return }
        self.chatViewModel.createChat(name: username, sender: true, message: text)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            guard let self = self else { return }
            
            let reply = "\(text) back!"
            guard let username = self.title else { return }
            self.chatViewModel.createChat(name: username, sender: false, message: reply)
            self.collectionView.reloadData()
        }
        self.inputTextField.text = ""
    }
}


// UICollectionViewDataSource and ViewDelegateFlowLayout
extension ChatCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(chatViewModel.model.count)
        return chatViewModel.model.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = chatViewModel.model[indexPath.row]
        guard let textMsg = model.message else { return UICollectionViewCell() }
        let isSender = model.sender

        if isSender {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rightMessageCellID, for: indexPath) as? RightMessageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.rightTextBubbleWidthAnchor?.constant = estimateFrameForText(text: textMsg).width + ChatProperties.chatWidthOffset.rawValue
            cell.rightMessageTextView.text = textMsg
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
            cell.rightMessageTextView.addGestureRecognizer(tap)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leftMessageCellID, for: indexPath) as? LeftMessageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.leftTextBubbleWidthAnchor?.constant = estimateFrameForText(text: textMsg).width + ChatProperties.chatWidthOffset.rawValue
            cell.leftMessageTextView.text = textMsg
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
            cell.leftMessageTextView.addGestureRecognizer(tap)
            return cell
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: ViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = ChatProperties.chatHeightDefault.rawValue
        guard let textMsg = chatViewModel.model[indexPath.row].message else { return CGSize(width: view.frame.width, height: height) }
        height = estimateFrameForText(text: textMsg).height + ChatProperties.chatHeightOffset.rawValue
        return CGSize(width: view.frame.width, height: height)
    }
    
    func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        return estimatedFrame
    }
}

