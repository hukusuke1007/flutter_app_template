//
//  Logger.swift
//  Runner
//
//  Created by 中川祥平 on 2022/08/14.
//

import os

final class Logger {
    static func log(_ value: String) {
        os.Logger().log("\(value)")
    }
    static func info(_ value: String) {
        os.Logger().info("✅ \(value)")
    }
    static func error(_ value: String) {
        os.Logger().error("😡 \(value)")
    }
    static func error(_ value: Error) {
        os.Logger().error("😡 \(value.localizedDescription)")
    }
}
