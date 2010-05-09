class MyExpandableClass{
Map props=[:];
def getProperty(String property){
return props[property];
}
void setProperty(String property, Object newValue){
props[property] = newValue;
}
}
MyExpandableClass myExpandableObject = new MyExpandableClass()
myExpandableObject.numberValue=1234
myExpandableObject.dateValue=new Date()
myExpandableObject.stringValue="TEST"
println myExpandableObject.numberValue
println myExpandableObject.dateValue
println myExpandableObject.stringValue