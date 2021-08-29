##append
todos = open('todos.txt', 'a')

print('something', file=todos)

todos.close()

##read
tasks = open('todos.txt')

##line by line
for chore in tasks:
    print(chore)

##line without ends
for chore in tasks:
    print(chore, end='')
tasks.close()