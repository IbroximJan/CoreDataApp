//
//  SavingOnNet.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 25/01/2022.
//

import UIKit

class SavingFromNet: UIViewController {

    var titleLabel : Label!
    let backButton = UIButton()
    var quoteLabel: Label!
    let tableView  = UITableView()
    var quotes: [Notes] = []
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        getQuote()
        quoteLabel.text = UserDefaultsManager.shared.getQuote()
        quotes = DataManager.shared.fetched()
        tableView.reloadData()
    }
    
    func getQuote() {
        networkManager.getQuote { kanye in
            DispatchQueue.main.async {
                self.quoteLabel.text = kanye.quote
                let quote = DataManager.shared.notes(quote: kanye.quote)
                self.quotes.append(quote)
                self.tableView.reloadData()
                DataManager.shared.save()
                
                UserDefaultsManager.shared.saveQuote(string: quote.quote)
                
            }
        }
    }
    
    func initViews() {
        view.backgroundColor = .appWhite
        
        let titleLabel = Label(text: "Quotes", textColor: .appDarkBlue, fontSize: 35, weight: .bold, style: "Times New Roman")
        self.titleLabel = titleLabel
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.1)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.centerY).multipliedBy(0.25)
        }
        view.addSubview(backButton)
        backButton.setImage(#imageLiteral(resourceName: "left"), for: .normal)
        backButton.tag = 0
        backButton.addTarget(self, action: #selector(backTo), for: .touchUpInside)
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let quoteLabel = Label(text: "Quote", textColor: .appDarkBlue, fontSize: 25, weight: .semibold, style: "Times New roman")
        view.addSubview(quoteLabel)
        self.quoteLabel = quoteLabel
        quoteLabel.numberOfLines = 0
        quoteLabel.textAlignment = .center
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }

    @objc func backTo() {
        
        dismiss(animated: true, completion: nil)
    }

}


extension SavingFromNet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as! NoteCell
        let quote = quotes[indexPath.row]
        cell.setQuote(quote: quote.quote ?? "", textColor: .appDarkBlue)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  editingStyle == .delete else {return}
        
        let deleteQuote = quotes[indexPath.row]
        
        let isDelete = DataManager.shared.deleteNotes(deleteQuote)
        if isDelete == true {
            quotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    
}
