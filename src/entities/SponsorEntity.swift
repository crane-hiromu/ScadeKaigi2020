import ScadeKit

@objcMembers
final class SponsorEntity: EObject {
    
    enum SponsorType {
        case gold, supporter
    }
    
    dynamic var sponsors: [SponsorRowModel]
    dynamic var supporters: [SponsorRowModel]
    
    override init() {
        self.sponsors = []
        self.supporters = []
    }
    
    func update(type: SponsorType, sponsors: [Sponsor]) {
        var left = [Sponsor]()
        var right = [Sponsor]()
        
        sponsors.enumerated().forEach {
            if $0.offset.isMultiple(of: 2) {
                left.append($0.element)
            } else {
                right.append($0.element)
            }
        }
        if left.count != right.count {
            right.append(Sponsor())
        }
        
        var new = [SponsorRowModel]()
        for i in (0..<left.count) {
            new.append(SponsorRowModel(left: left[i], right: right[i]))
        }
        
        switch type {
        case .gold:
            self.sponsors = new
        case .supporter:
            self.supporters = new
        }
    }
    
    /// create static data
    func create() {
        update(type: .gold, sponsors: [
            Sponsor(name: "Google", url: "https://developers.google.com/", logo: "res/spGoogle.png"),
            Sponsor(name: "mixi", url: "https://mixi.co.jp/recruit/", logo: "res/spMixi.png"),
            Sponsor(name: "mercari", url: "https://twitter.com/mercaridevjp", logo: "res/spMercari.png"),
            Sponsor(name: "MoneyForward", url: "https://corp.moneyforward.com/", logo: "res/spMoney.png"),
            Sponsor(name: "iRidge", url: "https://iridge.jp/", logo: "res/spIridge.png"),
            Sponsor(name: "sansan", url: "https://buildersbox.corp-sansan.com/", logo: "res/spSansan.png"),
            Sponsor(name: "Yahoo!JAPAN", url: "https://www..co.jp", logo: "res/spYahoo.png"),
            Sponsor(name: "Diverse", url: "https://diverse-inc.co.jp/", logo: "res/spDiverse.png"),
            Sponsor(name: "bitFlyer", url: "https://bitflyer.com/ja-jp/Recruit", logo: "res/spBitFlyer.png"),
            Sponsor(name: "CyberAgent", url: "https://www.cyberagent.co.jp", logo: "res/spCyberAgent.png"),
            Sponsor(name: "cookpad", url: "https://info.cookpad.com/careers/", logo: "res/spCookpad.png"),
            Sponsor(name: "DMM", url: "https://dmm-corp.com/", logo: "res/spDMM.png"),
            Sponsor(name: "Roomclip", url: "https://roomclip.jp/", logo: "res/spRoomclip.png"),
            Sponsor(name: "Eureka", url: "https://eure.jp/", logo: "res/spEureka.png"),
            Sponsor(name: "Recruit Lifestyle", url: "https://engineer.recruit-lifestyle.co.jp/recruiting/", logo: "res/spRecruit.png"),
            Sponsor(name: "M3", url: "https://jobs.m3.com/engineer/", logo: "res/spM3.png"),
            Sponsor(name: "Line", url: "https://engineering.linecorp.com/ja/", logo: "res/spLine.png"),
            Sponsor(name: "DeNA", url: "https://dena.com", logo: "res/spDena.png"),
            Sponsor(name: "JapanTaxi", url: "https://japantaxi.co.jp/", logo: "res/spJapanTaxi.png"),
            Sponsor(name: "Team-Lab", url: "https://www.team-lab.com/", logo: "res/spTeamLab.png"),
            Sponsor(name: "Rakuten", url: "https://corp.rakuten.co.jp/", logo: "res/spRakuten.png"),
            Sponsor(name: "NISSAN", url: "https://www.wantedly.com/companies/nissanmotor", logo: "res/spNissan.png"),
            Sponsor(name: "PLAID", url: "https://plaid.co.jp/?source=droidkaigi2020", logo: "res/spPlaid.png"),
            Sponsor(name: "merpay", url: "https://twitter.com/mercaridevjp", logo: "res/spMerpay.png")
        ])
        
        update(type: .supporter, sponsors: [
            Sponsor(name: "GMOペパボ", url: "https://pepabo.com/", logo: "res/spGmo.png"),
            Sponsor(name: "食べログ", url: "https://tabelog.com/", logo: "res/spTabelog.png"),
            Sponsor(name: "and factory", url: "https://andfactory.co.jp/", logo: "res/spAndfactory.png"),
            Sponsor(name: "Quipper", url: "https://www.quipper.com/jp/", logo: "res/spQuipper.png"),
            Sponsor(name: "Hatena", url: "https://hatena.ne.jp", logo: "res/spHatena.png"),
            Sponsor(name: "connehito", url: "https://connehito.com", logo: "res/spConnehito.png"),
            Sponsor(name: "excite", url: "https://info.excite.co.jp", logo: "res/spExcite.png"),
            Sponsor(name: "DeployGate", url: "https://deploygate.com/", logo: "res/spDeployGate.png"),
            Sponsor(name: "Pixiv", url: "https://www.pixiv.co.jp/", logo: "res/spPixiv.png"),
            Sponsor(name: "FuRyu", url: "https://www.furyu.jp/", logo: "res/spFURYU.png"),
            Sponsor(name: "Studyplus", url: "https://info.studyplus.co.jp/", logo: "res/spStudyplus.png"),
            Sponsor(name: "Caraquri", url: "https://caraquri.com", logo: "res/spCaraquri.png"),
            Sponsor(name: "QUO", url: "https://www.quocard.com/", logo: "res/spQUO.png"),
            Sponsor(name: "Recruit Marketing", url: "https://www.recruit-mp.co.jp/career_engineer/", logo: "res/spMarketing.png"),
            Sponsor(name: "MedPeer", url: "https://medpeer.co.jp/", logo: "res/spMedPeer.png"),
            Sponsor(name: "i3 systems", url: "https://www.i3-systems.com/", logo: "res/spSystems.png")
        ])
    }
}

@objcMembers
final class SponsorRowModel: EObject {
    dynamic var left: Sponsor
    dynamic var right: Sponsor
    
    init(left: Sponsor, right: Sponsor) {
        self.left = left
        self.right = right
    }
}

@objcMembers
final class Sponsor: EObject {
    dynamic var name: String
    dynamic var url: String
    dynamic var logo: String
    dynamic var color: SCDGraphicsRGB = .white
    
    override init() {
        self.name = ""
        self.url = ""
        self.logo = "" // todo place holder
    }
    
    init(name: String, url: String, logo: String) {
        self.name = name
        self.url = url
        self.logo = logo
    }
}
