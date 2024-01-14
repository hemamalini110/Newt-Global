#""" docstring help(function_name) to see the description of the function

#constant variables
FILEPATH ="todos.txt"
def read_todos(filepath=FILEPATH):
    """ read the file and return the content in the file """
    with open(filepath, 'r') as file:
        todos = file.readlines()
        file.close()
    return todos
#print(help(read_todos()))
#non-defa arg should listed first
def write_todos(todos,filepath =FILEPATH):
    """ write the list passed as argument in the file """
    with open(filepath ,'w') as file:
        file.writelines(todos)
        file.close()
