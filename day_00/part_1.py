class Thing():

    def __init__(self, line):
        pass



with open('input.txt') as f:
    lines = f.readlines()



things = []
for line in lines:
    things.append(Thing(line))



