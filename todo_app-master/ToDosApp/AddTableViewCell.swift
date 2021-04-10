//
//  AddToTopTableViewCell.swift
//  ToDos
//
//  Created by Creo Server on 17/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell
{
    var iconLabel: UILabel =
    {
      let iconLabel = UILabel()
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        return iconLabel
    }()
    var defaultLabel: UILabel =
    {
      let defaultLabel = UILabel()
        defaultLabel.translatesAutoresizingMaskIntoConstraints = false
        return defaultLabel
    }()
    
    func setupCell()
    {
        let standardPadding: CGFloat = 10
        
        //setting default label
        self.contentView.addSubview(defaultLabel)
        defaultLabel.font = UIFont(name: defaultLabel.font.fontName, size: 24)
        defaultLabel.text = "Add Item"
        defaultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: standardPadding).isActive = true
        defaultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: standardPadding).isActive = true
        defaultLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: standardPadding).isActive = true
        defaultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: standardPadding).isActive = true
        
        //setting icon label
        self.contentView.addSubview(iconLabel)
        iconLabel.font = UIFont(name: defaultLabel.font.fontName, size: 30)
        iconLabel.text = "➕"
        iconLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: contentView.frame.size.width * 1.1 ).isActive = true
        iconLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: standardPadding ).isActive = true
        iconLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: standardPadding).isActive = true
        iconLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: standardPadding).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if let id = reuseIdentifier, id == "addCell"
        {
            self.setupCell()
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
