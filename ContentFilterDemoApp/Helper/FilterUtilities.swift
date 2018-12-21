
import Foundation
import NetworkExtension

open class FilterUtilities {
    
    // MARK: Properties
    public static let defaults = UserDefaults(suiteName: "7J3EXH6427.group.com.demo.ContentFilterDemoApp")
    open class func shouldAllowAccess(_ flow: NEFilterFlow) -> Bool {
        //access to your app and certains url should be allowd handling
        if #available(iOS 11.0, *) {
            if let bundleId = flow.sourceAppIdentifier {
                logw("sourceAppIdentifier \(bundleId)")
                if bundleId == "7J3EXH6427.com.demo.ContentFilterDemoApp"{
                    return true
                }
            }
        } else {
            // Fallback on earlier versions
            let hostname = FilterUtilities.getFlowHostname(flow)
            logw("host name is \(hostname)")
            if hostname.isEmpty {
                return true
            }
            if hostname == "192.168.100.48" {
                return true //our own server url
            }
        }
        return defaults?.bool(forKey: "rules") ?? true
    }
    
    
    /// Get the hostname from a browser flow.
    open class func getFlowHostname(_ flow: NEFilterFlow) -> String {
        guard let browserFlow : NEFilterBrowserFlow = flow as? NEFilterBrowserFlow,
            let url = browserFlow.url,
            let hostname = url.host
            , flow is NEFilterBrowserFlow
            else { return "" }
        return hostname
    }
    
    
    open class func fetchRulesFromServer(_ serverAddress: String?) {
        guard serverAddress != nil else { return }
        guard let infoURL = URL(string: "\(serverAddress!)/api/v1/rules") else { return }
        let content: String
        do {
            content = try String(contentsOf: infoURL, encoding: String.Encoding.utf8)
        }
        catch {
            return
        }
        let utf8ShouldAllowAccess = String(utf8String: "ALLOW".cString(using: .utf8)!)
        if content ==  utf8ShouldAllowAccess{
            defaults?.setValue(true, forKey:"rules")
        }else{
            defaults?.setValue(false, forKey:"rules")
        }
    }
    
}

