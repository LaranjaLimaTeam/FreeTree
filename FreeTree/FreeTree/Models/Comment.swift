//
//  Comment.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import Foundation

struct Comment: Identifiable {
    let id = UUID()
    var user: UserProfile = UserProfile()
    var comment =  """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Nunc ut diam ipsum vulputate vivamus urna, odio viverra.
Ut massa facilisis vel tempor nunc feugiat viverra sed.
 Molestie ipsum nulla pretium, erat nibh aenean neque, eget posuere.
 Morbi dignissim dignissim suspendisse vestibulum.
"""
    let date = "27/06/2022 12:00"
}
