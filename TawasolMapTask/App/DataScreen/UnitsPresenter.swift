//
//  UnitsPresenter.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 16/11/2021.
//

import Foundation



protocol UnitsPresenterProtocol:AnyObject{
    func fetchData(token: String)
    
    func fetchUnits(sidModel:SidModel)
    
    func fetchAddress(lon: String, lat: String, uid: String)
    
    func fetchSensorsValues(sid:String,uid:String)
    
    
}



class UnitsPresenter:UnitsPresenterProtocol{
    private let datasource:APIDataSourceProtocol
    private weak var view:UnitsTableViewProtocol?
    
    
    init(datasource:APIDataSourceProtocol,view:UnitsTableViewProtocol) {
        self.datasource = datasource
        self.view = view
    }
    
    func fetchData(token: String) {
        datasource.fetchSid(token: token) { response in
            switch (response.status!){
            case .success:
                if let sidModel = response.data{
                    print("EID: \(sidModel.eid)")
                    self.fetchUnits(sidModel: sidModel)
                }
                   
            
            case .failure:
                print(response.message ?? "Error")
            
            }
    }

    }

    func fetchUnits(sidModel: SidModel) {
        let uid = String(sidModel.user.id)
        datasource.fetchUnit(sidModel: sidModel) { (response) in
            switch (response.status!){
            case .success:
                if let unitModel = response.data?.items{
                    for item in unitModel{
                        let lon = String(item.pos.x)
                        let lat = String(item.pos.y)
                        let itemID = String(item.id)
                        
                        self.fetchAddress(lon: lon, lat: lat, uid: uid)
                        
                        
                        self.fetchSensorsValues(sid: sidModel.eid, uid: itemID)
                        self.view?.updateUnits(units: unitModel)
                }
                }
                
                
            case .failure:
                print(response.message ?? "Error")
                
            }
        }
    }
    
    
    func fetchAddress(lon: String, lat: String, uid: String) {
        
        
        datasource.fetchAddress(lon: lon, lat: lat, uid: uid) { (response) in
            switch (response.status!){
            case .success:
                if let address = response.data,!address.isEmpty{

                    self.view?.updateAddress(address: address)
                }
            case .failure:
                print(response.message ?? "Error")
            }
        }
    }
    
    func fetchSensorsValues(sid:String,uid:String) {
        datasource.fetchSensorsValues(sid: sid, uid: uid) { (response) in
            switch (response.status!){
            case.success:
                if let sensors = response.data,!sensors.isEmpty{
                    
                    self.view?.updateSensorsState(sensors: sensors)
                }
                
            case.failure:
                print(response.message ?? "Error")
            }
        }
    }
}
