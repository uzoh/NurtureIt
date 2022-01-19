//
//  Encodable+Extension.swift
//  Nurture
//
//  Created by Emmanuel Okwara on 29/12/2021.
//

import Foundation

extension Encodable {
    public var asDictionary: Params {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { ($0 as? Params) ?? [:] } ?? [:]
    }
}
