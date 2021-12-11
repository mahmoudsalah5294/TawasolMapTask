//
//  APIDataSourceProtocol.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 18/11/2021.
//

import Foundation

protocol APIDataSourceProtocol{
    
    func fetchSid(token: String,completion: @escaping ResponseHandler<SidModel>)
    
    func fetchUnit(sidModel: SidModel,completion: @escaping ResponseHandler<UnitModel>)
    
    func fetchAddress(lon:String,lat:String,uid:String,completion: @escaping ResponseHandler<AddressModel>)
    
    func fetchSensorsValues(sid:String,uid:String,completion: @escaping ResponseHandler<SensorsValuesModel>)
 
}
