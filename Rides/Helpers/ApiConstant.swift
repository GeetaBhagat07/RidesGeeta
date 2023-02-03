//
//  ApiConstant.swift
//  EmployeeHealth
//
//  Created by Surjeet Singh on 15/03/2019.
//  Copyright © 2019 Surjeet Singh. All rights reserved.
//

import UIKit

enum Config {
    // Copy base url here
    #if DEVELOPMENT
    static let baseURL: String = "http://34.193.203.207/"
    #else
    static let baseURL: String = "http://34.193.203.207/"
    #endif
    
    static let faq                   = "https://lottawins.app/privacy-policy/"

    // All end points will be here
    static let login                   = "auth/login/"
    
    static let forgotPassword          = "auth/password/forgot/"
    
    static let registerUser            = "auth/signup/"
    static let loginUser            = "auth/otp/login/"
    
    static let regenerateOTPCode       = "auth/signup/otp/resend/"

    static let verifyOTPCode           = "auth/signup/otp/verify/"
    static let verifyLoginOTPCode           = "auth/login/otp/verify/"

    static let createUsername          = "auth/otp/username/"

    static let getuserProfile          = "profile/"
    
    static let checkUsername           = "/auth/check/username/"
    
    static let checkEmail                = "/auth/check/email/"
    
    static let socketURL                 = "ws://34.193.203.207/connect/?"
    
    static let chatSocketURL             = "ws://34.193.203.207/connect/"
    
    static let refreshToken              = "/token/refresh"
    
    static let enableSettings            = "profile/settings/"
    
    static let getAllTickets             = "/profile/tickets/"
    
    static let giveawayList              = "giveaways/"
    
    static let createTicket              = "/tickets/"
    
    static let getSponsoredContent       = "sponsored-content/"

    static let getQuizLists              = "quiz/"
    
    static let increaseCoins             = "update/coins/?batch_completed=true"
    
    static let updateCoins               = "update/coins/"
    
    static let watchAdmobs               = "?video_watched=true"
    
    static let applyReferralCode         = "profile/apply/invite/code/"

    static let sendMessage               = "chat/"
    
    static let readProfile               = "profile/"
    
    static let saveToken                 = "app/token/"
    
    static let startLiveStream           = "giveaways/start/livestream/"
    
    static let stopLiveStream            = "giveaways/stop/livestream/"
    
    static let userStatusForlivestream   = "livestream/"
    
    static let submitMegamulaSurvey   = "giveaways/megamula-survey-answer/"
    
    static let submitMegamulaQuiz   = "giveaways/megamula-quiz-answer/"
}

enum Keys {
    static let email    = "email"
    static let password = "password"
    static let phoneNumber = "phone_number"
    static let countryCode = "country_code"
    static let confirmPassword = "confirm_password"
    static let otpCode = "code"
    static let username = "username"
    static let auth = "Authorization"
    static let jwt = "JWT"
    static let dob = "dob"
    static let tokenKey = "token="
    static let profilePic  = "profile_pic"
    static let profileNameConstant  = "imageFile.jpg"
    static let messageSocketKey   = "message"
    static let enableNotification = "enable_notification"
    static let enableLocation = "enable_location"
    static let is_skipped = "is_skipped"
    static let giveAwayId = "giveAwayId"
    static let sponsoredContentID    = "sponsored_content_id"
    static let giveaway_id    = "giveaway_id"
    static let answer    = "answer"
    static let quiz_id    = "quiz_id"
    static let giveaway = "giveaway"
    static let message = "message"
    static let platform = "platform"
    static let token = "token"
    static let url = "url"
    static let live_stream_url = "live_stream_url"
    static let type = "type"
    static let user = "user"
    static let user_won = "user_won"
    static let tier_name = "tier_name"
    static let winning_prize = "winning_prize"
    static let user_profile_pic = "user_profile_pic"
    static let winner_page_logo = "winner_page_logo"
    static let ticket_image = "ticket_image"
    static let prize_type = "prize_type"
    static let winning_ticket = "winning_ticket"
    static let live_link_update = "live_link_update"
    static let question_id = "question_id"
    static let number = "number"
}
