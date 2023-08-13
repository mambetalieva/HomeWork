//
//  ViewController.swift
//  DopUrok
//
//  Created by Каира on 13.08.2023.
//


import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    var time: Int = 0
    var timer: Timer?
    var container = AppDelegate.PersistentContainer
    lazy var  context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.text = "\(time)"
        view.font = .systemFont(ofSize: 28)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "UserName"
        view.font = .systemFont(ofSize: 28)
        return view
    }()
    
    lazy var idTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter UserID..."
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 12
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    lazy var userTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter UserName..."
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 12
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    lazy var createUserBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Create User", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        return view
    }()
    
    lazy var getUserBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Get User", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(getUser), for: .touchUpInside)
        return view
    }()
    
    lazy var updarteUserBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Update User", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        return view
    }()
    
    lazy var deleteUserBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Delete User", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        return view
    }()
    
    lazy var stopTimerBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Stop Timer", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSubView()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    func setupSubView(){
        
        view.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(30)
            
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(idTF)
        
        idTF.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(userTF)
        
        userTF.snp.makeConstraints { make in
            make.top.equalTo(idTF.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(createUserBtn)
        
        createUserBtn.snp.makeConstraints { make in
            make.top.equalTo(userTF.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(getUserBtn)
        
        getUserBtn.snp.makeConstraints { make in
            make.top.equalTo(createUserBtn.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(updarteUserBtn)
        
        updarteUserBtn.snp.makeConstraints { make in
            make.top.equalTo(getUserBtn.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(deleteUserBtn)
        
        deleteUserBtn.snp.makeConstraints { make in
            make.top.equalTo(updarteUserBtn.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(stopTimerBtn)
        
        stopTimerBtn.snp.makeConstraints { make in
            make.top.equalTo(deleteUserBtn.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
    
    @objc func startTimer(){
        time += 1
        timeLabel.text = "\(time)"
    }
    
    @objc func stopTimer(){
        timer?.invalidate()
        timeLabel.text = "Time over"
        
    }
    @objc func createUser(){
        guard let userEntity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User,
        let name = userTF.text, !name.isEmpty else {return}
        userEntity.id = .random(in: 1...100)
        userEntity.name = name
        do {
            try context.save()
        }catch let err {
            print("create user error \(err.localizedDescription)")
        }
    }
    
    @objc func getUser(){
        let fetchRequest = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            if let userName = users.last?.name {
                nameLabel.text = userName
            }
            users.forEach { user in
                print(user.id)
                print(user.name ?? "")
            }

        }catch let err {
            print("Get user error \(err.localizedDescription)")
        }
    }
    @objc func updateUser(){
        guard let idUser = Int(idTF.text ?? ""),
              let nameUser = userTF.text else {return}
        let fetchRequest = User.fetchRequest()
        
        do{
            let users = try context.fetch(fetchRequest)
            users.forEach{ user in
                if user.id == idUser {
                    user.name = nameUser
                }
            }
            try context.save()
            
        }catch let err {
            print("Update user error \(err.localizedDescription)")
        }
    }
    @objc func deleteUser(){
        guard let idUser = Int(idTF.text ?? "")
              else {return}
        
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", idUser)
        do {
            if let user = try context.fetch(fetchRequest).first {
                context.delete(user)
                try context.save()
            }else{
                print("User not found")
            }
        } catch let err{
            print("Delete user error \(err.localizedDescription)")
            
        }
    }
}
