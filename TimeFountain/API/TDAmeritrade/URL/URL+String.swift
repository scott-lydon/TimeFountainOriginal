//
//  String.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension String {
    
    static var baseURL: String {
        return "https://api.tdameritrade.com/v1/"
    }
    
    static var authURL: String {
        return "https://auth.tdameritrade.com/"
    }
    
    static var accessToken: String {
        return "PKa2iUV0Kn/FvgcMZ/SLET76dAgjZAn4L04hQHN07AahZRAJAmdA1iEl574OAMDN2n8PGWmX4psFXNvbhfMT/HfWLQNlk29kv9Wo16dOj/tYUm59GmSTdn7wlrhlduqpWElqYk1JrzA8CxrICcAMVW55mDAIRxfgWiK7E8wEQas9Va0pElJtVozvY656b3TgdVCDNyjNiZkWEHg6hIk01sX4yPxnmMMq4EsONHwgCVu0lG6frh4SEdutUyrDToB9dyemzYDYwRe4Rg7lDjkhhFXozazFBbkBHkYDS53A+7BJcu56kZTEQr2hgHUupr+z9gsHdry9KsWs6yV6o6GpJ7XV6xDAmGjrdRoeRdLkpi9IbUe5jv7m8P9ueHbijCqmMQiNOhGFW5Q04cwUZjIHYP6pziLTKCXOupeQf4ziEjqVk/xllZi7Zov7cCUtxNIHXSzu4mUIYMfCU8pzB01rSxpTgxyP1wmse8dqXlAC+YkGCLUQVI8tdqTpnLtxSRifzg6opbQVd2gmZPXASHky75C/EJ54BSZ/a10dV100MQuG4LYrgoVi/JHHvlhho3L9mWH7tCoBcc1pGm3MUMlh+/xb12S9Y7M8+PTiq3KtpCJqmkxPjTWjke72sICzBL31IPKKEbLSYnuyEHQknHyKZwFDnNfHERZ2zQOVfGTWPbp6E65uJ8gYG6a4GNqRrIdQhiaxVRUt0GJSSWDgLeA0AdUSxllwO1yk6CJNUjw8Z2mCBi0li7sXixLrdlL3WeLuPPWEF+DEKF6ZPlrIZGbrMw6bgVDJ3W968IZMuzR5MwUFoYQyPMX8JAbamDPKz2QZwDQTtCL+qcrvYmYyhGDYz4oYEenXV0Gm0tT7huH7JkAXBDLNHn2GHBu1LoG0qmB7FGhbZ/j/WtbHcfq9Q6gvKQ9816xJSxtQfocGC0qAbUnys+hcE+XZp4f0BF77U1+weHYYta12+T4J1R41BgWpNwrTfKzVvG9SOKCiqnYln7AbMIOIa8zxvauZPT6a36KO2gCNd1woqcMfkTot+UH92bJT1IwSU15MSCFgwKXyFThuNUi8yzPEpb1YCgSRVoMAx3e6+u6BNSApCACM9x05JTNtP1oYMY5i212FD3x19z9sWBHDJACbC00B75E"
    }
    
    static var accessTokenLiteral: String {
        "accessToken"
    }
    
    static var refreshTokenLiteral: String {
        "refreshToken"
    }
}
