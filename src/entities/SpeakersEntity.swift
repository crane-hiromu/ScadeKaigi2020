import ScadeKit

@objcMembers
final class SpeakersEntity: EObject {
		dynamic var speakers: [Speaker]
		
		override init() {
				self.speakers = []
		}
	
		init(_ speakers: [Speaker]) {
        self.speakers = speakers.sorted { $0.fullName < $1.fullName }
    }
		
//		init(_ speakers: [Speakers]) {
//				self.speakers = speakers // todo convert
//		}
}
