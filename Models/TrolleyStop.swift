//
//  TrolleyStop.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import Foundation

struct TrolleyStop: Identifiable, Hashable {
    let id: Int
    let name: String
    let shortName: String
    let imageURL: String
    let routePosition: Int
    let times: [String]
}

// Schedule data
extension TrolleyStop {
    static let allStops = [
        TrolleyStop(
            id: 1,
            name: "Whalers Village & Westin Hotel",
            shortName: "Whalers Village",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/Kaanapali-Trolley%20whalers.jpg/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 1,
            times: [
                "10:00 am", "10:30 am", "11:00 am", "11:30 am", "12:00 pm (Drop Off Only)",
                "1:00 pm", "1:30 pm", "2:00 pm", "2:30 pm", "3:00 pm", "3:30 pm (Drop Off Only)",
                "4:00 pm", "4:30 pm", "5:00 pm", "5:30 pm", "6:00 pm", "6:30 pm (Drop Off Only)",
                "7:00 pm", "7:30 pm", "8:00 pm", "8:30 pm", "9:00 pm (Last Pick Up)", "9:30 pm (Final Drop Off)"
            ]
        ),
        TrolleyStop(
            id: 2,
            name: "Maui Marriott & Hyatt",
            shortName: "Marriott & Hyatt",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/IMG_7472%5B1%5D.JPG/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 2,
            times: [
                "10:02 am", "10:32 am", "11:02 am", "11:32 am", "1:02 pm", "1:32 pm",
                "2:02 pm", "2:32 pm", "3:02 pm", "4:02 pm", "4:32 pm", "5:02 pm",
                "5:32 pm", "6:02 pm", "7:02 pm", "7:32 pm", "8:02 pm", "8:32 pm",
                "9:02 pm (Last Pick Up)"
            ]
        ),
        TrolleyStop(
            id: 3,
            name: "Kaanapali Golf Course",
            shortName: "Golf Course",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/IMG_7494.JPG/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 3,
            times: [
                "10:07 am", "10:37 am", "11:07 am", "11:37 am", "1:07 pm", "1:37 pm",
                "2:07 pm", "2:37 pm", "3:07 pm", "4:07 pm", "4:37 pm", "5:07 pm",
                "5:37 pm", "7:07 pm (Roys)", "7:37 pm", "8:07 pm", "8:37 pm",
                "9:07 pm (Last Pick Up)"
            ]
        ),
        TrolleyStop(
            id: 4,
            name: "Maui Kaanapali Villas",
            shortName: "Kaanapali Villas",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/IMG_7493.JPG/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 4,
            times: [
                "10:10 am", "10:45 am", "11:15 am", "11:45 am", "1:15 pm", "1:45 pm",
                "2:15 pm", "2:45 pm", "3:15 pm", "4:15 pm", "4:45 pm", "5:45 pm",
                "6:15 pm", "7:15 pm", "7:45 pm", "8:15 pm", "8:45 pm",
                "9:15 pm (Last Pick Up)"
            ]
        ),
        TrolleyStop(
            id: 5,
            name: "Royal Lahaina & El Dorado & Fairway Shops",
            shortName: "Royal Lahaina",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/IMG_7473%5B1%5D.JPG/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 5,
            times: [
                "10:15 am", "10:50 am", "11:20 am", "11:50 am", "1:20 pm", "1:50 pm",
                "2:20 pm", "2:50 pm", "3:20 pm", "4:20 pm", "4:50 pm", "5:20 pm",
                "5:50 pm", "6:20 pm", "7:20 pm", "7:50 pm", "8:20 pm", "8:50 pm",
                "9:20 pm (Last Pick Up)"
            ]
        ),
        TrolleyStop(
            id: 6,
            name: "Sheraton & Kaanapali Beach Hotel",
            shortName: "Sheraton",
            imageURL: "https://img1.wsimg.com/isteam/ip/dde5eb17-7ffe-46a2-a866-8650039134cb/IMG_7471%5B1%5D.JPG/:/rs=w:388,h:194,cg:true,m/cr=w:388,h:194",
            routePosition: 6,
            times: [
                "10:25 am", "10:55 am", "11:25 am", "11:55 am", "1:25 pm", "1:55 pm",
                "2:25 pm", "2:55 pm", "3:25 pm", "4:25 pm", "4:55 pm", "5:25 pm",
                "5:55 pm", "6:25 pm", "7:25 pm", "7:55 pm", "8:25 pm",
                "9:25 pm (Last Pick Up)"
            ]
        )
    ]
}
