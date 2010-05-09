 import groovy.sql.Sql

def foo = 'cheese'
def sql = Sql.newInstance("jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=d:\\SpiderResult.mdb", "",
                      "", "sun.jdbc.odbc.JdbcOdbcDriver")
def HashSet names = [];
	index = 0
sql.eachRow("select  内容 from Content") {
    index++
    println index
    def matcher = it =~  /<td><a href='http:\/\/[^\/]*\.javaeye.com' target='_blank'>([^\/]*)<\/a><\/td>/

	matcher.each{

		names.add(it[1])
	}
    // <td><a href='http://[.]*\.javaeye.com' target='_blank'>yourgame</a></td>
}

def f2= new File('d:\\user.txt')
f2.write('','utf-8');
names.each{
	f2.append(it+"\n")
}

println names.size()
