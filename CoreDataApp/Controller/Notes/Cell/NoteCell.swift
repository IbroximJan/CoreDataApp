//
//  NoteCell.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit

class NoteCell: UITableViewCell {
    
    static let identifier = "NoteCell"
    
    weak var quoteLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
    }
    
    func setQuote(quote: String, textColor: UIColor) {
        quoteLabel.text = quote
        quoteLabel.textColor = textColor
    }
    
    func initCell() {
        let quoteLabel = Label(text: "", textColor: .appOrange, fontSize: 20, weight: .regular, style: "Times New Roman")
        self.addSubview(quoteLabel)
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        quoteLabel.adjustsFontSizeToFitWidth = true
        self.quoteLabel = quoteLabel
        quoteLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
