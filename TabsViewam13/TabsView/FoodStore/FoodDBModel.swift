//
//  FoodDBModel.swift
//  TabsView
//
//  Created by TJ on 2021/03/04.
//

import Foundation


class FoodDBModel: NSObject{
    
    
    
    // Properties
    var storeSeqNo: Int?
    var storeName: String?
    var storeScore: Double?
    var storeCategory: String?
    var priceRange: String?
    var storeAddress: String?
    var storeImage: String?
    
    var storeTel: String?
    var storeMenu: String?
    var storeReview: String?
    
    // Empty constructor
    override init() {
        
    }
    
    init(storeSeqNo: Int? = nil, storeName: String? = nil, storeScore: Double? = nil, storeCategory: String? = nil, priceRange: String? = nil, storeAddress: String? = nil, storeImage: String? = nil) {
        self.storeSeqNo = storeSeqNo
        self.storeName = storeName
        self.storeScore = storeScore
        self.storeCategory = storeCategory
        self.priceRange = priceRange
        self.storeAddress = storeAddress
        self.storeImage = storeImage
    }
    
    
    
}
