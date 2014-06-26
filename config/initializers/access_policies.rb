# Register access policies, e.g.:
#
# OSU::AccessPolicy.register(Model, ModelAccessPolicy)
OSU::AcessPolicy.register(Event, EventAccessPolicy)
OSU::AcessPolicy.register(BrowsingEvent, UserEventAccessPolicy)
OSU::AcessPolicy.register(HeartbeatEvent, UserEventAccessPolicy)
OSU::AcessPolicy.register(CursorEvent, UserEventAccessPolicy)
OSU::AcessPolicy.register(InputEvent, UserEventAccessPolicy)
OSU::AcessPolicy.register(TaskEvent, ApplicationEventAccessPolicy)
OSU::AcessPolicy.register(GradingEvent, ApplicationEventAccessPolicy)
