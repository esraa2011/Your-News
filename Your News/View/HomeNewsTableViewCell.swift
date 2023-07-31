//
//  HomeNewsTableViewCell.swift
//  Your News
//
//  Created by Esraa AbdElfatah on 31/07/2023.
//

import UIKit

class HomeNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var HomeNewsImage: UIImageView!
    @IBOutlet weak var HomeNewsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
