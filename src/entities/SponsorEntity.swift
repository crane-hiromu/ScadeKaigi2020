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
		
		func update(sponsors: [Sponsor], type: SponsorType) {
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
				
				if type == .gold {
						self.sponsors = new	
				} else {
						self.supporters = new
				}
				
		}
		
		/// create static data
		func create() {
				update(sponsors: [
						Sponsor(url: "https://developers.google.com/", logo: "res/spGoogle.png"),
						Sponsor(url: "https://mixi.co.jp/recruit/", logo: "res/spMixi.png"),
						Sponsor(url: "https://twitter.com/mercaridevjp", logo: "res/spMercari.png"),
						Sponsor(url: "https://corp.moneyforward.com/", logo: "res/spMoney.png"),
						Sponsor(url: "https://iridge.jp/", logo: "res/spIridge.png"),
						Sponsor(url: "https://buildersbox.corp-sansan.com/", logo: "res/spSansan.png"),
						Sponsor(url: "https://www.yahoo.co.jp", logo: "res/spYahoo.png"),
						Sponsor(url: "https://diverse-inc.co.jp/", logo: "res/spDiverse.png"),
						Sponsor(url: "https://bitflyer.com/ja-jp/Recruit", logo: "res/spBitFlyer.png"),
						Sponsor(url: "https://www.cyberagent.co.jp", logo: "res/spCyberAgent.png"),
						Sponsor(url: "https://info.cookpad.com/careers/", logo: "res/spCookpad.png"),
						Sponsor(url: "https://dmm-corp.com/", logo: "res/spDMM.png"),
						Sponsor(url: "https://roomclip.jp/", logo: "res/spRoomclip.png"),
						Sponsor(url: "https://eure.jp/", logo: "res/spEureka.png"),
						Sponsor(url: "https://engineer.recruit-lifestyle.co.jp/recruiting/", logo: "res/spRecruit.png"),
						Sponsor(url: "https://jobs.m3.com/engineer/", logo: "res/spM3.png"),
						Sponsor(url: "https://engineering.linecorp.com/ja/", logo: "res/spLine.png"), 
						Sponsor(url: "https://dena.com", logo: "res/spDena.png"), 
						Sponsor(url: "https://japantaxi.co.jp/", logo: "res/spJapanTaxi.png"), 
						Sponsor(url: "https://www.team-lab.com/", logo: "res/spTeamLab.png"), 
						Sponsor(url: "https://corp.rakuten.co.jp/", logo: "res/spRakuten.png"), 
						Sponsor(url: "https://www.wantedly.com/companies/nissanmotor", logo: "res/spNissan.png"), 
						Sponsor(url: "https://plaid.co.jp/?source=droidkaigi2020", logo: "res/spPlaid.png"), 
						Sponsor(url: "https://twitter.com/mercaridevjp", logo: "res/spMerpay.png")
//						   : "https://pepabo.com/",
//						   "https://.com/",
//						   : "https://andfactory.co.jp/",
//						   "https://www.quipper.com/jp/","
//						  "https://hatena.ne.jp",
//						   "https://connehito.com",
//						  : "https://info.excite.co.jp",
//						   "https://deploygate.com/",
//						   "https://www.pixiv.co.jp/",
//						   "https://www.furyu.jp/","
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
		dynamic var url: String
		dynamic var logo: String
		
		override init() {
				self.url = ""
				self.logo = "" // todo place holder
		}
		
		init(url: String, logo: String) {
				self.url = url
				self.logo = logo
		}
}