//
//  NoteVC.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit

class NoteVC: UIViewController {
    
    
    var titleLabel : Label!
    let backButton = UIButton()
    let saveButton = UIButton()
    let tableView  = UITableView()
    var notes: [Notes] = []
    let addNoteButton = UIButton()
    let noteTextField = TextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appLightBlue
        initViews()
        
        notes =  DataManager.shared.fetched()
        tableView.reloadData()
        
    }
    
    func initViews() {
        
        
        let titleLabel = Label(text: "Notes", textColor: .appOrange, fontSize: 35, weight: .bold, style: "Times New Roman")
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
        backButton.setImage(UIImage(named: "backOrange"), for: .normal)
        backButton.tag = 0
        backButton.addTarget(self, action: #selector(openVC(sender:)), for: .touchUpInside)
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        view.addSubview(saveButton)
        saveButton.layer.cornerRadius = 20
        saveButton.setImage(UIImage(named: "save"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
        }
        
        view.addSubview(noteTextField)
        noteTextField.placeholder = "Quote"
        noteTextField.layer.cornerRadius = 10
        noteTextField.layer.borderWidth = 1
        noteTextField.layer.borderColor = UIColor.appOrange.cgColor
        noteTextField.textColor = .appOrange
        noteTextField.font = .systemFont(ofSize: 19)
        noteTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(45)
        }
        
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(noteTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
        
        
    }
    
    @objc func saveNote() {
        
        guard let newNote = noteTextField.text else {
            return
        }
        noteTextField.text = ""
        
        let note = DataManager.shared.notes(quote: newNote)
        notes.append(note)
        tableView.reloadData()
        DataManager.shared.save()
        
        
        
        
    }
    
    @objc func openVC(sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension NoteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.backgroundColor = .clear
        cell.setQuote(quote: note.quote ?? "", textColor: .appOrange)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  editingStyle == .delete else {return}
        
        
        let deleteNotes = notes[indexPath.row]
        let isDelete = DataManager.shared.deleteNotes(deleteNotes)
        if isDelete == true {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }

        
        
        
    }
    
    
    
    
    
    
}
