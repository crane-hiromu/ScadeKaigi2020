import ScadeKit

@objcMembers
final class SponsorEntity: EObject {
		
		dynamic var sponsors: [SponsorRowModel]
		
		override init() {
				self.sponsors = []
		}
		
		func update(sponsors: [Sponsor]) {
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
				left.forEach { l in
						right.forEach { r in
								new.append(SponsorRowModel(left: l, right: r))
						}
				}
				self.sponsors = new
		}
		
		/// create static data
		func create() {
				update(sponsors: [
						Sponsor(url: "https://developers.google.com/", logo: "res/spGoogle.png"),
						Sponsor(url: "https://mixi.co.jp/recruit/", logo: "res/spMixi.png")
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