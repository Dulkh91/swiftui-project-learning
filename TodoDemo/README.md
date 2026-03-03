## Todo coredata
បង្កើត project ដោយយកជាមួយ coredata ។ នៅក្នុងមេរៀន coredata នេះចំនុចសំខាន់មានពីរគឺ៖

១) **@Environment**  វាមានតួនាតីធ្វើជាមួយ coredata ដោយមាន save, delete, edit ...
```swift
@Environment(\.managedObjectContext) var managerObjectContext
```
២) **@FetchRequest** និង **FetchedResults** 
```swift
@FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])

var todos: FetchedResults<Todo>
```
or មិនសរសេរជា keyPath
```swift
@FetchRequest(entity: Todo.entity(),sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
```
- FetchRequest: គឺជាការ fetch database
- FetchedResults: វាគឺជា responsive database បន្ទាបពី fetch 


## AddTodoViw.swift
<div>
<img src="./Image-Readme/new-todo.jpg" width="200px">
</div>

## ContentView.swift

<div>
<img src="./Image-Readme/todo.jpg" width="200px">
</div>

## SettingView.swift
<div>
<img src="./Image-Readme/setting.jpg" width="200px">
</div>
