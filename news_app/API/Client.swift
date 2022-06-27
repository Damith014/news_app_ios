//
//  Client.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-26.
//

import Alamofire
import Foundation

class Client {
    static var shared: Client = Client()

    func getHeadingNews(county:String,language: String,withSuccess success: @escaping (_ responseDictionary: Response) -> Void, failure: @escaping (_ error: String) -> Void) {
        let url = String(format: Constant.serverAPI.URL.kGetTopHedline, county,language)
        let request = Alamofire.request(
            url + Constant.serverAPI.APIKeys.KAPIKey,
            method: .get
        )
        request.responseData { response in
            if response.response?.statusCode != 200 {
                failure(String(describing: response.response?.statusCode))
            } else {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: response.data!)
                    success(response)
                } catch {
                    failure("error")
                }
            }
        }
    }
    func getTopUpdates(page:Int, withSuccess success: @escaping (_ responseDictionary: Response) -> Void, failure: @escaping (_ error: String) -> Void) {
        let url = String(format: Constant.serverAPI.URL.kGetTopUpdates, String(page))
        let request = Alamofire.request(
            url + Constant.serverAPI.APIKeys.KAPIKey,
            method: .get
        )
        request.responseData { response in
            if response.response?.statusCode != 200 {
                failure(String(describing: response.response?.statusCode))
            } else {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: response.data!)
                    success(response)
                } catch {
                    failure("error")
                }
            }
        }
    }
    func search(text:String, withSuccess success: @escaping (_ responseDictionary: Response) -> Void, failure: @escaping (_ error: String) -> Void) {
        let url = String(format: Constant.serverAPI.URL.kSearch, text)
        let request = Alamofire.request(
            url + Constant.serverAPI.APIKeys.KAPIKey,
            method: .get
        )
        request.responseData { response in
            if response.response?.statusCode != 200 {
                failure(String(describing: response.response?.statusCode))
            } else {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: response.data!)
                    success(response)
                } catch {
                    failure("error")
                }
            }
        }
    }
    
    func category(text:String,county:String,language: String, withSuccess success: @escaping (_ responseDictionary: Response) -> Void, failure: @escaping (_ error: String) -> Void) {
        let url = String(format: Constant.serverAPI.URL.kCategory, text,county,language)
        let request = Alamofire.request(
            url + Constant.serverAPI.APIKeys.KAPIKey,
            method: .get
        )
        request.responseData { response in
            if response.response?.statusCode != 200 {
                failure(String(describing: response.response?.statusCode))
            } else {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: response.data!)
                    success(response)
                } catch {
                    failure("error")
                }
            }
        }
    }
    
}
