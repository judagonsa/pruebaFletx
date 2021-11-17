//
//  ViewController.swift
//  PruebaFletx
//
//  Created by Julian González on 16/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewTrucks: UITableView!
    @IBOutlet weak var loadingData: UIActivityIndicatorView!
    
    private var truckViewModel: TruckModelView = TruckModelView()
    var trucks = [Truck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib (nibName: "TruckViewCell", bundle: nil)
        tableViewTrucks.register(nibName, forCellReuseIdentifier: "truckCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingData.startAnimating()
        tableViewTrucks.isUserInteractionEnabled = false
        loadingData.isHidden = false
        truckViewModel.getTrucks(success: { trucks in
            self.trucks = trucks
            self.tableViewTrucks.reloadData()
            
            self.tableViewTrucks.isUserInteractionEnabled = true
            self.loadingData.stopAnimating()
            self.loadingData.isHidden = true
        }, failure: { error in
            print("error al cargar: \(error)")
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TruckViewCell
        cell.dataInit(
            image: trucks[indexPath.row].image,
            plate: trucks[indexPath.row].plate,
            name: trucks[indexPath.row].name != "" ? trucks[indexPath.row].name : "Sin conductor",
            trailer: trucks[indexPath.row].trailer != "" ? "Trailer: \(trucks[indexPath.row].trailer!)" : "Trailer: Sin trailer",
            available: trucks[indexPath.row].available ? "Disponible" : "No disponible"
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let truckMapView: UIStoryboard = UIStoryboard(name: "TruckMapView", bundle: nil)
        let truckMapViewController = truckMapView.instantiateViewController(withIdentifier: "TruckMapViewController") as! TruckMapViewController
        truckMapViewController.truck = trucks[indexPath.row]
        self.present(truckMapViewController, animated: true, completion: nil)
    }
}
