//
//  AppContainer.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import Swinject

fileprivate var privateAppContainer: Container?

public var appContainer: Container {
    get {
        guard let container = privateAppContainer else {
            fatalError("Type Container not set")
        }
        return container
    }
}

public func initializeAppContainer() {
    if privateAppContainer != nil {
        fatalError("App container can not be initalized more than once")
    }
    
    privateAppContainer = Container()
    
    appContainer.register(AppRouterType.self) { _ in AppRouter() }
    appContainer.register(MainViewDataLayerType.self) { _ in MainViewDataLayer() }
    appContainer.register(EditViewDataLayerType.self) { _ in EditViewDataLayer() }
}
