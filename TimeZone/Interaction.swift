//
//  Presenter.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

open class Interaction <View, DataLayer> {
    public var view: View
    public var dataLayer: DataLayer
    
    public init(view: View, dataLayer: DataLayer) {
        self.view = view
        self.dataLayer = dataLayer
    }
}
