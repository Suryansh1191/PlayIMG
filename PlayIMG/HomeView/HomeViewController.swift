//
//  ViewController.swift
//  PlayIMG
//
//  Created by suryansh Bisen on 24/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "PlayIMG"
    }
    
    func configureUI() {
        spinner.isHidden = true
    }


    @IBAction func downloadButton(_ sender: Any) {
        
        spinner.isHidden = false
        
        //API Call
        let url = URL(string: URLStorage.image)
        guard url != nil else { return }
        let urlRequest = URLRequest(url: url!)
        ApiNetworkCall.apiCall(ImageModel.self, url: urlRequest) { result in
            switch result {
            case .success(let data):
                
                //seting image from the url
                let image = data.message
                DispatchQueue.main.async{
                    self.imgView.setImageWithURL(image) {
                        //saving the imge data
                        DispatchQueue.main.async{
                            self.spinner.isHidden = true
                            if let imageData = self.imgView.image?.pngData(){
                                ImageCDRepository.saveData(image: imageData, url: data.message ?? "") {   }
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
                //TODO: ERROR HANDLING
            }
        }
        
    }
}

