import Foundation
import UIKit


struct gif {
    let urlLink : String
    
    init(urlLink: String) {
        self.urlLink = urlLink
    }
}

class getGifs {
    
    
    
    func getData() {
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=rnWButuxYbS2HdSQFL74S4D5j3nF7IN3&limit=25&rating=G")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let data = data{
                print(data)
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    
                    if let gifData = json["data"] as? [[String : Any]]{
                        print(gifData)
                        
                        for showGifs in gifData{
                            if let urlLink = showGifs["embed_url"] as? String{
                                //                                let urlImage = urlLink
                                let newGif = gif(urlLink: urlLink)
                                print(newGif)
                            }
                            //                            print(gifData)
                            //self.weather = gifData as! String
                        }
                        
                        
                    }
                    
                }catch{
                    print(error)
                }
            }
            
            
            }.resume()
        
    }
}
