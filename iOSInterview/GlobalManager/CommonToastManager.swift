//
//  CommonToastManager.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/4/17.
//

import MBProgressHUD

final public class CommonToastManager {
    static let shared = CommonToastManager()
    private init() {}
    
    static func showInWindow(text: String?, showDuration: TimeInterval = 1) {
        guard let firstWindow = UIApplication.shared.windows.first else {
            return
        }
        guard let text = text, text.count > 0 else {
            print("没有可用于展示的文本")
            return
        }
        let hub = MBProgressHUD.showAdded(to: firstWindow, animated: true)
        hub.label.text = text
        hub.mode = .text
        DispatchQueue.main.asyncAfter(deadline: .now() + showDuration) {
            hub.removeFromSuperview()
        }
    }
}
