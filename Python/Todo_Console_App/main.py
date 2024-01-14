#from module import functions (read_todos,...)
import functions
#python module index page has all the modules list and description
import time

now = time.strftime("%b %d , %Y %H:%M:%S")
print("It\'s",now )

while 1:
    user_action = input("Type Add - Show - Edit - Complete - Exit") + "\n"

    if 'Add' in user_action:

        todo = user_action[4:]

        todos=functions.read_todos()

        todos.append(todo)

        functions.write_todos(todos)
    elif 'Show' in user_action:

        todos=functions.read_todos()

        for index, i in enumerate(todos):
            row = f"{index + 1}. {i}".strip("\n")
            print(row)
    elif 'Edit' in user_action:
        try:
            number = int(user_action[5:])
            todo = input("Enter a todo : ")

            todos = functions.read_todos()

            todos[number - 1] = todo + "\n"

            functions.write_todos(todos)
        except ValueError:
            print("Your Command is not valid...")
    elif 'Complete' in user_action:
        try:
            number = int(user_action[9:])

            todos=functions.read_todos()

            todo_remove = todos[number - 1].strip("\n")
            todos.pop(number - 1)

            functions.write_todos(todos)

            message = f"{todo_remove} is removed succesfully"
            print(message)
        except IndexError:
            print("No item with that number...")
    elif 'Exit' in user_action:
        break
    else:
        print("Command is not valid...")

print("Bye...")
