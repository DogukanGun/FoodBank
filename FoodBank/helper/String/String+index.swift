//
//  String+index.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation


extension String{
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
            range(of: string, options: options)?.lowerBound
        }
}
