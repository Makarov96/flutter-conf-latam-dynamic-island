//
//  LivesActivitiesBundle.swift
//  LivesActivities
//
//  Created by Guerin Steven Colocho Chacon on 6/10/24.
//

import WidgetKit
import SwiftUI

@main
struct LivesActivitiesBundle: WidgetBundle {
    var body: some Widget {
        LivesActivities()
        LivesActivitiesControl()
        LivesActivitiesLiveActivity()
    }
}
