//
//  APIDataSource.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 18/11/2021.
//

import Foundation


class APIDataSource:APIDataSourceProtocol{
    
    func fetchSid(token:String,completion: @escaping ResponseHandler<SidModel>) {
        let url = Endpoints.baseURL + Endpoints.GETSID + token + "}"
        RequestHandler.shared.get(url: url, completion: completion)
    }
    
    func fetchUnit(sidModel: SidModel,completion: @escaping ResponseHandler<UnitModel>) {
        let url = Endpoints.baseURL + Endpoints.GETUNIT + sidModel.eid
        RequestHandler.shared.get(url: url, completion: completion)
    }
    
    
    func fetchAddress(lon: String, lat: String, uid: String, completion: @escaping ResponseHandler<AddressModel>) {
        let url = Endpoints.GETADDRESS + "[{\"lon\":\(lon),\"lat\":\(lat)}]&uid=\(uid)"
        
        
        RequestHandler.shared.get(url: url, completion: completion)
    }
    
    func fetchSensorsValues(sid:String,uid:String,completion: @escaping ResponseHandler<SensorsValuesModel>) {
        let url = Endpoints.baseURL + Endpoints.GetSensorsValues + "{\"unitId\":\(uid)}&sid=\(sid)"
        
        RequestHandler.shared.get(url: url, completion: completion)
    }
    
    
    
}
