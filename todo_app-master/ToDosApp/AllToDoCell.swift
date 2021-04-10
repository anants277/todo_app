//
//  AllToDoCell.swift
//  ToDosApp
//
//  Created by Creo Server on 20/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit

class AllToDoCell: UITableViewCell
{
    var allLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupAllmainCell()
    {
        let standardPadding: CGFloat = 10.0
        
        self.contentView.addSubview(allLabel)
        
        //textfield constraint
        allLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: standardPadding).isActive = true
        allLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: standardPadding).isActive = true
        allLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: standardPadding).isActive = true
        allLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: standardPadding).isActive = true
        allLabel.font = UIFont(name: (allLabel.font?.fontName)! , size: 24)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if let id = reuseIdentifier, id == "allMainCell"
        {
            print("in cell todo init")
            self.setupAllmainCell()
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
