//
//  FailableDecodable.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
