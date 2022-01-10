//
//  FoodResponse.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class GetFoodResponse: Codable {
    let yemekler: [Product]
    let success: Int

    init(yemekler: [Product], success: Int) {
        self.yemekler = yemekler
        self.success = success
    }
}

// MARK: - Yemekler
class Product: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String
    let rate:Double? = nil
    let detail:String? = nil
    let totalCalorie:Int? = nil
    let transportHour:Double? = nil
    var totalAmount = 0

    enum CodingKeys: String, CodingKey {
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }

    init(yemekID: String, yemekAdi: String, yemekResimAdi: String, yemekFiyat: String) {
        self.yemekID = yemekID
        self.yemekAdi = yemekAdi
        self.yemekResimAdi = yemekResimAdi
        self.yemekFiyat = yemekFiyat
    }
}
