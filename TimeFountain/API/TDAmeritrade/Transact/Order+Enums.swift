//
//  Order+Enums.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum SpecialInstruction: String, Codable {
    /// a directive used on a buy or sell order that instructs the broker to fill the order completely or not at all
    case ALL_OR_NONE
    ///a type of order with a specified price that does not get adjusted when the underlying security pays a cash dividend
    case DO_NOT_REDUCE
    /// Both a directive used on a buy or sell order that instructs the broker to fill the order completely or not at all AND a type of order with a specified price that does not get adjusted when the underlying security pays a cash dividend
    case ALL_OR_NONE_DO_NOT_REDUCE
}

///An order is an investor's instructions to a broker or brokerage firm to purchase or sell a security on the investor's behalf. Orders are typically placed over the phone or online through a trading platform. Orders fall into different available types which allow investors to place restrictions on their orders affecting the price and time at which the order can be executed. These order instructions will affect the investor's profit or loss on the transaction and, in some cases, whether the order is executed at all.
enum OrderType: String, Codable {
    /// a request by an investor to buy or sell a security at the best available price in the current market
    case MARKET
    ///  order to purchase or sell a security at a specified price or better
    case LIMIT
    /// an option strategy involving the simultaneous buying and selling of options of the same class with different prices requiring a net outflow of cash
    case NET_DEBIT
    ///a conditional trade over a set timeframe that combines the features of stop with those of a limit order and is used to mitigate risk. It is related to other order types, including limit orders (an order to either buy or sell a specified number of shares at a given price, or better) and stop-on-quote orders (an order to either buy or sell a security after its price has surpassed a specified point).
    case STOP_LIMIT
    /// A stop order is an order to buy or sell a security when its price moves past a particular point, ensuring a higher probability of achieving a predetermined entry or exit price, limiting the investor's loss or locking in a profit. Once the price crosses the predefined entry/exit point, the stop order becomes a market order.
    case STOP
    /// A trailing stop is a modification of a typical stop order that can be set at a defined percentage or dollar amount away from a security's current market price. For a long position, an investor places a trailing stop loss below the current market price. For a short position, an investor places the trailing stop above the current market price.
    ///A trailing stop is designed to protect gains by enabling a trade to remain open and continue to profit as long as the price is moving in the investor’s favor. The order closes the trade if the price changes direction by a specified percentage or dollar amount.
    ///A trailing stop is typically placed at the same time the initial trade is placed, although it may be also be placed after the trade.
    case TRAILING_STOP
    ///A market-on-close (MOC) order is a non-limit market order, which traders execute as near to the closing price as they can—either exactly at, or slightly after the market close. The purpose of a MOC order is to get the last available price of that trading day. MOC orders are not available in all markets or from all brokers.
    ///On the New York Stock Exchange (NYSE), for example, traders must submit a MOC order by 3:45 p.m. EST, and on the Nasdaq, they must submit a MOC order by 3:50 p.m. EST, as both exchanges close at 4:00 p.m. EST. After those times, neither exchange allows traders to modify or cancel MOC orders.
    case MARKET_ON_CLOSE
    ///Exercise means to put into effect the right to buy or sell the underlying financial instrument specified in an options contract. In options trading, the holder of an option has the right, but not the obligation, to buy or sell the option's underlying security at a specified price on or before a specified date in the future.
    ///If the owner of an option decides to buy or sell the underlying instrument—instead of allowing the contract to expire, worthless or closing out the position—they will be "exercising the option," or making use of the right, or privilege that is available in the contract.
    ///The decision to exercise an option isn't always a clear-cut one. There are several factors that need to be considered before making the decision; however, more often than not, it's safer to hold or sell the option instead.
    case EXERCISE
    ///Exercise means to put into effect the right to buy or sell the underlying financial instrument specified in an options contract. In options trading, the holder of an option has the right, but not the obligation, to buy or sell the option's underlying security at a specified price on or before a specified date in the future.
    ///If the owner of an option decides to buy or sell the underlying instrument—instead of allowing the contract to expire, worthless or closing out the position—they will be "exercising the option," or making use of the right, or privilege that is available in the contract.
    ///The decision to exercise an option isn't always a clear-cut one. There are several factors that need to be considered before making the decision; however, more often than not, it's safer to hold or sell the option instead.
    case TRAILING_STOP_LIMIT
    ///When trading or investing in options, there are several option spread strategies that one could employ—a spread being the purchase and sale of different options on the same underlying as a package.
    ///While we can classify spreads in various ways, one common dimension is to ask whether or not the strategy is a credit spread or a debit spread. Credit spreads, or net credit spreads, are spread strategies that involve net receipts of premiums, whereas debit spreads involve net payments of premiums.
    case NET_CREDIT
    /// TODO
    case NET_ZERO
}

///A trading session is a period of time that matches the primary daytime trading hours for a given locale. This phrase will refer to different hours depending on the markets and locations being discussed. Generally a single day of business in the local financial market, from that market’s opening bell to its closing bell, is the trading session that the individual investor or trader will reference. The markets for forex, futures, stocks and bonds all have different characteristics that define their respective trading sessions for a given day, and the primary trading hours naturally differ from one country to another dependent on time zones.
enum Session: String, Codable {
    ///
    case NORMAL
    ///
    case AM
    ///
    case PM
    ///
    case SEAMLESS
}

///
enum Duration: String, Codable {
    ///Good ’til canceled (GTC) describes a type of order that an investor may place to buy or sell a security that remains active until either the order is filled or the investor cancels it. Brokerages will typically limit the maximum time you can keep a GTC order open (active) to 90 days.
    case GOOD_TILL_CANCEL
    /// A day order is a stipulation placed on an order to a broker to execute a trade at a specific price that expires at the end of the trading day if it is not completed. A day order can be a limit order to buy or sell a security, but its duration is limited to the remainder of that trading day.
    case DAY
    /// Fill or kill (FOK) is a conditional type of time-in-force order used in securities trading that instructs a brokerage to execute a transaction immediately and completely or not at all. This type of order is most often used by active traders and is usually for a large quantity of stock. The order must be filled in its entirety or else canceled (killed).
    ///A FOK is essentially an all-or-none (AON) and immediate-or-cancel order (IOC) combined.
    case FILL_OR_KILL
}

enum OrderStrategyType: String, Codable {
    case SINGLE
    ///A trade trigger is any event that meets the criteria to initiate an automated securities transaction that does not require additional trader input. A trade trigger is usually a market condition, such as a rise or fall in the price of an index or security, which triggers a sequence of trades. Trade triggers are used to automate certain types of trades, such as the selling of shares when the price reaches a certain level.

    ///Understanding Trade Trigger
    ///Trade triggers help traders automate their entry and exit strategies. Often, trade triggers are placed using contingent orders involving both a primary and secondary order. When the first order executes, the second order is triggered automatically and becomes active for execution depending on any further conditions. Trade triggers may also be used to place individual trades based on the price or external factors. For example, traders can straddle the current market price by placing an one-cancels-other (OCO) order where the execution of one side will immediately cancel the other, thus allowing the trader entry to the market, hopefully in the direction with momentum.
    case TRIGGER
    ///What is a One-Cancels-the-Other Order - (OCO)
    ///A one-cancels-the-other order (OCO) is a pair of conditional orders stipulating that if one order executes, then the other order is automatically canceled. An OCO order often combines a stop order with a limit order on an automated trading platform. When either the stop or limit price is reached and the order executed, the other order automatically gets canceled. Experienced traders use OCO orders to mitigate risk and to enter the market.
    ///OCO orders may be contrasted with order-sends-order (OSO) conditions that trigger, rather than cancel, a second order.
    case OCO
}

enum Instruction: String, Codable {
    ///A buy order is an instruction to a broker to buy a security. There are six types of security orders.
    case Buy
    ///What Is Buy to Open?
    ///"Buy to open" is a term used by brokerages to represent the establishment of a new (opening) long call or put position in options. If a new options investor wants to buy a call or put, that investor should buy to open. A buy-to-open order indicates to market participants that the trader is establishing a new position rather than closing out an existing position. The sell to close order is used to exit a position taken with a buy-to-open order.
    ///Establishing a new short position is called sell to open, which would be closed out with a buy-to-close order. If a new options investor wants to sell a call or a put, that investor should sell to open.
    case BUY_TO_OPEN
    ///What is Sell To Open?
    ///Sell to open is a phrase used by many brokerages to represent the opening of a short position in an option transaction.
    ///
    ///Basics of Sell To Open
    ///Sell to open refers to instances in which an option investor initiates, or opens, an option trade by selling or establishing a short position in an option. This enables the option seller to receive the premium paid by the buyer on the opposite side of the transaction. Options are a type of derivative security.
    ///
    /// Selling to open allows an investor to be eligible for a premium as the investor is selling the opportunity associated with the option to another investor within the market. This puts the selling investor in the short position on the call or put, while the second investor takes the long position, or the purchase of a security with the hope that it will increase in value. The investor shorting the position is hoping the underlying asset or equity does not move beyond the strike price, as this allows her to keep the stocks and benefit from the long investor's premium.
    ///
    ///Put and Call Options
    ///Sell to open can be established on a put option or a call option or any combination of puts and calls depending on the trade bias, whether bullish, bearish or neutral, that the option trader or investor wants to implement. With a sell to open, the investor writes a call or put in hopes of collecting a premium. The call or put may be covered or naked depending on whether the investor writing the call is currently in possession of the securities in question.
    case SELL_TO_OPEN
    /// Capitalized version of the Buy
    case BUY
    /// The term sell refers to the process of liquidating an asset in exchange for cash. Liquidation is a term used to describe the conversion of non-liquid assets, such as real property, stocks, or bonds, into a liquid property, such as cash, through an exchange on the open market. For example, your house is a non-liquid asset, but when you sell it, you convert it into a liquid asset in the form of cash. A sale performed by a government may be referred to as a disinvestment.
    ///
    ///In investing, especially with options, sell generally refers to the act of exiting a long position in an asset or security. In investment research, sell refers to an analyst's recommendation to close out a long position in a stock because of the risk of a price decline. Most people invest in stocks to grow their assets—they hope that the stocks they invest in will grow in value.
    case SELL
    ///What Is Buy to Cover?
    ///Buy to cover refers to a buy order made on a stock or other listed security to close out an existing short position. A short sale involves selling shares of a company that an investor does not own, as the shares are borrowed from a broker but need to be repaid at some point.
    ///
    ///Understanding Buy to Cover
    ///A buy to cover order of purchasing an equal number of shares to those borrowed, "covers" the short sale and allows the shares to be returned to the original lender, typically the investor's own broker-dealer, who may have had to borrow the shares from a third party.
    ///
    ///A short seller bets on a stock price going down and seeks to buy the shares back at a lower price than the original short sale price. The short seller must pay each margin call and repurchase the shares to return them to the lender.
    ///
    ///Specifically, when the stock begins to rise above the price at which the shares were shorted, the short seller’s broker may require that the seller execute a buy to cover order as part of a margin call. To prevent this from happening, the short seller should always keep enough buying power in their brokerage account to make any needed "buy to cover" trades before the market price of the stock triggers a margin call.
    case BUY_TO_COVER
    ///What Is Buy To Close?
    ///'Buy to close' refers to terminology that traders, primarily option traders, use to exit an existing short position. In market parlance, it is understood to mean that the trader wants to close out an existing option trade. Technically speaking, it means that the trader wants to buy an asset to offset, or close, a short position in that same asset.
    ///
    ///Understanding Buy To Close
    ///There is a nuanced difference between a 'buy to close' option and a buy to cover purchase. The former refers to mainly options, and sometimes futures, while the latter typically refers to stocks only. The end result is the same in both cases. Essentially, it is the buying back of an asset initially sold short. The net result is no exposure to the asset.
    ///
    ///The term 'buy to close' is used when a trader is net short an option position and wants to exit that open position. In other words, they already have an open position, by way of writing an option, for which they have received a net credit, and now seek to close that position. Traders normally use a 'sell to open' order to establish this open short option position which the 'buy to close' order offsets.
    ///
    ///In the case of stocks, selling assets short involves borrowing the asset from another entity. For futures and options, the process involves writing a contract to sell it to another buyer. In both cases, the trader hopes the price of the underlying stock moves lower to generate a profit at the trade's closing.
    ///
    ///For stocks, and barring bankruptcy in the underlying company, the only way to exit the trade is to buy shares back and return them to the entity from whom they were borrowed. In a futures transaction, the trade ends at maturity or when the seller buys back the position in the open market to cover their short position. For an options position, the trade ends at maturity, when the seller buys back the position in the open market, or when the buyer of the option exercises it. In all cases, if the purchase or cover price is less than the selling or shorting price, there is a profit for the seller.
    case BUY_TO_CLOSE
    ///What Is Short Selling?
    ///Short selling is an investment or trading strategy that speculates on the decline in a stock or other securities price. It is an advanced strategy that should only be undertaken by experienced traders and investors.
    ///
    ///Traders may use short selling as speculation, and investors or portfolio managers may use it as a hedge against the downside risk of a long position in the same security or a related one. Speculation carries the possibility of substantial risk and is an advanced trading method. Hedging is a more common transaction involving placing an offsetting position to reduce risk exposure.
    ///
    ///In short selling, a position is opened by borrowing shares of a stock or other asset that the investor believes will decrease in value by a set future date—the expiration date. The investor then sells these borrowed shares to buyers willing to pay the market price. Before the borrowed shares must be returned, the trader is betting that the price will continue to decline and they can purchase them at a lower cost. The risk of loss on a short sale is theoretically unlimited since the price of any asset can climb to infinity.
    case SELL_SHORT
    ///What is Sell to Close?
    ///Sell to close is an options trading order that is used to exit a trade in which the trader already owns the options contract and must sell the contract to close the position. Traders "sell to close" call options contracts they own when they no longer want to hold a long bullish position on the underlying asset. They "sell to close" put options contracts they own when they no longer want to hold a long bearish position on the underlying asset.
    ///
    ///Understanding Sell to Close
    ///Sell to close is simply the action of closing out the position by selling the contract. In options trading, both short and long positions are taken through contracts which are purchased. Once a contract is owned by a trader, it can only be dealt with three ways. One, the option is out of the money and expires worthless. Two, the option is in the money and can be exercised to trade for the underlying or settle for the difference. Three, the option can be sold to close the position. A sell to close order may be made with the option in the money, out of the money or even at the money.
    case SELL_TO_CLOSE
    ///TODO
    case EXCHANGE
    
    init?(_ direction: BuyMarketStock.Prediction.Direction) {
        switch direction {
        case .goingUp:
            self = .BUY
        case .goingDown:
            self = .SELL
        case .level:
            return nil
        }
    }
}

///What Is an Asset Class?
///An asset class is a grouping of investments that exhibit similar characteristics and are subject to the same laws and regulations. Asset classes are made up of instruments which often behave similarly to one another in the marketplace. Historically, the three main asset classes have been equities (stocks), fixed income (bonds), and cash equivalent or money market instruments.1﻿ Currently, most investment professionals include real estate, commodities, futures, other financial derivatives, and even cryptocurrencies to the asset class mix. Investment assets include both tangible and intangible instruments which investors buy and sell for the purposes of generating additional income on either a short- or a long-term basis.
enum AssetType: String, Codable {
    ///What Is Equity?
    ///Equity is typically referred to as shareholder equity (also known as shareholders' equity), or owners equity (for privately held companies), which represents the amount of money that would be returned to a company’s shareholders if all of the assets were liquidated and all of the company's debt was paid off.
    ///
    ///Equity is found on a company's balance sheet and is one of the most common financial metrics employed by analysts to assess the financial health of a company. Shareholder equity can also represent the book value of a company. Equity can sometimes be offered as payment-in-kind.
    ///
    ///There are various types of equity that extend beyond a corporation’s balance sheet. In this article, we’ll explore the different types of equity including how investors can calculate a corporation’s equity or net worth.
    case EQUITY
    ///What Is an Option?
    ///Options are financial instruments that are derivatives based on the value of underlying securities such as stocks. An options contract offers the buyer the opportunity to buy or sell—depending on the type of contract they hold—the underlying asset. Unlike futures, the holder is not required to buy or sell the asset if they choose not to.
    ///
    ///Call options allow the holder to buy the asset at a stated price within a specific timeframe.
    ///Put options allow the holder to sell the asset at a stated price within a specific timeframe.
    ///
    ///Each option contract will have a specific expiration date by which the holder must exercise their option. The stated price on an option is known as the strike price. Options are typically bought and sold through online or retail brokers.
    case OPTION
    ///What Is an Index?
    ///An index is a method to track the performance of some group of assets in a standardized way. Indexes typically measure the performance of a basket of securities intended to replicate a certain area of the market. These may be broad-based to capture the entire market such as the Standard & Poor's 500 (S&P 500) or Dow Jones Industrial Average (DJIA), or more specialized such as indexes that track a particular industry or segment. Indexes are also created to measure other financial or economic data such as interest rates, inflation, or manufacturing output.
    ///
    ///Often, indices serve as benchmarks against which to evaluate the performance of a portfolio's returns. One popular investment strategy, known as indexing, is to try to replicate such an index in a passive manner rather than trying to outperform it.
    case INDEX
    ///What Is a Mutual Fund?
    ///A mutual fund is a type of financial vehicle made up of a pool of money collected from many investors to invest in securities like stocks, bonds, money market instruments, and other assets. Mutual funds are operated by professional money managers, who allocate the fund's assets and attempt to produce capital gains or income for the fund's investors. A mutual fund's portfolio is structured and maintained to match the investment objectives stated in its prospectus.
    ///
    ///Mutual funds give small or individual investors access to professionally managed portfolios of equities, bonds, and other securities. Each shareholder, therefore, participates proportionally in the gains or losses of the fund. Mutual funds invest in a vast number of securities, and performance is usually tracked as the change in the total market cap of the fund—derived by the aggregating performance of the underlying investments.
    case MUTUAL_FUND
    ///What Are Cash Equivalents?
    ///Cash equivalents are investments securities that are meant for short-term investing; they have high credit quality and are highly liquid.
    ///
    ///Cash equivalents, also known as "cash and equivalents," are one of the three main asset classes in financial investing, along with stocks and bonds. These securities have a low-risk, low-return profile and include U.S. government Treasury bills, bank certificates of deposit, bankers' acceptances, corporate commercial paper, and other money market instruments.
    case CASH_EQUIVALENT
///    What Is Fixed Income?
///    Fixed income broadly refers to those types of investment security that pay investors fixed interest or dividend payments until its maturity date. At maturity, investors are repaid the principal amount they had invested. Government and corporate bonds are the most common types of fixed-income products. Unlike equities that may pay no cash flows to investors, or variable-income securities, where can payments change based on some underlying measure—such as short-term interest rates—the payments of a fixed-income security are known in advance.
///
///    In addition to purchasing fixed income securities directly, there are several fixed-income exchange-traded funds (ETFs) and mutual funds available.
    case FIXED_INCOME
///    What Is Currency?
///    Currency is a medium of exchange for goods and services. In short, it's money, in the form of paper or coins, usually issued by a government and generally accepted at its face value as a method of payment.
///
///
///    Currency is the primary medium of exchange in the modern world, having long ago replaced bartering as a means of trading goods and services.
///
///
///    In the 21st century, a new form of currency has entered the vocabulary, the virtual currency. Virtual currencies such as bitcoins have no physical existence or government backing and are traded and stored in electronic form.
    case CURRENCY
}


/// Complex leveraged derivatives
enum ComplexOrderStrategyType: String, Codable {
    case NONE
    case CUSTOM
///    1. Covered Call
///    With calls, one strategy is simply to buy a naked call option. You can also structure a basic covered call or buy-write. This is a very popular strategy because it generates income and reduces some risk of being long on the stock alone. The trade-off is that you must be willing to sell your shares at a set price– the short strike price. To execute the strategy, you purchase the underlying stock as you normally would, and simultaneously write–or sell–a call option on those same shares.
///
///
///    For example, suppose an investor is using a call option on a stock that represents 100 shares of stock per call option. For every 100 shares of stock that the investor buys, they would simultaneously sell one call option against it. This strategy is referred to as a covered call because, in the event that a stock price increases rapidly, this investor's short call is covered by the long stock position.
    case COVERED
///    Basic Features of Vertical Spreads
///    Each vertical spread involves buying and writing puts or calls at different strike prices. Each spread has two legs, where one leg is buying an option, and the other leg is writing an option.
///
///
///    This can result in the option position (containing two legs), giving the trader a credit or debit. A debit spread is when putting on the trade costs money. For example, one option costs $300, but the trader receives $100 from the other position. The net premium cost is a $200 debit.
///
///
///    If the situation were reversed, and the trader receives $300 for putting on an option trade, and the other option costs $100, the two option contracts combine for a net premium credit of $200.
///
///    Types of Vertical Spreads
///    Here is how each spread is executed:
///
///
///    A bull call spread is purchasing a call option and simultaneously selling another call option (on the same underlying asset) with the same expiration date but a higher strike price. Since this is a debit spread, the maximum loss is restricted to the net premium paid for the position, while the maximum profit is equal to the difference in the strike prices of the calls less the net premium paid to put on the position.
///
///    A bear call spread is selling a call option, and simultaneously purchasing another call option with the same expiration date but at a higher strike price. Since this is a credit spread, the maximum gain is restricted to the net premium received for the position, while the maximum loss is equal to the difference in the strike prices of the calls less the net premium received.
///
///    A bull put spread is writing a put option, and simultaneously purchasing another put option with the same expiration date but a lower strike price. Since this is a credit spread, the maximum gain is restricted to the net premium received for the position, while the maximum loss is equal to the difference in the strike prices of the puts less the net premium received.
///
///    A bear put spread is purchasing a put option, and simultaneously selling another put option with the same expiration date but a lower strike price. Since this is a debit spread, the maximum loss is restricted to the net premium paid for the position, while the maximum profit is equal to the difference in the strike prices of the puts less the net premium paid to put on the position.
    case VERTICAL
///    What Is a Backspread?
///    A backspread is s a type of option trading plan in which a trader buys more call or put options than they sell. The backspread trading plan can focus on either call options or put options on a specific underlying investment. A backspread is a complex trading strategy with high risks that is typically only used by advanced traders.
///
///
///    How a Backspread Works
///    A backspread will generally be constructed as either a call backspread or a put backspread. A backspread can also be considered a type of ratio strategy since it will make unequal investments in two types of options. A backspread is the opposite of a frontspread in which a trader sells more options than they buy.
///
///
///    Ratio Spread
///    The term ratio spread helps a trader to illustrate and understand the ratio of a two-legged trading plan. A standard spread strategy occurs when an investor makes equal investment in both legs of the trading plan with a theoretical ratio of 1:1. Any spread strategy that does not invest equally in two legs of a trading plan is considered a ratio strategy with the ratio calculated based on the weightings of the investments.
    case BACK_RATIO
///    What is a Calendar Spread
///    A calendar spread is an options or futures spread established by simultaneously entering a long and short position on the same underlying asset at the same strike price but with different delivery months. It is sometimes referred to as an inter-delivery, intra-market, time, or horizontal spread.
///
///
///    The typical options trade comprises the sale of an option (call or put) with a near-term expiration date, and the simultaneous purchase of an option (call or put) with a longer-term expiration. Both options are of the same type and use the same strike price.
///
///
///    Sell near-term put/call
///    Buy longer-term put/call
///    Preferable but not required that implied volatility is low
///    The purpose of the trade is to profit from the passage of time and/or an increase in implied volatility in a directionally neutral strategy.
    case CALENDAR
///    What Is a Diagonal Spread?
///    A diagonal spread is an options strategy established by simultaneously entering into a long and short position in two options of the same type (two call options or two put options) but with different strike prices and different expiration dates. Typically these structures are on a 1 x 1 ratio.
///
///    This strategy can lean bullish or bearish, depending on the structure of the options.
///
///    How a Diagonal Spread Works
///    This strategy is called a diagonal spread because it combines a horizontal spread, also called a time spread or calendar spread, which represents the difference in expiration dates, with a vertical spread, or price spread, which represents the difference in strike prices.
///
///    The names horizontal, vertical and diagonal spreads refer to the positions of each option on an options grid. Options are listed in a matrix of strike prices and expiration dates. Therefore, options used in vertical spread strategies are all listed in the same vertical column with the same expiration dates. Options in a horizontal spread strategy use the same strike prices, but are of different expiration dates. The options are therefore arranged horizontally on a calendar.
///
///    Options used in diagonal spreads have differing strike prices and expiration days, so the options are arranged diagonally on the quote grid.
    case DIAGONAL
//    What Is a Straddle?
//    A straddle is a neutral options strategy that involves simultaneously buying both a put option and a call option for the underlying security with the same strike price and the same expiration date.
//
//
//    A trader will profit from a long straddle when the price of the security rises or falls from the strike price by an amount more than the total cost of the premium paid. Profit potential is virtually unlimited, so long as the price of the underlying security moves very sharply.
    case STRADDLE
//    What Is a Strangle?
//    A strangle is an options strategy where the investor holds a position in both a call and a put option with different strike prices, but with the same expiration date and underlying asset. A strangle is a good strategy if you think the underlying security will experience a large price movement in the near future but are unsure of the direction. However, it is profitable mainly if the asset does swing sharply in price.
//
//
//    A strangle is similar to a straddle, but uses options at different strike prices, while a straddle uses a call and put at the same strike price.
    case STRANGLE
//    What is a Collar?
//    A collar, commonly known as a hedge wrapper, is an options strategy implemented to protect against large losses, but it also limits large gains. An investor creates a collar position by purchasing an out-of-the-money put option while simultaneously writing an out-of-the-money call option. The put protects the trader in case the price of the stock drops. Writing the call produces income (which ideally should offset the cost of buying the put) and allows the trader to profit on the stock up to the strike price of the call, but not higher.
    case COLLAR_SYNTHETIC
///    What Is a Butterfly Spread?
///    A butterfly spread is an options strategy combining bull and bear spreads, with a fixed risk and capped profit. These spreads, involving either four calls or four puts are intended as a market-neutral strategy and pay off the most if the underlying does not move prior to option expiration.
    case BUTTERFLY
///    What Is a Condor Spread?
///    A condor spread is a non-directional options strategy that limits both gains and losses while seeking to profit from either low or high volatility. There are two types of condor spreads. A long condor seeks to profit from low volatility and little to no movement in the underlying asset. A short condor seeks to profit from high volatility and a sizable move in the underlying asset in either direction.
///
///
///    Understanding Condor Spreads
///    The purpose of a condor strategy is to reduce risk, but that comes with reduced profit potential and the costs associated with trading several options legs. Condor spreads are similar to butterfly spreads because they profit from the same conditions in the underlying asset. The major difference is the maximum profit zone, or sweet spot, for a condor is much wider than that for a butterfly, although the trade-off is a lower profit potential. Both strategies use four options, either all calls or all puts.
///
///
///    As a combination strategy, a condor involves multiple options, with identical expiration dates, purchased and/or sold at the same time. For example, a long condor using calls is the same as running both an in-the-money long call, or bull call spread, and an out-of-the-money short call, or bear call spread. Unlike a long butterfly spread, the two sub-strategies have four strike prices, instead of three. Maximum profit is achieved when the short call spread expires worthless, while the underlying asset closes at or above the higher strike price in the long call spread.
    case CONDOR
///    What Is an Iron Condor?
///    An iron condor is an options strategy created with four options consisting of two puts (one long and one short) and two calls (one long and one short), and four strike prices, all with the same expiration date. The goal is to profit from low volatility in the underlying asset. In other words, the iron condor earns the maximum profit when the underlying asset closes between the middle strike prices at expiration.
///
///
///    The iron condor has a similar payoff as a regular condor spread, but uses both calls and puts instead of only calls or only puts. Both the condor and the iron condor are extensions of the butterfly spread and iron butterfly, respectively.
    case IRON_CONDOR
///    What is an Options Roll Up
///    Roll up refers to increasing the strike price of an option position by closing the initial contract and opening a new contract for the same underlying asset at a higher strike price.
///
///
///    A roll up on a call option is a bullish strategy. This is the opposite of a "roll down" in which an investor simultaneously closes one position and opens another with a lower strike price. The converse would be true for put options where a roll up would be a bearish strategy.
    case VERTICAL_ROLL
///    What is a Collar?
///    A collar, commonly known as a hedge wrapper, is an options strategy implemented to protect against large losses, but it also limits large gains. An investor creates a collar position by purchasing an out-of-the-money put option while simultaneously writing an out-of-the-money call option. The put protects the trader in case the price of the stock drops. Writing the call produces income (which ideally should offset the cost of buying the put) and allows the trader to profit on the stock up to the strike price of the call, but not higher.
    case COLLAR_WITH_STOCK
///    At the outset of this strategy, you’re simultaneously running a diagonal call spread and a diagonal put spread. Both of those strategies are time-decay plays. You’re taking advantage of the fact that the time value of the front-month options decay at a more accelerated rate than the back-month options
    case DOUBLE_DIAGONAL
///    The Modified Butterfly
///    The modified butterfly spread is different from the basic butterfly spread in several important ways:
///
///    Puts are traded to create a bullish trade and calls are traded to create a bearish trade.
///    The options are not traded in 1:2:1 fashion but rather in a ratio of 1:3:2.
///    Unlike a basic butterfly that has two breakeven prices and a range of profit potential, the modified butterfly has only one breakeven price, which is typically out-of-the-money. This creates a cushion for the trader.
///    One negative associated with the modified butterfly versus the standard butterfly: While the standard butterfly spread almost invariably involves a favorable reward-to-risk ratio, the modified butterfly spread almost invariably incurs a great dollar risk compared to the maximum profit potential. Of course, the one caveat here is that if a modified butterfly spread is entered properly, the underlying security would have to move a great distance in order to reach the area of maximum possible loss. This gives alert traders a lot of room to act before the worst-case scenario unfolds.
    case UNBALANCED_BUTTERFLY
///    A traditional condor is the simultaneous purchase of a vertical put (or call) spread and the sale of a further out-of-the-money put (or call) spread with the same expiration and contract quantities. These spreads are very similar to butterflies but have the vertical spreads further apart, and usually require more of a capital outlay.
///
///    An unbalanced condor is the simultaneous purchase of a vertical put (or call) spread and the sale of a further out-of-the-money put (or call) spread using more contracts. The extra vertical sales are designed to coordinate a balance because you are adding slightly more risk but also taking debit out of the trade.
    case UNBALANCED_CONDOR
///    Unbalanced iron condors are only slightly different than a regular (or balanced iron condor). These strategies are best used when you want to be slightly directional in your setup but also want the ability to profit if the stock remains range bound. To build these condors and create skew to one side you would just need to widen out your strikes on the other side of the trade. Take your time with understanding skew. For example, a stock is trading at $50 and you wanted to skew your strategy towards the bullish side you would widen out your strikes on the put side. Maybe instead of selling the $45/44 puts you sell the $45/40 puts. This creates more risk on the lower side of the trade therefore removing risk on the top side (bullish skew). You would do the opposite of the above to get bearish skew, widening out your call strikes.
    case UNBALANCED_IRON_CONDOR
    ///TODO
    case UNBALANCED_VERTICAL_ROLL
}

enum StopPriceLinkBasis: String, Codable {
    ///A bid is an offer made by an investor, trader, or dealer in an effort to buy a security, commodity, or currency. A bid stipulates the price the potential buyer is willing to pay, as well as the quantity he or she will purchase, for that proposed price.
    case BID
    ///Manual trading is a trading process that involves human decision-making for entering and exiting trades. This is in contrast to automatic or automated trading which employs programs that originate trades based on human instructional criteria.
    case MANUAL
    ///
    case BASE
    ///A trade trigger is usually a market condition, such as a rise or fall in the price of an index or security, which triggers a sequence of trades. Trade triggers are used to automate certain types of trades, such as the selling of shares when the price reaches a certain level
    case TRIGGER
    case LAST
///    What Is Ask?
///    The ask is the price a seller is willing to accept for a security, which is often referred to as the offer price. Along with the price, the ask quote might also stipulate the amount of the security available to be sold at the stated price. The bid is the price a buyer is willing to pay for a security, and the ask will always be higher than the bid.
    case ASK
///    What is a Bid-Ask Spread?
///    A bid-ask spread is the amount by which the ask price exceeds the bid price for an asset in the market. The bid-ask spread is essentially the difference between the highest price that a buyer is willing to pay for an asset and the lowest price that a seller is willing to accept. An individual looking to sell will receive the bid price while one looking to buy will pay the ask price.
    case ASK_BID
    
    case MARK
    case AVERAGE
}

enum StopPriceLinkType: String, Codable {
    case VALUE
    case PERCENT
    case TICK
}

enum RequestDestination: String, Codable {
///    Interbank Network for Electronic Transfer (INET) processed credit and debit card transactions between financial institutions (FIs). It handled the transferring of funds from cards bearing the MasterCard Inc. (MA) logo, prior to the introduction of Banknet.
    case INET
///    What is NYSE Arca?
///    NYSE Arca is an electronic securities exchange in the U.S. on which exchange-traded products (ETPs) and equities trade. The exchange specializes in ETP listings, which include exchange-traded funds (ETFs), exchange-traded notes (ETNs) and exchange-traded vehicles (ETVs). As well as placing typical orders, NYSE Arca allows investors and traders to participate in opening and closing auctions in ETFs and place mid-point orders that sit between the bid and ask price.
    case ECN_ARCA
///    What Is the Chicago Board Options Exchange (CBOE)?
///    Founded in 1973 as the Chicago Board Options Exchange, it is the world's largest options market with contracts focusing on individual equities, indexes, and interest rates. In 2010, the company converted to a publicly traded corporation and rebranded as Cboe Global Markets, Inc. (Cboe). Traders refer to the exchange as the CBOE ("see-bo"). Cboe is now the holding company and the exchange is a primary asset. Cboe is also the originator of the Volatility Index (VIX) which is the most widely used and recognized proxy for market volatility.
    case CBOE
///    What Is the American Stock Exchange (AMEX)?
///    The American Stock Exchange (AMEX) was once the third-largest stock exchange in the United States, as measured by trading volume. The exchange, at its height, handled about 10% of all securities traded in the U.S.
///
///
///    Today, the AMEX is known as the NYSE American. In 2008, NYSE Euronext acquired the AMEX. In the subsequent years, it also became known as NYSE Amex Equities and NYSE MKT.
    case AMEX
///    The Philadelphia Stock Exchange (PHLX), located in Philadelphia, Pennsylvania, was the first official U.S. securities exchange, formed in 1790. However, it currently focuses on equity, currency, and index options rather than stock trading.
    case PHLX
///    The International Securities Exchange (ISE) is an electronic options exchange that was launched in 2000. The exchange provides investors with greater liquidity and the ability to execute transactions at a much faster rate than the open-cry trading floor that has historically been the basis for options trading. In addition to being an options exchange, the ISE is also a publicly traded company. In 2008, ISE became a wholly-owned subsidiary of the communications company Direct Edge, and in 2016, ISE became a wholly-owned subsidiary of Nasdaq.
    case ISE
    ///The Boston Options Exchange (BOX) is a derivatives exchange that was established in 2002, and trading commenced in February 2004. The exchange started as a joint effort by the Montreal Exchange, Boston Stock Exchange, and Interactive Brokers Group to provide an alternative to existing options markets. Technical operations of the Boston Options Exchange (BOX) are handled by the TMX Group, which is now the parent company of the Montreal Exchange.
    case BOX
    ///The New York Stock Exchange (NYSE) is a stock exchange located in New York City that is the largest equities-based exchange in the world, based on the total market capitalization of its listed securities. Formerly run as a private organization, the NYSE became a public entity in 2005 following the acquisition of electronic trading exchange Archipelago. In 2007 a merger with Euronext, the largest stock exchange in Europe, led to the creation of NYSE Euronext, which was later acquired by Intercontinental Exchange, the current parent of the New York Stock Exchange.
    case NYSE
    ///Nasdaq is a global electronic marketplace for buying and selling securities. Nasdaq was created by the National Association of Securities Dealers (NASD) to enable investors to trade securities on a computerized, speedy and transparent system, and commenced operations on February 8, 1971. The term, “Nasdaq” is also used to refer to the Nasdaq Composite, an index of more than 3,000 stocks listed on the Nasdaq exchange that includes the world’s foremost technology and biotech giants such as Apple, Google, Microsoft, Oracle, Amazon, and Intel.
    case NASDAQ
    ///Bats Global Markets was a U.S.-based exchange that listed several different types of investments, including equities, options, and foreign exchange. It was founded in 2005 and was acquired by CBOE Holdings (CBOE) in 2017. Prior to being acquired, Bats Global Market was one of the largest U.S. exchanges and well known for its services to broker-dealers as well as retail and institutional investors.
    case BATS
    
    case C2
    
    case AUTO
}

enum StopType: String, Codable {
    case STANDARD
    ///A bid is an offer made by an investor, trader, or dealer in an effort to buy a security, commodity, or currency. A bid stipulates the price the potential buyer is willing to pay, as well as the quantity he or she will purchase, for that proposed price
    case BID
    ///The ask is the price a seller is willing to accept for a security, which is often referred to as the offer price. Along with the price, the ask quote might also stipulate the amount of the security available to be sold at the stated price. The bid is the price a buyer is willing to pay for a security, and the ask will always be higher than the bid.
    case ASK
    ///The last trading day is the final day that a futures contract, or other derivatives with an expiry date, may trade or be closed out before the delivery of the underlying asset or cash settlement must occur. At the end of the last trading day, the contract holder must be prepared to accept delivery of the commodity or settle in cash if the position is not closed. The same concept applies to options contracts. The last trading day is the final chance to close the position, otherwise the underlying will be delivered if applicable. If the option is worthless, then it does not need to be closed, it will simply expire.
    case LAST
    
    case MARK
}

enum PriceLinkBasis: String, Codable {
    case MANUAL
    case BASE
    case TRIGGER
    case LAST
    case BID
    case ASK
    case ASK_BID
    case MARK
    case AVERAGE
}

enum PriceLinkType: String, Codable {
    case VALUE
    case PERCENT
    case TICK
}

enum TaxLotMethod: String, Codable {
    ///First In, First Out, commonly known as FIFO, is an asset-management and valuation method in which assets produced or acquired first are sold, used, or disposed of first. For tax purposes, FIFO assumes that assets with the oldest costs are included in the income statement's cost of goods sold (COGS). The remaining inventory assets are matched to the assets that are most recently purchased or produced.
    case FIFO
///    Last in, first out (LIFO) is a method used to account for inventory that records the most recently produced items as sold first. Under LIFO, the cost of the most recent products purchased (or produced) are the first to be expensed as cost of goods sold (COGS)—which means the lower cost of older products will be reported as inventory.
///
///
///    Two alternative methods of inventory-costing include first in, first out (FIFO), where the oldest inventory items are recorded as sold first, and the average cost method, which takes the weighted average of all units available for sale during the accounting period and then uses that avera
    case LIFO
    
    case HIGH_COST
    
    case LOW_COST
    ///The average cost method assigns a cost to inventory items based on the total cost of goods purchased or produced in a period divided by the total number of items purchased or produced. The average cost method is also known as the weighted-average method
    case AVERAGE_COST
    
    case SPECIFIC_LOT
}

enum OrderLegType: String, Codable {
///    Equity is typically referred to as shareholder equity (also known as shareholders' equity), or owners equity (for privately held companies), which represents the amount of money that would be returned to a company’s shareholders if all of the assets were liquidated and all of the company's debt was paid off.
///
///
///    ﻿Equity is found on a company's balance sheet and is one of the most common financial metrics employed by analysts to assess the financial health of a company. Shareholder equity can also represent the book value of a company. Equity can sometimes be offered as payment-in-kind.
    case EQUITY
///    Options are financial instruments that are derivatives based on the value of underlying securities such as stocks. An options contract offers the buyer the opportunity to buy or sell—depending on the type of contract they hold—the underlying asset. Unlike futures, the holder is not required to buy or sell the asset if they choose not to.
///
///    Call options allow the holder to buy the asset at a stated price within a specific timeframe.
///    Put options allow the holder to sell the asset at a stated price within a specific timeframe.
    case OPTION
    ///An index is a method to track the performance of some group of assets in a standardized way. Indexes typically measure the performance of a basket of securities intended to replicate a certain area of the market. These may be broad-based to capture the entire market such as the Standard & Poor's 500 (S&P 500) or Dow Jones Industrial Average (DJIA), or more specialized such as indexes that track a particular industry or segment. Indexes are also created to measure other financial or economic data such as interest rates, inflation, or manufacturing output.
    case INDEX
    /// A mutual fund is a type of financial vehicle made up of a pool of money collected from many investors to invest in securities like stocks, bonds, money market instruments, and other assets. Mutual funds are operated by professional money managers, who allocate the fund's assets and attempt to produce capital gains or income for the fund's investors. A mutual fund's portfolio is structured and maintained to match the investment objectives stated in its prospectus.
    case MUTUAL_FUND
///    Cash equivalents are investments securities that are meant for short-term investing; they have high credit quality and are highly liquid.
///
///    Cash equivalents, also known as "cash and equivalents," are one of the three main asset classes in financial investing, along with stocks and bonds. These securities have a low-risk, low-return profile and include U.S. government Treasury bills, bank certificates of deposit, bankers' acceptances, corporate commercial paper, and other money market instruments.
    case CASH_EQUIVALENT
    ///Fixed income broadly refers to those types of investment security that pay investors fixed interest or dividend payments until its maturity date. At maturity, investors are repaid the principal amount they had invested. Government and corporate bonds are the most common types of fixed-income products. Unlike equities that may pay no cash flows to investors, or variable-income securities, where can payments change based on some underlying measure—such as short-term interest rates—the payments of a fixed-income security are known in advance.
    case FIXED_INCOME
///    Currency is a medium of exchange for goods and services. In short, it's money, in the form of paper or coins, usually issued by a government and generally accepted at its face value as a method of payment.
///
///
///    Currency is the primary medium of exchange in the modern world, having long ago replaced bartering as a means of trading goods and services.
///
///
///    In the 21st century, a new form of currency has entered the vocabulary, the virtual currency. Virtual currencies such as bitcoins have no physical existence or government backing and are traded and stored in electronic form.
    case CURRENCY
}


enum PositionEffect: String, Codable {
    ///The opening price is the price at which a security first trades upon the opening of an exchange on a trading day; for example, the New York Stock Exchange (NYSE) opens at precisely 9:30 a.m. Eastern time. The price of the first trade for any listed stock is its daily opening price. The opening price is an important marker for that day's trading activity, particularly for those interested in measuring short-term results such as day traders.
    case OPENING
///    Closing a position refers to executing a security transaction that is the exact opposite of an open position, thereby nullifying it and eliminating the initial exposure. Closing a long position in a security would entail selling it, while closing a short position in a security would involve buying it back. Taking offsetting positions in swaps is also very common to eliminate exposure prior to maturity.
///
///    Closing position is also known as "position squaring."
    case CLOSING
    ///Automatic execution is a method for executing trades without imputing them manually. Automated systems allow traders to take advantage of trading signals to buy or sell an asset whenever a signal is generated, so the trader doesn't need to manually input the order. Orders can be created automatically based on a wide variety of technical indicators and trading systems.
    case AUTOMATIC
}


enum QuantityType: String, Codable {
    case ALL_SHARES
    case DOLLARS
    case SHARES
}

enum Status: String, Codable {
    ///A large block of shares that can be sliced by dividing it into smaller lots (known as the child orders) in execution of a transaction. A parent order is typically used in many algorithmic trading strategies to structure a trade
    case AWAITING_PARENT_ORDER
    case AWAITING_CONDITION
    case AWAITING_MANUAL_REVIEW
    case ACCEPTED
    case AWAITING_UR_OUT
    case PENDING_ACTIVATION
    case QUEUED
    case WORKING
    case REJECTED
    case PENDING_CANCEL
    case CANCELED
    case PENDING_REPLACE
    case REPLACED
    ///Completed.
    case FILLED
    case EXPIRED
}

enum PutCall: String, Codable {
    ///A put is an options contract that gives the owner the right, but not the obligation, to sell a certain amount of the underlying asset, at a set price within a specific time. ... The exercise price is the price that the underlying asset must reach for the put option contract to hold value.
    case PUT
    ///A call can mean two things. It can refer to an option contract giving the owner the right, but not the obligation, to buy a specified amount of an underlying security at a specified price within a specified time. It can also refer to a call auction, a time when buyers set a maximum acceptable price to buy, and sellers set the minimum satisfactory price to sell a security on an exchange. Matching buyers and sellers in this process increases liquidity and decreases volatility. The auction is sometimes referred to as a call market.
    case CALL
}

enum CurrencyType: String, Codable {
    ///The USD is the abbreviation for the U.S. Dollar, the official currency of United States of America and the world's primary reserve currency.
    case USD
    ///The Canadian dollar (CAD) is the national currency of Canada. The Canadian dollar is made up of 100 cents and is often represented with a "C" together with the dollar sign as C$, to allow it to be distinguished from other currencies denominated in dollars, such as the U.S. dollar (USD) or Australian dollar (AUD).
    case CAD
    ///EUR is the currency code used in the general industry to represent the euro, the official currency for 19 of the 28 members of the European Union (EU). There will be 27 countries in the EU when the United Kingdom leaves the union as a result of the Brexit referendum
    case EUR
    ///JPY is the currency abbreviation or the currency symbol for the Japanese yen (JPY), the currency for Japan. The Japanese yen is also widely used as a reserve currency after the U.S. dollar, euro, and British pound
    case JPY
}

enum ActivityType: String, Codable {
    case EXECUTION
    case ORDER_ACTION
}

enum ExecutionType: String, Codable {
    case FILL
}
// TYPES
enum MutualFundType: String, Codable {
    case NOT_APPLICABLE
    ///An open-end fund is a diversified portfolio of pooled investor money that can issue an unlimited number of shares. The fund sponsor sells shares directly to investors and redeems them as well. These shares are priced daily, based on their current net asset value (NAV). Some mutual funds, hedge funds, and exchange-traded funds (ETFs) are types of open-end funds.
    case OPEN_END_NON_TAXABLE
    ///An open-end fund is a diversified portfolio of pooled investor money that can issue an unlimited number of shares. The fund sponsor sells shares directly to investors and redeems them as well. These shares are priced daily, based on their current net asset value (NAV). Some mutual funds, hedge funds, and exchange-traded funds (ETFs) are types of open-end funds.
    case OPEN_END_TAXABLE
    ///A no-load fund is a mutual fund in which shares are sold without a commission or sales charge. This absence of fees occurs because the shares are distributed directly by the investment company, instead of going through a secondary party. This absence of a sales charges is the opposite of a load fund—either front-load or back-load—which charges a commission at the time of the fund's purchase or sale. Also, some mutual funds are level-load funds where fees continue for as long as the investor holds the fund.
    case NO_LOAD_NON_TAXABLE
    ///A no-load fund is a mutual fund in which shares are sold without a commission or sales charge. This absence of fees occurs because the shares are distributed directly by the investment company, instead of going through a secondary party. This absence of a sales charges is the opposite of a load fund—either front-load or back-load—which charges a commission at the time of the fund's purchase or sale. Also, some mutual funds are level-load funds where fees continue for as long as the investor holds the fund.
    case NO_LOAD_TAXABLE
}

enum CashEquivalentType: String, Codable {
    case SAVINGS
///    A money market fund is a kind of mutual fund that invests only in highly liquid near-term instruments such as cash, cash equivalent securities, and high credit rating debt-based securities with a short-term, maturity—less than 13 months, such as U.S. Treasuries. As a result, these funds offer high liquidity with a very low level of risk.
///
///    While they sound highly similar, a money market fund is not the same as a money market account (MMA). The former is an investment, sponsored by an investment fund company, and hence carries no guarantee of principal. The latter is an interest-earning saving account offered by financial institutions, with limited transaction privileges and insured by the Federal Deposit Insurance Corporation (FDIC).
    case MONEY_MARKET_FUND
}

///Options are financial instruments that are derivatives based on the value of underlying securities such as stocks. An options contract offers the buyer the opportunity to buy or sell—depending on the type of contract they hold—the underlying asset. Unlike futures, the holder is not required to buy or sell the asset if they choose not to.
enum OptionType: String, Codable {
    ///A vanilla option is a financial instrument that gives the holder the right, but not the obligation, to buy or sell an underlying asset at a predetermined price within a given timeframe. A vanilla option is a call or put option that has no special or unusual features
    case VANILLA
    ///A binary option is a financial product where the buyer receives a payout or loses their investment, based on if the option expires in the money.
    case BINARY
    ///A barrier option is a type of derivative where the payoff depends on whether or not the underlying asset has reached or exceeded a predetermined price. A barrier option can be a knock-out, meaning it expires worthless if the underlying exceeds a certain price, limiting profits for the holder and limiting losses for the writer. It can also be a knock-in, meaning it has no value until the underlying reaches a certain price.
    case BARRIER
}

enum Symbol: String, Codable {
    case ADMS
    case DRAD
    case LXU
    case MCEP
    case NCSM
    case RMBL
    case SNMP
}
