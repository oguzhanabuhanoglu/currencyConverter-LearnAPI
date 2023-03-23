//
//  ViewController.swift
//  currencyConverter
//
//  Created by Oğuzhan Abuhanoğlu on 22.04.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var trylabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & session
        // 2) Response & data
        // 3) Parsing & JSON Serialization
        
        // 1.
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=1658c9ffcfd4ed05fd0480f230b6e16d")
        
        let session = URLSession.shared
        
        //CLOSURE
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                if data != nil {
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                // print rates
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.trylabel.text = "TRY: \(turkish)"
                                }
                           }
                        }
                        
                    }catch {
                        print("error")
                    }
            }
        }
            
    }
        task.resume()
        
        
    

}

}
