require_relative 'doorkeeper'

# Register access policies, e.g.:
#
# OSU::AccessPolicy.register(Model, ModelAccessPolicy)
OSU::AccessPolicy.register(Identifier, IdentifierAccessPolicy)

OSU::AccessPolicy.register(LoadEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(HeartbeatEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(LinkEvent, UserEventAccessPolicy)
OSU::AccessPolicy.register(UnloadEvent, UserEventAccessPolicy)

OSU::AccessPolicy.register(TaskingEvent, ApplicationEventAccessPolicy)
OSU::AccessPolicy.register(AnswerEvent, ApplicationEventAccessPolicy)
OSU::AccessPolicy.register(GradingEvent, ApplicationEventAccessPolicy)
