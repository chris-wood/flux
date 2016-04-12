class MyFlow(Flow):
    def __init__(self, name):
        pass

    def start(self):
        pass


class FlowScheduler():
    def __init__(self):
        pass

scheduler = FlowScheduler()

scheduler.add_flow(MyFlow())
scheduler.schedule_flow(MyFlow(), params)
