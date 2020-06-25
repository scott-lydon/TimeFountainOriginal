//
//  NotesConvoWithSean.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


/*
--Scott: Woa, you’re only doing manual static supports and resistances these days? No more dynamic ones?  And thank you
--Sean Taylor: I modified them to be price lines so you can see the act price they are sitting at
-- Scott: I’m coming up empty handed for act price in investopedia.  Are you saying actual price?
-- Sean Taylor: ....yes
--Scott: I thought we manually drew resistance and support as/for price lines prior and they were mostly non flat lines.  Ah well... I’m definitely not getting something.
-- Sean Taylor: The direction / flatness of support resistance lines is completely dependent on the underlying equity and it's price movement. Also, I've always used price-lines on longer time frames as the first set of support / resistance (as long as the stock isn't gone parabolic (completely vertical or 90°, etc)

   The more dynamic ones tend to be intra-day lines, such as lines you made during the 5 Minute time frame which are quickly discarded as it exits that time period
 -- Scott: Why wasn’t this a support though?  Oohhh so the duration of a line should not exceed the time frame being looked at? A 5 minute time frame should generally not have 6 minute manual lines?  Gotcha
 -- Sean Taylor: You said recent, I have only been trading it since it's been in the $8.25 - $9 price range, which is what the lines I have represent.You can draw a vertical support line there, but it is irrelevant to the current price movement of the equity, and just adds unnessary clutter that (may or may not) confuse your analysis
--Scott: And to be clear, the line is irrelevant because it crosses the price line at around 4/24
--Sean Taylor: If my memory is correct, the time frames and variable support / resistance has always confused the fuck out of you
--Scott: Yes
-- Sean Taylor: That, plus it is no longer trading in a vertical stair-step pattern, it's now trading a horizontal pattern
-- Scott: That’s because I’m not comfortable with it until I feel like I can represent it mathematically and efficiently in code. I was having trouble with both.  So in summary  There are 4 ways they are terminated then: they cross over the price line, their length reaches the current time frame (does this mean span across dates or actual length?), they exceed the current price range so that it’s unlikely to return, and now adding to the list is when the pattern of manual lines changes?  Any others?  Ways for the lines to terminate?  Length reaches the current time frame means I can model it efficiently in code.  Phew 😌
-- Sean Taylor: >Their length reaches the current time frame It's more about the time frame they were made in is inconsequential to the time frame you're working on.
Example - Lines Drawn on a 1 Minute Chart, while you're working on a 6 Month Chart.
 >Span across dates or actual length
 Moreso the dates, but the general idea is to 'elimiate' any extra info that does not benefit your IMMEDIATE observation
--Scott: Let me rephrase that line span Statement.  I took this to mean, when the line becomes 6 minutes long in the 5 minute time frame, discard it.  Is that correct?  Oh. Lines drawn on one charts time frame don’t apply to a chart for a different time frame. I got that.  And when the line exits the frame left, discard it.  Got it right?
--Sean Taylor: For coding purposes, that works
--Scott: Immediate is defined as within the current view?
--Sean Taylor: View / Trade Context
--Scott: Lines are weighted more heavily based on how recently they began, and number of confirmations.
--Scott: ...or is it not how recently they began, as much as how recently they were confirmed?
--Sean Taylor: Equity stops breaks the support : resistance pattern you setup.  Confirmation
--Scott: Sorry not understanding. Cool
-- Sean Taylor: The issue with trading is a lot of things are true, but other things are more true depending on context -- in this instance Confirmation is more true than how recent they started. Sean Taylor: If you setup a manual support and resistance, and the stock stops following that pattern
--Scott: Right, machine learning can take care of the relative weight for me, but knowing it makes a difference I can provide those as independent variables. This is difficult to express mathematically.  Well unless you only mean in the ways we’ve already talked about, for example the price crosses right through the manual line. Scott: What are all the ways price can stop following the pattern of a manual line?
--Sean Taylor: Really?

 Support  <-> Resistance - Price Range $(1-5)
 Current Stock Price ($10)
 Stock is no longer trading between $1-5, previous range deleted. No clue how to answer that other than what you already know, which is the price action being outside the price range setup by your support/resistance
--Scott: Well you’ve mentioned another way: manual lines becoming distinctly more static than dynamic. Not sure where I last updated.  I have an array of prices, and I've created the algorithm to convert the prices to sma. I could convert the sma to a categorical value, but I'd rather get the coreml data frame working first.  I think it would be more MVP like to do that first.  I also did the SMA in a TDD fashion so I can count on it working.  So why was the 740 line drawn? It seems like the only time it was used was 4/20.  *There was a reversal at 4/20
-- Sean Taylor: Strong line from February and March
--Scott: I thought we discard lines as we exist their time frames.  Are exceptions made for static(flat) lines and or lines with a significant number of confirmations?
--Sean Taylor: Significant confirmations.  No need to code the exceptions
-- If you value them in your trades I should probably code these exceptions.  I don't think its going to be in my first MVPs. What makes a confirmation more or less significant than another confirmation?
--Sean Taylor: Frequency
--Scott: okay. Scott: got it
--Sean Taylor: Which is stronger.

 A lime that acts as a support 46 times over 8 months or a line that acts as support 2 times over 8 months?  Line*
-- Scott: Well assuming they are spread out equally, then 46 times. right? or regardless of how they are spread out?
-- Sean Taylor: Doesn't matter how they're spread out unless they are grouped around something you have decided to specifically look for
-- Scott: For example, if the 46 times only happened the first day of the 8 months, and the 2 times for the other line happened on the last day of the 8 months would we value the 2 times more?  *2 times line * 2 confirmation line
 --Sean Taylor: No
--Scott: ah.  What if instead of 46 it were 3 times confirmed on the first day of the last 8 months for line A vs 2 times confirmed yesterday for line B? Would you value line A or B more?
-- Sean Taylor: Am I trading in the immediate short term,  or long term enough that the 8 months is still revelant
--Scott: What is the answer for both.
--Sean Taylor: What do you think the answer is.  When you're driving, are you concerned about maneuvering offensively/defensively around the cars immediately adjacent to you, (up to the limit of your perception), or the cars 8 miles up/down the road?
 Unless a specific reference event (an accident / unusual traffic, vehicles changing lanes en mas, etc) has happened, you're likely not too concerned about the cars 8 miles ahead/behind.
-- Scott: short term means only would value the recent one more even though it has fewer confirmations, longer term would value the one with more confirmations.  You didn't ask me that for the 46 time question though which I took to mean that even if I'm trading in the short term, 46 is so many confirmations, it is useful for short term trading.  I'd like to know what the turning point is for when the number of confirmations outweighs its age, and when it doesn't.  It might be the kind of thing I can figure out with models, but it will probably be tricky.
--Sean Taylor: As long as the line is still visible, and reasonably within or adjacent to the current time frame and price range you're working in.
 */
