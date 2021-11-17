//
//  TruckModelView.swift
//  PruebaFletx
//
//  Created by Julian González on 16/11/21.
//

import UIKit
import SwiftyJSON
import Alamofire

final class TruckModelView {
    
    var trucks = [Truck]()
    
    func getTrucks (success: (([Truck])->Void)?, failure: ((Error)->Void)?){
        trucks.removeAll()
       
        let urlFletx = URL(string: "http://st.fletx.co:3000/people/holder_vehicles/1115.json")
        
        AF.request(urlFletx!, headers: [
            .authorization("Bearer ab11cb7605a030ee350d08f805057413"),
            .contentType("application/json")
        ]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for data in json["data"].arrayValue {
                    
                    let plate = data["placa"].stringValue
                    let image = data["front_vehicle"]["url"].stringValue
                    let name = data["driver"]["full_name"].stringValue
                    let trailer = data["trailer"]["placa"].stringValue
                    let available = data["carconfig"]["status"].boolValue
                    let lonlat = data["lonlat"].stringValue
                    
                    
                    let truck = Truck()
                    truck.image = image
                    truck.plate = plate
                    truck.name = name
                    truck.trailer = trailer
                    truck.available = available
                    truck.lonlat = lonlat
                    self.trucks.append(truck)
                }
                success!(self.trucks)
            case .failure(let error):
                failure!(error)
                print(error)
            }
        }
    }
}
