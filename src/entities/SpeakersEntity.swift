import ScadeKit

@objcMembers
final class SpeakersEntity: EObject {
		dynamic var speakers: [Speakers]
		
		override init() {
				self.speakers = []
		}
		
		func update(speakers: [Speakers]) {
				self.speakers = speakers.sorted { $0.fullName < $1.fullName }
		}
}
