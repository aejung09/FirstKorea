//
//  DBModel.swift
//  ServerJson_01
//
//  Created by 정정이 on 2021/02/15.
//

import Foundation

class DBModel: NSObject { // 상속받을건 없지만 써줌 Ns
    
    // Properites 프로퍼티
    var userId: String?
    var userPw: String?
    var userTel: String?
    
    
    
//    // Empty constructor 비어있는 컨스트럭터
//    override init() {
//
//    }
    
    init(userId: String, userPw: String, userTel: String ){
        self.userId = userId
        self.userPw = userPw
        self.userTel = userTel
       

    }
}
