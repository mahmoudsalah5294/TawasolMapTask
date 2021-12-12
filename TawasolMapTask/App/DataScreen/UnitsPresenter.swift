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
    
    
    func fetchAddress(uid: String, sid:String, unit:[Item])
    
    func fetchSensorsValues(sid:String,unit:[Item],address:AddressModel)
    
    
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

                    self.fetchAddress(uid: uid,sid: sidModel.eid,unit: unitModel)
                }
                
                
            case .failure:
                print(response.message ?? "Error")
                
            }
        }
    }
    
    
    func fetchAddress(uid: String, sid:String,unit:[Item]) {
        
        var addresses:[String] = []
        for count in 0...unit.count-1{
            let lon = String(unit[count].pos.x)
            let lat = String(unit[count].pos.y)
        datasource.fetchAddress(lon: lon, lat: lat, uid: uid) { (response) in
            switch (response.status!){
            case .success:
                if let address = response.data,!address.isEmpty{
                    addresses.append(address[0])
                    
                    if count == (unit.count-1){
                        self.fetchSensorsValues(sid: sid, unit: unit,address: addresses )
                    }
                }
            case .failure:
                print(response.message ?? "Error")
            }
        }
    }
    }
    func fetchSensorsValues(sid:String,unit:[Item],address:AddressModel) {
        
        var sensorsArray:[[String: Double]] = []
        
        for count in 0...unit.count-1{
            let uid = String(unit[count].id)
        datasource.fetchSensorsValues(sid: sid, uid: uid) { (response) in
            switch (response.status!){
            case.success:
                if let sensors = response.data,!sensors.isEmpty{
                    sensorsArray.append(sensors)
                    
                    if count == (unit.count-1){
                    self.view?.updateTable(units: unit, address: address, sensors: sensorsArray)
                    }
                }
                
            case.failure:
                print(response.message ?? "Error")
            }
        }
        }
    }
}
