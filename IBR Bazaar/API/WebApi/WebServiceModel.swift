//
//  WebServiceModel.swift
//  IBR Bazaar
//
//  Created by Monish M S on 03/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import Alamofire

public class WebServiceModel{
    open class func makePostApiCallWithParameters(parameter:[String:String], withUrl url:URL, onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        if isInternetAvailable(){
            print(url)
            print(parameter)
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            manager.request(url,method: .post, parameters: parameter)
                .responseJSON { response in
                    
                    if let err = response.result.error{
                        failure(err as NSError)
                    } else {
                        if let JSON = response.result.value as! Dictionary<String, AnyObject>? {
                            print(JSON)
                            success(JSON)
                        }else {
                            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                        }
                    }
                    
            }
            
        }else{
            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No internet connection"]))
        }
    }
}

