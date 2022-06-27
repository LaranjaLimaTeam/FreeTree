//
//  CommentHeaderView.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 24/06/22.
//

import SwiftUI

struct CommentHeaderView: View {
    let comment: Comment
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedProfileImage(imageName: "person", backgroundColor: .blue)
                .padding([.top, .leading], 8)
                .frame(width: (UIScreen.main.bounds.width-32)/6, height: (UIScreen.main.bounds.width-32)/6)
            CommentView(comment: comment)
        }
        .padding([.top, .horizontal])
        .background(.red)
        .cornerRadius(16)
        .padding(.horizontal, 8)
    }
}

struct CommentHeaderView_Previews: PreviewProvider {
    static let comment = Comment()
    static var previews: some View {
        CommentHeaderView(comment: comment)
    }
}

struct CommentView: View {
    let comment: Comment
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(comment.user.name)
                Text("-")
                Text(comment.date.formatted(.dateTime))
            }
            Text(comment.comment)
        }
    }
}

struct Comment {
    let user: UserProfile = UserProfile()
    let comment =  """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Nunc ut diam ipsum vulputate vivamus urna, odio viverra.
Ut massa facilisis vel tempor nunc feugiat viverra sed.
 Molestie ipsum nulla pretium, erat nibh aenean neque, eget posuere.
 Morbi dignissim dignissim suspendisse vestibulum.
"""
    let date = Date()
}
