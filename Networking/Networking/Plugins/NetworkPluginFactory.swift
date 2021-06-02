//
//  NetworkPluginFactory.swift
//  ami-ios-base-customer
//
//  Created by Edric D. on 21/01/2021.
//

import Moya

public protocol NetworkPluginFactoryType {
    static func makeDefaultPlugins() -> [PluginType]
}

public class NetworkPluginFactory: NetworkPluginFactoryType {
    public static func makeDefaultPlugins() -> [PluginType] {
        [
            LoggerPlugin(verbose: true)
        ]
    }
}
