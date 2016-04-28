import simpy

# http://simpy.readthedocs.io/en/latest/api_reference/simpy.rt.html
# TODO: provide similar functions for all of these methods
class Flux(object):
    def __init__(self):
        self.env = simpy.rt.RealtimeEnvironment()

    def add_flow(self, flow):
        self.env.process(flow(self))

    def wait(self, nsecs):
        return self.env.timeout(nsecs)

    def run(self, nsecs):
        self.env.run(until=nsecs)

    def create_event(self):
        return self.env.event()

    # def schedule(self, )

# TODO: wrap the simpy event and provide a decorator that only passes in the value of the event, instead of something else
# http://simpy.readthedocs.io/en/latest/api_reference/simpy.events.html
def success(value):
    print "woot!: %s" % (str(value))

def my_flow(flux):
    print "hello"
    yield flux.wait(1)

    event = flux.create_event()
    event.callbacks.append(success)
    event.succeed("donezo")
    yield event

    print "goodbye"


flux = Flux()
flux.add_flow(my_flow)
flux.run(2)
