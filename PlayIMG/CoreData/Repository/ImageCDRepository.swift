//
//  ImageCDRepository.swift
//  PlayIMG
//
//  Created by suryansh Bisen on 24/09/22.
//

import Foundation
import UIKit
import CoreData

class ImageCDRepository{

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //should not access AppDelegate any where, better solution can be creating an persistentStorage Class and having all the persistentContainer code and access that in live project.
    
    
    static func saveData(image: Data, url: String, compition: @escaping ()->Void){
        
        var maxImageCount = 10
        
        //checking if image alredy exists
        ImageCDRepository.isImageAlredyExist(url: url) { isExist, imageCD in
            
            if isExist{
                
                //Changing Its date to make it in first position
                imageCD!.date = Date()
                
                //this func will check max count delete if need and save the data
                maxCountSaver(data: imageCD!, maxCount: maxImageCount)
                
            }else{
                
                //creating an image data
                let imageCD = Image(context: context)
                imageCD.image = image
                imageCD.url = url
                imageCD.date = Date()
                
                maxCountSaver(data: imageCD, maxCount: maxImageCount)
                
                
            }
            
        }
    }
    
    static func getAllData(complition: @escaping ([Image], Int) -> Void) {
        
        var fetchingImage = [Image]()
        
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        let sort = NSSortDescriptor(key: #keyPath(Image.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]

        
        do {
            fetchingImage = try context.fetch(fetchRequest)
        } catch {
            print("Error while fetching the image")
        }
        
        if(fetchingImage.count != 0){
            
            //making newst data first by inversing the array
            var inversedfetchData = [Image]()
            for i in (0..<fetchingImage.count).reversed() {
                inversedfetchData.append(fetchingImage[i])
            }
            
            complition(inversedfetchData, fetchingImage.count)
        }else{
            //TODO: ERROR HANDLING
            complition(fetchingImage, fetchingImage.count)
        }
        
    }
    
    static func isImageAlredyExist(url: String, complition: (Bool, Image?)-> Void){
        
        var fetchedImage = [Image]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        let fetchByURL = NSPredicate(format: "url=%@", url as CVarArg)
        fetchRequest.predicate = fetchByURL
        
        do {
            fetchedImage = try context.fetch(fetchRequest) as! [Image]
            
            if fetchedImage.count == 0{
                complition(false, nil)
            }else{
                complition(true, fetchedImage[0])
            }
            
        } catch {
            print("Error while fetching the image")
            complition(false, nil)

        }
    }
    
    static func maxCountSaver(data: Image, maxCount: Int){
        
        ImageCDRepository.getAllData { data, count in
            
            if ((count) > maxCount){
                deleteData(data: data[count-1])
            }
            
            //saving the imageCD
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
                //TODO: ERROR HANDING
            }
            
        }
        
    }
    
    static func deleteData(data: Image){
        context.delete(data)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
    }
}
