import Flutter
import WidgetKit
import ActivityKit
import UIKit



@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     
      let controller : FlutterViewController = window.rootViewController as! FlutterViewController
      if #available(iOS 16.1, *) {
          var handler = ActivitiesXFlutterHandler(messenger: controller.binaryMessenger)
          handler.setMethodCallHandler()
      } else {
         
      }
    

      GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


@available(iOS 16.1, *)
class ActivitiesXFlutterHandler {

    private let methodChannel: FlutterMethodChannel
    private weak var activity: Activity<LivesActivitiesAttributes>? = nil
      
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: "ios.activities/flutter_conf",
                                             binaryMessenger: messenger)
    }

    func setMethodCallHandler() {
        methodChannel.setMethodCallHandler(handle)
    }
    
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "onStart":
        
            guard let arguments = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Los argumentos no son válidos", details: nil))
                return
            }
            
           do {
               
                let mapper: [String: AnyCodable] = arguments.mapValues { AnyCodable($0) }
                guard let data = mapper["data"]?.value as? [String: Any] else {
                           result(FlutterError(code: "INVALID_DATA", message: "El campo 'data' es inválido o está ausente", details: nil))
                           return
                       }
               let mapperConverter: [String: AnyCodable] = data.mapValues { AnyCodable($0) }
                let attributes = LivesActivitiesAttributes(name: "Event Handler")
                let contentState = LivesActivitiesAttributes.ContentState(topic:mapper["topic"]?.value as? String ?? "", mapper: mapperConverter)
               
                self.activity = try Activity<LivesActivitiesAttributes>.request(
                    attributes: attributes,
                    contentState: contentState,
                    pushType: nil)
                    
            } catch (let error) {
                result(FlutterError(code: "2", message: "Error starting Live Activity: \(error.localizedDescription)", details: "Something went wrong"))
            }
        case "onUpdate":
            guard let arguments = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Los argumentos no son válidos", details: nil))
                return
            }
            do {
                let mapper: [String: AnyCodable] = arguments.mapValues { AnyCodable($0) }
                guard let data = mapper["data"]?.value as? [String: Any] else {
                           result(FlutterError(code: "INVALID_DATA", message: "El campo 'data' es inválido o está ausente", details: nil))
                           return
                }
                let mapperConverter: [String: AnyCodable] = data.mapValues { AnyCodable($0) }
                Task {
                    for activity in Activity<LivesActivitiesAttributes>.activities {
                        await activity.update(using: LivesActivitiesAttributes.ContentState(topic: mapper["topic"]?.value as? String ?? "", mapper: mapperConverter))
                    }
                    WidgetCenter.shared.reloadAllTimelines()
                    result(true)
                }
            } catch {
                result(FlutterError(code: "2", message: "Error starting Live Activity: \(error.localizedDescription)", details: "Something went wrong"))
            }
        case "onEnd":
            do {
                Task {
                     for activity in Activity<LivesActivitiesAttributes>.activities {
                         await activity.end(dismissalPolicy: .immediate)
                     }
                 }
            } catch {
                result(FlutterError(code: "2", message: "Error starting Live Activity: \(error.localizedDescription)", details: "Something went wrong"))
            }
        default:
            result(FlutterError(code: "0", message: "Method not implemented", details: "Method called isn't implemented"))
        }
    }
}
