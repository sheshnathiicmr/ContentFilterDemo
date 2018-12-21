//
//  WebContentFilterViewController.swift
//  VPN_POC
//
//  Created by Sheshnath Kumar on 11/10/18.
//  Copyright © 2018 Example Technologies. All rights reserved.
//

import UIKit
import NetworkExtension

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilterUtilities.defaults?.setValue(false, forKey: "rules")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            if NEFilterManager.shared().providerConfiguration == nil {
                let newConfiguration = NEFilterProviderConfiguration()
                newConfiguration.username = "UserName"
                newConfiguration.organization = "ContentFilterDemoApp "
                newConfiguration.filterBrowsers = true
                newConfiguration.filterSockets = true
                newConfiguration.serverAddress = "http://192.168.100.48:3000" //url of server from where rules will be fetched
                NEFilterManager.shared().providerConfiguration = newConfiguration
            }
            NEFilterManager.shared().isEnabled = true //self.statusCell.isOn
            NEFilterManager.shared().saveToPreferences { error in
                if let  saveError = error {
                    Log.logger.write("Failed to save the filter configuration: \(saveError)")
                }
            }
        }
    }
    
    
    /// Handle the event where the view is loaded into memory.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NEFilterManager.shared().loadFromPreferences { error in
            if let loadError = error {
                Log.logger.write("Failed to load the filter configuration: \(loadError)")
                return
            }
        }
    }
    
    
    @IBAction func refreshRulesButtonPressed(_ sender: Any) {
        FilterUtilities.fetchRulesFromServer(NEFilterManager.shared().providerConfiguration?.serverAddress)
    }
    
}
