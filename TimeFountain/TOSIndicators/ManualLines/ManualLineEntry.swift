//
//  Line.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/23/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

/// Manual lines
enum ResistanceSupportIndicators {
    case FarAboveResistance
    case justAboveResistance
    case onResistance
    case justUnderResistance
    case farUnderResistance
    case farAboveSupport
    case justAboveSupport
    case onSupport
    case justUnderSupport
    case farUnderSupport
}


struct ManualLinesEntry {
    let date: Date
    var confirmationPoints: [Int: [Double]]
    
    init(_ date: Date, lines: [Resistance]) {
        self.date = date
        confirmationPoints = [:]
        for line in lines {
            var arr = confirmationPoints[line.list.count] ?? []
            arr.append(line.value(at: date))
            confirmationPoints[line.list.count] = arr
        }
    }
}

/*
 Sean Conversation
 1.
 2.
 3.
 4. 
 [5:47 AM, 5/26/2020] Scott: Woa, you’re only doing manual static supports and resistances these days? No more dynamic ones?
 [5:47 AM, 5/26/2020] Scott: And thank you
 [5:48 AM, 5/26/2020] Sean Taylor: I modified them to be price lines so you can see the act price they are sitting at
 [5:50 AM, 5/26/2020] Scott: I’m coming up empty handed for act price in investopedia.  Are you saying actual price?
 [5:50 AM, 5/26/2020] Sean Taylor: ....yes
 [5:54 AM, 5/26/2020] Scott: I thought we manually drew resistance and support as/for price lines prior and they were mostly non flat lines.  Ah well... I’m definitely not getting something.
 [5:55 AM, 5/26/2020] Sean Taylor: The direction / flatness of support resistance lines is completely dependent on the underlying equity and it's price movement.
 [5:58 AM, 5/26/2020] Sean Taylor: Also, I've always used price-lines on longer time frames as the first set of support / resistance (as long as the stock isn't gone parabolic (completely vertical or 90°, etc)

 The more dynamic ones tend to be intra-day lines, such as lines you made during the 5 Minute time frame which are quickly discarded as it exits that time period
 [5:58 AM, 5/26/2020] Scott: Why wasn’t this a support though?
 [6:00 AM, 5/26/2020] Scott: Oohhh so the duration of a line should not exceed the time frame being looked at?
 [6:00 AM, 5/26/2020] Scott: A 5 minute time frame should generally not have 6 minute manual lines?
 [6:00 AM, 5/26/2020] Scott: Gotcha
 [6:00 AM, 5/26/2020] Sean Taylor: You said recent, I have only been trading it since it's been in the $8.25 - $9 price range, which is what the lines I have represent.

 You can draw a vertical support line there, but it is irrelevant to the current price movement of the equity, and just adds unnessary clutter that (may or may not) confuse your analysis
 [6:02 AM, 5/26/2020] Scott: And to be clear, the line is irrelevant because it crosses the price line at around 4/24
 [6:02 AM, 5/26/2020] Sean Taylor: If my memory is correct, the time frames and variable support / resistance has always confused the fuck out of you
 [6:02 AM, 5/26/2020] Scott: Yes
 [6:02 AM, 5/26/2020] Sean Taylor: That, plus it is no longer trading in a vertical stair-step pattern, it's now trading a horizontal pattern
 [6:07 AM, 5/26/2020] Scott: That’s because I’m not comfortable with it until I feel like I can represent it mathematically and efficiently in code. I was having trouble with both.  So in summary  There are 4 ways they are terminated then: they cross over the price line, their length reaches the current time frame (does this mean span across dates or actual length?), they exceed the current price range so that it’s unlikely to return, and now adding to the list is when the pattern of manual lines changes?
 [6:11 AM, 5/26/2020] Scott: Any others?
 [6:11 AM, 5/26/2020] Scott: Ways for the lines to terminate?
 [6:11 AM, 5/26/2020] Scott: Length reaches the current time frame means I can model it efficiently in code.  Phew 😌
 [6:12 AM, 5/26/2020] Sean Taylor: >Their length reaches the current time frame

 It's more about the time frame they were made in is inconsequential to the time frame you're working on.

 Example - Lines Drawn on a 1 Minute Chart, while you're working on a 6 Month Chart.

 >Span across dates or actual length
 Moreso the dates, but the general idea is to 'elimiate' any extra info that does not benefit your IMMEDIATE observation
 [6:14 AM, 5/26/2020] Scott: Let me rephrase that line span Statement
 [6:15 AM, 5/26/2020] Scott: I took this to mean, when the line becomes 6 minutes long in the 5 minute time frame, discard it.  Is that correct?
 [6:15 AM, 5/26/2020] Scott: Oh
 [6:16 AM, 5/26/2020] Scott: Lines drawn on one charts time frame don’t apply to a chart for a different time frame.
 [6:16 AM, 5/26/2020] Scott: I got that
 [6:17 AM, 5/26/2020] Scott: And when the line exits the frame left, discard it.
 [6:17 AM, 5/26/2020] Scott: Got it right?
 [6:17 AM, 5/26/2020] Sean Taylor: For coding purposes, that works
 [6:18 AM, 5/26/2020] Scott: Immediate is defined as within the current view?
 [6:18 AM, 5/26/2020] Sean Taylor: View / Trade Context
 [6:20 AM, 5/26/2020] Scott: Lines are weighted more heavily based on how recently they began, and number of confirmations.
 [6:23 AM, 5/26/2020] Scott: ...or is it not how recently they began, as much as how recently they were confirmed?
 [6:23 AM, 5/26/2020] Sean Taylor: Equity stops breaks the support : resistance pattern you setup
 [6:24 AM, 5/26/2020] Sean Taylor: Confirmation
 [6:24 AM, 5/26/2020] Scott: Sorry not understanding
 [6:24 AM, 5/26/2020] Scott: Cool
 [6:25 AM, 5/26/2020] Sean Taylor: The issue with trading is a lot of things are true, but other things are more true depending on context -- in this instance Confirmation is more true than how recent they started
 [6:25 AM, 5/26/2020] Sean Taylor: If you setup a manual support and resistance, and the stock stops following that pattern
 [6:27 AM, 5/26/2020] Scott: Right, machine learning can take care of the relative weight for me, but knowing it makes a difference I can provide those as independent variables
 [6:28 AM, 5/26/2020] Scott: This is difficult to express mathematically.
 [6:28 AM, 5/26/2020] Scott: Well unless you only mean in the ways we’ve already talked about, for example the price crosses right through the manual line
 [6:29 AM, 5/26/2020] Scott: What are all the ways price can stop following the pattern of a manual line?
 [6:30 AM, 5/26/2020] Sean Taylor: Really?

 Support  <-> Resistance - Price Range $(1-5)
 Current Stock Price ($10)
 Stock is no longer trading between $1-5, previous range deleted
 [6:31 AM, 5/26/2020] Sean Taylor: No clue how to answer that other than what you already know, which is the price action being outside the price range setup by your support/resistance
 [6:32 AM, 5/26/2020] Scott: Well you’ve mentioned another way: manual lines becoming distinctly more static than dynamic.
 
 [3:02 PM, 5/26/2020] Scott: Not sure where I last updated.  I have an array of prices, and I've created the algorithm to convert the prices to sma. I could convert the sma to a categorical value, but I'd rather get the coreml data frame working first.  I think it would be more MVP like to do that first.
 [3:03 PM, 5/26/2020] Scott: I also did the SMA in a TDD fashion so I can count on it working.
 [3:10 PM, 5/26/2020] Scott: So why was the 740 line drawn? It seems like the only time it was used was 4/20.
 [3:12 PM, 5/26/2020] Scott: *There was a reversal at 4/20
 [3:24 PM, 5/26/2020] Sean Taylor: Strong line from February and March
 [3:34 PM, 5/26/2020] Scott: I thought we discard lines as we exist their time frames.  Are exceptions made for static(flat) lines and or lines with a significant number of confirmations?
 [3:35 PM, 5/26/2020] Sean Taylor: Significant confirmations
 [3:36 PM, 5/26/2020] Sean Taylor: No need to code the exceptions
 [3:37 PM, 5/26/2020] Scott: If you value them in your trades I should probably code these exceptions.  I don't think its going to be in my first MVPs. What makes a confirmation more or less significant than another confirmation?
 [3:38 PM, 5/26/2020] Sean Taylor: Frequency
 [3:38 PM, 5/26/2020] Scott: okay
 [3:38 PM, 5/26/2020] Scott: got it
 [3:38 PM, 5/26/2020] Sean Taylor: Which is stronger.

 A lime that acts as a support 46 times over 8 months or a line that acts as support 2 times over 8 months?
 [3:38 PM, 5/26/2020] Sean Taylor: Line*
 [3:39 PM, 5/26/2020] Scott: Well assuming they are spread out equally, then 46 times
 [3:39 PM, 5/26/2020] Scott: right? or regardless of how they are spread out?
 [3:40 PM, 5/26/2020] Sean Taylor: Doesn't matter how they're spread out unless they are grouped around something you have decided to specifically look for
 [3:40 PM, 5/26/2020] Scott: For example, if the 46 times only happened the first day of the 8 months, and the 2 times for the other line happened on the last day of the 8 months would we value the 2 times more?
 [3:40 PM, 5/26/2020] Scott: *2 times line
 [3:41 PM, 5/26/2020] Scott: * 2 confirmation line
 [3:41 PM, 5/26/2020] Sean Taylor: No
 [3:41 PM, 5/26/2020] Scott: ah
 [3:44 PM, 5/26/2020] Scott: What if instead of 46 it were 3 times confirmed on the first day of the last 8 months for line A vs 2 times confirmed yesterday for line B? Would you value line A or B more?
 [3:45 PM, 5/26/2020] Sean Taylor: Am I trading in the immediate short term,  or long term enough that the 8 months is still revelant
 [3:48 PM, 5/26/2020] Scott: What is the answer for both.
 [3:49 PM, 5/26/2020] Sean Taylor: What do you think the answer is
 [3:52 PM, 5/26/2020] Sean Taylor: When you're driving, are you concerned about maneuvering offensively/defensively around the cars immediately adjacent to you, (up to the limit of your perception), or the cars 8 miles up/down the road?

 Unless a specific reference event (an accident / unusual traffic, vehicles changing lanes en mas, etc) has happened, you're likely not too concerned about the cars 8 miles ahead/behind.
 [3:53 PM, 5/26/2020] Scott: short term means only would value the recent one more even though it has fewer confirmations, longer term would value the one with more confirmations.  You didn't ask me that for the 46 time question though which I took to mean that even if I'm trading in the short term, 46 is so many confirmations, it is useful for short term trading.  I'd like to know what the turning point is for when the number of confirmations outweighs its age, and when it doesn't.  It might be the kind of thing I can figure out with models, but it will probably be tricky.
 [3:57 PM, 5/26/2020] Sean Taylor: As long as the line is still visible, and reasonably within or adjacent to the current time frame and price range you're working in.
 */
