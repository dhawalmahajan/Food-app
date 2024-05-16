//
//  ViewController.swift
//  Food App
//
//  Created by Dhawal Mahajan on 16/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var foodTable: UITableView!
    private var items: Food?
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTable.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "FoodCell")
        fetchApi()
        // Do any additional setup after loading the view.
    }

    func fetchApi() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/1/randomselection.php") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {[weak self] data, res, error in
            if let data = data {
                do {
                    self?.items =  try JSONDecoder().decode(Food.self, from: data)
                    DispatchQueue.main.async {
                        self?.foodTable.reloadData()
                    }
                } catch let error {
                    print(error)
                }
                
            }
        }.resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as? FoodCell else { return UITableViewCell()}
        let meal = items?.meals?[indexPath.row]
        cell.titleLbl.text = meal?.strMeal
        cell.descriptionLbl.text = meal?.strInstructions
        if let url = URL(string: meal?.strMealThumb ?? "") {
            cell.foodImage.downloaded(from: url)
        }
        let a = items?.meals?.map({ m in
            m.allProperties()
        })
        let b = a?.compactMap({ $0 }).filter { $0.contains("Ingredient") }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

protocol Loopable {
    func allProperties() -> [String]
}

extension Loopable {
    func allProperties() -> [String] {
        return props(obj: self)
    }
    
    private func props(obj: Any, prefix: String = "") -> [String] {
        let mirror = Mirror(reflecting: obj)
        var result: [String] = []
        for (prop, val) in mirror.children {
            guard var prop = prop else { continue }
   
            // handle the prefix
            if !prefix.isEmpty {
                prop = prefix + prop
                prop = prop.replacingOccurrences(of: ".some", with: "")
            }
   
            if let _ = val as? Loopable {
                let subResult = props(obj: val, prefix: "\(prop).")
                subResult.isEmpty ? result.append(prop) : result.append(contentsOf: subResult)
            } else {
                result.append(prop)
            }
        }
        return result
    }
}
