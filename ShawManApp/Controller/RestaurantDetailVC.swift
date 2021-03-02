//
//  RestaurantDetailVC.swift
//  ShawManApp
//
//  Created by Jai Mataji on 02/03/21.
//

import UIKit

class RestaurantDetailVC: BaseVC {
    
    var restaurantDetailData: SingleRestaurantDetailResponse!
    var restaurantData: AllRestaurantDishes!
    
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCityNameDistance: UILabel!
    @IBOutlet weak var restCuisines: UILabel!
    @IBOutlet weak var restVote: UILabel!
    @IBOutlet weak var restRate: UILabel!
    
    @IBOutlet weak var dishTableView: UITableView!
    
    @IBOutlet weak var restContactName: UILabel!
    @IBOutlet weak var restContactLocation: UILabel!
    @IBOutlet weak var restContactAddress: UILabel!
    @IBOutlet weak var restContactPhone: UILabel!
    @IBOutlet weak var disTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cuisinesCollectionView: UICollectionView!
    @IBOutlet weak var facilitiesCollectionView: UICollectionView!
    
    var dishes = [RestaurantDishes]()
    var cuisines = [Cuisines]()
    var facilities = [Facilities]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSingleRestaurantDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func getCuisines(data:[Cuisines])->String{
        var dataStr = ""
        if data.count == 0 {
            return dataStr
        }
        for i in 0...data.count-1{
            if i == 0{
                dataStr = data[i].Cuisine
            }else{
                dataStr = dataStr + ", " + data[i].Cuisine
            }
        }
        return ""
    }
    
    func setDataToViews(data:SingleRestaurantDetailResponse){
        restName.text = data.RestaurantName
        restCityNameDistance.text = "\(data.CityName ?? ""), \(data.Location ?? "") | \(getKmValue(meter: data.Distance ?? 0.0))"
        restCuisines.text = getCuisines(data:data.Cuisines ?? [Cuisines]())
        restVote.text = "\(data.Rating ?? 0)"
        restRate.text = data.OpeningsHours
        
        restContactName.text = data.RestaurantName
        restContactLocation.text = "\(data.CityName ?? ""), \(data.Location ?? "") | \(getKmValue(meter: data.Distance))"
        restContactAddress.text = data.RestaurantAddress
        restContactPhone.text = data.ContactNumber
        
        self.dishes = data.RestaurantDishes
        self.disTableViewHeight.constant = CGFloat(self.dishes.count * 120)
        dishTableView.reloadData()
        
        self.cuisines = data.Cuisines
        self.cuisinesCollectionView.reloadData()
        
        self.facilities = data.Facilities
        self.facilitiesCollectionView.reloadData()
    }
    
    
    func getSingleRestaurantDetails(){
        self.showProgressIndicator()
        let parameters: [String:String] = [
            "StrLocLatitude": currentLatLong.latitude,
            "StrLocLongitude": currentLatLong.longitude,
            "IntLocRestaurantId": "\(restaurantData.RestaurantId ?? 0)"
        ]
        APIMananger.getSingleRestaurantDetails(parameters: parameters).responseDecodable(of: SingleRestaurantDetailResponse.self) { response in
            self.hideProgressIndicator()
            if let data = response.value{
                if data.RestaurantID != nil{
                    self.restaurantDetailData = data
                    self.setDataToViews(data: data)
                }else{
                    self.navigationController?.popViewController(animated: true)
                    self.showAlert(title: "Error", message: "Something went wrong, please try later")
                }
            }else{
                self.showAlert(title: "Error", message: "Something went wrong, please try later")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: TableView datasource/ delegate
extension RestaurantDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dishes[indexPath.row]
        let cell = dishTableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishCell
        cell.dishImageView.image = UIImage(named: ["dish1","dish2","dish3","dish4","dish5"].randomElement()!)
        cell.dishName.text = data.RestaurantDishName
        cell.dishVote.text = data.Votes
        cell.dishRate.text = "₹ \(data.Rate ?? "0")"
        
        cell.dishMainView.addBorderWithRadiusAndShadow()
        
        
        return cell
    }
}

extension RestaurantDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cuisinesCollectionView {
            return cuisines.count
        }
        else{
            return facilities.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cuisinesCollectionView {
            let data = cuisines[indexPath.row]
            let cell = cuisinesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pointCell
            cell.name.text = data.Cuisine
            cell.nameMainView.addRadius(brRadius: 10)
            cell.nameMainView.addBorder()
            return cell
        }
        else{
            let data = facilities[indexPath.row]
            let cell = facilitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pointCell
            cell.name.text = data.Facilities
            cell.nameMainView.addRadius(brRadius: 10)
            cell.nameMainView.addBorder()
            return cell
        }
    }
    
    
}

class DishCell: UITableViewCell {
    @IBOutlet weak var dishMainView: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishVote: UILabel!
    @IBOutlet weak var dishRate: UILabel!
    @IBOutlet weak var dishName: UILabel!
}

class pointCell: UICollectionViewCell {
    
    @IBOutlet weak var nameMainView: UIView!
    @IBOutlet weak var name: UILabel!
}

