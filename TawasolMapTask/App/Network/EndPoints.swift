//
//  EndPoints.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 16/11/2021.
//

import Foundation

struct Endpoints {
    
    static let baseURL = "http://gps.tawasolmap.com/wialon/ajax.html"
    
    static let GETSID = "?svc=token/login&params={\"token\":"
    
    
    static let GETUNIT = "?params={\"spec\":{\"itemsType\":\"avl_unit\",\"propName\":\"sys_name\",\"propValueMask\":\"*\",\"sortType\":\"sys_name\"},\"force\":1,\"flags\":13644935,\"from\":0,\"to\":10000}&svc=core/search_items&sid="
    
    
    static let GETADDRESS = "http://gps.tawasolmap.com/gis_geocode?coords="
    
    
    static let GetSensorsValues = "?svc=unit/calc_last_message&params="
    
}
