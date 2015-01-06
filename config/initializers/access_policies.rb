require_relative 'doorkeeper'

# Register access policies, e.g.:
#
# OSU::AccessPolicy.register(Model, ModelAccessPolicy)
OSU::AccessPolicy.register(Person, PersonAccessPolicy)

OSU::AccessPolicy.register(LoadEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(HeartbeatEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(LinkEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(UnloadEvent, UserEventAccessPolicy)

OSU::AccessPolicy.register(TaskingEvent, ApplicationEventAccessPolicy)
OSU::AccessPolicy.register(AnswerEvent, ApplicationEventAccessPolicy)
OSU::AccessPolicy.register(GradingEvent, ApplicationEventAccessPolicy)

OSU::AccessPolicy.register(ExerciseActivity, ActivityAccessPolicy)
OSU::AccessPolicy.register(FeedbackActivity, ActivityAccessPolicy)
OSU::AccessPolicy.register(InteractiveActivity, ActivityAccessPolicy)
OSU::AccessPolicy.register(PeerGradingActivity, ActivityAccessPolicy)
OSU::AccessPolicy.register(ReadingActivity, ActivityAccessPolicy)
