//
//  HistoryTableViewCell.swift
//  PlayIMG
//
//  Created by suryansh Bisen on 24/09/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var urlLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var imgViewM: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Image, count: Int){
        //setting the data here, not downloading
        guard let image = data.image else { return }
        imgViewM.image = UIImage(data: image)
        countLable.text = "Count: \(count)"
        urlLable.text = "URL:" + (data.url ?? "")
        dateLable.text = "Date: \(String(describing: data.date))"
        
    }
    
}
