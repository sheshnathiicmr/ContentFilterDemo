//////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Log.swift
//
//  Created by Dalton Cherry on 12/23/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
//  Simple logging class.
//////////////////////////////////////////////////////////////////////////////////////////////////
import Foundation
import os.log


///The log class containing all the needed methods
open class Log {
    
    ///logging singleton
    open class var logger: Log {
        struct Static {
            static let instance: Log = Log()
        }
        return Static.instance
    }
    //the date formatter
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        return formatter
    }
    
    open func write(_ text: String) {
        //os_log(text)
        if #available(iOS 10.0, *) {
            //os_log("%@", text)
            let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "ContentBlockerMLP")
            os_log("MLPNSFilterLog: %{public}@", log: log, text)
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}

///Writes content to the current log file
public func logw(_ text: String) {
    Log.logger.write(text)
}

