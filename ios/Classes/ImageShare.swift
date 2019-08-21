import Flutter
import UIKit

public class ImageShare: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "de/brandad-systems/socialdear/image_share", binaryMessenger: registrar.messenger())
        let instance = ImageShare()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    var document: UIDocumentInteractionController!


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any?]
        let iosPackageId = args!["IOS_PACKAGE_ID"] as? String
        let iosAppId = args!["IOS_APP_ID"] as? String
        
        let canOpenPackage = UIApplication.shared.canOpenURL(URL(string: iosAppId!)!)
        if ("isPackageInstalled" == call.method) {
            result(canOpenPackage)
        }
        else if ("share" == call.method) {

            if canOpenPackage {

                let filePath = args!["path"] as? String

                if(filePath != nil) {
                    let imageURL = URL(fileURLWithPath: filePath!)
                    document = UIDocumentInteractionController()
                    document.url = imageURL
                    document.uti = iosPackageId
                    
                    if !document.presentOpenInMenu(from: CGRect(),in: (UIApplication.shared.keyWindow?.rootViewController?.view)!, animated: true) {
                        print("package not found")
                    }
                }else{
                    print("fileUrl is null")
                }
                
            }
            else {
                print("package not found")
            }
            
            result(true)
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
