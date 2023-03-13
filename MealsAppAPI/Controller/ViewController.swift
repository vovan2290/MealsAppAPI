//
//  ViewController.swift
//  MealsAppAPI
//
//  Created by Imac on 3/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var resultsData: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        getResultData { [self] in
            reloadTable()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsData?.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let meal = resultsData?.meals
        cell.textLabel?.text = meal![indexPath.row].strMeal
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MealsViewController") as! MealsViewController
        vc.meals = resultsData?.meals?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: - MealsManagerAPI
    
    func getResultData(completion : @escaping () -> ()) {
        
        let url = URL(string:"https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        URLSession.shared.dataTask(with: url!) { [weak self] (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(Response.self, from: data)
                self?.resultsData = empData
                completion()
            }
        }.resume()
    }
    
}


