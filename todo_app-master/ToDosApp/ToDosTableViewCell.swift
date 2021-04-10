//
//  ToDosTableViewCell.swift
//  ToDos
//
//  Created by Creo Server on 17/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit

class ToDosTableViewCell: UITableViewCell
{
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    func setupmainCell()
    {
        let standardPadding: CGFloat = 10.0
        
        self.contentView.addSubview(label)
        
        //textfield constraint
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: standardPadding).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: standardPadding).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor , constant: standardPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: standardPadding).isActive = true
        label.font = UIFont(name: (label.font?.fontName)! , size: 24)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if let id = reuseIdentifier, id == "mainCell"
        {
            print("in cell todo init")
            self.setupmainCell()
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
