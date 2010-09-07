// 财务统计，按月，按周，按季度，按年

class Report {
    Project project
    float income //收 入 都按美金计算
    float expenses  //支出
    float profit // 盈利
    Date start
    Date deadline
    static constraints = {
    	project(unique:true)
		income(blank: false)
		expenses(blank: false)
		profit(blank: false)
 		start()
		deadline(validator:{val, obj->
			  return val.after(obj.start)
			}) 
    }

    static mapping = {
        sort deadline:"desc" 
    }

    static namedQueries = { 
        someMonth { year , month ->
            def calendar = Calendar.getInstance()
            calendar.set(  year ,month-1 ,1 , 0 ,0) 
            def first = calendar.getTime()
            calendar.set(  year ,month ,1 , 0 ,0) 
            def end = calendar.getTime()
            between 'deadline', first , end
        } 
    }

    String toString (){ 
        "$project $income - $expenses = $profit"
    }
}
