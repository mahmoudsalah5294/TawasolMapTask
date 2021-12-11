//
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 15/11/2021.
//

import Foundation
import Alamofire

typealias ResponseHandler<T: Codable> = (Response<T>) -> ()



protocol RequestHandlerProtocol {
    func get<T: Codable>(url: String, completion: @escaping ResponseHandler<T>)
}

class RequestHandler:  RequestHandlerProtocol{
    
    static let shared = RequestHandler()
    private init(){}
    
    func get<T: Codable>(url: String, completion: @escaping ResponseHandler<T>){

        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
            AF.request(url, method: .get).responseDecodable(of:T.self) { response in
                     switch response.result {
                            case .success:
                                switch response.response?.statusCode {
                                case 200:
                                    //response.value
//                                 print("\n******************************")
//                                 print("Request url: \(url)")
         //                        print("******************************")
         //                        print("success")
         //                        print("******************************\n")
                                 completion(Response(data: response.value, message: "success", status: .success))
                                default:
                                    //handle other cases
                                 completion(Response(data: nil, message: "failure", status: .failure))
                                }
                            case let .failure(error):
                                //probably the decoding failed because your json doesn't match the expected format
                             completion(Response(data: nil, message: error.localizedDescription, status: .failure))
                     }
                 }
             }
    }
}
