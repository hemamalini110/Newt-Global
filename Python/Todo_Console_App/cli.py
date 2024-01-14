import PySimpleGUI as sg
import functions
import time
sg.theme("Black")
label_time =sg.Text(time.strftime("%b %d %Y , %H:%M:%S") ,  key="clock")

label = sg.Text("Type a to-do :",)

input_box = sg.InputText(tooltip="Enter todo" , key="todo")
add_btn = sg.Button("Add")
list_box = sg.Listbox(values=functions.read_todos() , key='todos' ,
                      enable_events=True , size=[45,10])
edit_btn = sg.Button("Edit")
complete_btn = sg.Button("Complete")
exit_btn = sg.Button("Exit")

window = sg.Window("My To-Do App ",
                   layout=[[label_time],
                           [label],
                           [input_box,add_btn],
                           [list_box,edit_btn,complete_btn],
                           [exit_btn]])

while True:
    event , values = window.read(timeout=1000)
    window["clock"].update(value=time.strftime("%b %d %Y , %H:%M:%S"))

    match event:
        case "Add":
            todos = functions.read_todos()
            new_todos = values['todo']+"\n"
            todos.append(new_todos)
            functions.write_todos(todos)
            window['todos'].update(values=todos)
        case "Edit":
            try:
                todos_to_edit = values['todos'][0]
                new_todo = values['todo']+"\n"

                todos = functions.read_todos()
                index = todos.index(todos_to_edit)
                todos[index] =new_todo
                functions.write_todos(todos)
                window['todos'].update(values=todos)
            except IndexError:
                sg.popup("Please select an item first")

        case "Complete":
            try:
                todos_to_complete = values['todos'][0]
                todos = functions.read_todos()
                todos.remove(todos_to_complete)
                functions.write_todos(todos)
                window['todos'].update(values=todos)
                window['todo'].update(value="")
            except IndexError:
                sg.popup("Please select an item first")
        case "Exit":
            break
        case "todos":
            window['todo'].update(value=values['todos'][0])
        case sg.WIN_CLOSED:
            break

window.close()

