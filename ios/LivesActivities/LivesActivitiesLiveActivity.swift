//
//  LivesActivitiesLiveActivity.swift
//  LivesActivities
//
//  Created by Guerin Steven Colocho Chacon on 6/10/24.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct LivesActivitiesLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LivesActivitiesAttributes.self) { context in
            let (uberModel, errorMessage) = initializeModel(context: context)
            
            Group {
                if let model = uberModel {
                    VStack {
                        Text("Driver: \(model.uberDriverName)")
                        Text("Car Plate: \(model.uberCarPlate)")
                    }
                } else {
                    VStack {
                        Text("Hello \(context.state.topic)").foregroundStyle(.white)
                    }
                }
                
            }
            
        } dynamicIsland: { context in
            let (uberModel, errorMessage) = initializeModel(context: context)
            
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    if let safeModel = uberModel {
                        VStack {
                            Image(safeModel.uberLogo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                            
                        }
                    } else {
                        EmptyView()
                    }
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let safeModel = uberModel {
                        VStack {
                            ZStack{
                                Image("uber_user_car")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45,height: 45)
                                let image: Image = {
                                    let imageUrl = URL(string: safeModel.uberDriverImage)
                                    guard let imageData = try? Data(contentsOf: imageUrl!) else {
                                        return Image("Error loading image")
                                    }
                                    guard let uiimage =  UIImage(data: imageData) else {
                                        return Image("Error loading image")
                                    }
                                    let compress = uiimage.aspectFittedToHeight(75)
                                    return Image(uiImage:compress )
                                    
                                }()
                                image.resizable().scaledToFill().frame(width: 25, height: 25)
                                    .clipShape(Circle())
                                    .offset(x: -15)
                                
                            }
                            
                        }
                    } else {
                        EmptyView()
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        uberView(uberModel: uberModel)
                    }
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.topic)")
            } minimal: {
                Text(context.state.topic)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
    
    private func initializeModel(
        context: ActivityViewContext<LivesActivitiesAttributes>
    ) -> (UberModel?, String?) {
        do {
            if context.state.topic == "uber" {
                let model = try UberModel(from: context.state.mapper)
                return (model, nil)
            }
        } catch {
            print(error)
            return (nil, "Failed to load Uber data.")
        }
        return (nil, nil) 
    }
    @ViewBuilder
    func uberView(uberModel: UberModel?) -> some View {
        if let safeModel = uberModel {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Droppoff at \(safeModel.uberArriveTime)")
                            .fontWeight(.heavy)
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(
                                maxWidth: .greatestFiniteMagnitude,
                                alignment: .leading
                            )
                        
                        Text("Heading to \(safeModel.uberAddress)")
                            .fontWeight(.light)
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                            .frame(
                                maxWidth: .greatestFiniteMagnitude,
                                alignment: .leading
                            )
                    }
                    .frame(alignment: .leading)
                    
                }
                HStack {
                  
                    ZStack(alignment: .leading) {
                      
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 5)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: (uberModel?.uberProgress ?? 0.0) * UIScreen.main.bounds.width * 0.75, height: 5)
                        Image("uber")
                            .resizable()
                            .frame(width: 45, height: 15)
                            .offset(x: (uberModel?.uberProgress ?? 0.0) * UIScreen.main.bounds.width * 0.75 - 15)
                    }
                    .cornerRadius(2.5)
                }
                .padding(.horizontal, 16)
                
                
            }
        } else {
            Text("Somethibg went wront \(uberModel)")
        }
    }
}

extension LivesActivitiesAttributes {
    fileprivate static var preview: LivesActivitiesAttributes {
        LivesActivitiesAttributes(name: "World")
    }
}

#Preview("Notification", as: .content, using: LivesActivitiesAttributes.preview)
{
    LivesActivitiesLiveActivity()
    
} contentStates: {
    
    LivesActivitiesAttributes.ContentState.smiley
    LivesActivitiesAttributes.ContentState.starEyes
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
