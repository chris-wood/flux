import simpy

class FluxEvent(object):
    def __init__(self, event):
        self.event = event

    def add_callback(self, func):
        def wrapper(event):
            func(event.value)
        self.event.callbacks.append(wrapper)

    def succeed(self, param):
        self.event.succeed(param)

    def wait(self):
        yield self.event

# http://simpy.readthedocs.io/en/latest/api_reference/simpy.rt.html
# TODO: provide similar functions for all of these methods
class Flux(object):
    def __init__(self):
        self.env = simpy.rt.RealtimeEnvironment()

    def add_flow(self, flow):
        self.env.process(flow(self))

    def wait(self, nsecs):
        timeout = self.env.timeout(nsecs)
        return timeout

    def run(self, nsecs):
        self.env.run(until=nsecs)

    def create_event(self):
        return FluxEvent(self.env.event())


def success(value):
    print "woot!: %s" % (repr(value))

def my_flow(flux):
    print "hello"

    yield flux.wait(1)

    event = flux.create_event()
    event.add_callback(success)
    event.succeed("donezo")

    event.wait()

    print "goodbye"


flux = Flux()
flux.add_flow(my_flow)
flux.run(2)
