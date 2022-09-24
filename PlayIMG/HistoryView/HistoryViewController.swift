//
//  HistoryViewController.swift
//  PlayIMG
//
//  Created by suryansh Bisen on 24/09/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var historyImageData = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("History view will apper")
        ImageCDRepository.getAllData { imageData, count  in
            self.historyImageData = imageData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyImageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let historyCell = tableView.dequeueReusableCell(withIdentifier: constantData.HISTORY_TABLEVIEW_CELL) as! HistoryTableViewCell
        
        historyCell.setData(data: historyImageData[indexPath.row], count: (indexPath.row+1))
        
        return historyCell
        
    }
    
}
