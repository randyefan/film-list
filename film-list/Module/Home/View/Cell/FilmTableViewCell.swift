//
//  FilmTableViewCell.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 18/04/21.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    var viewModel: FilmViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
            self.releaseLabel.text = String(viewModel.releaseDate)
            self.directorLabel.text = viewModel.director
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
