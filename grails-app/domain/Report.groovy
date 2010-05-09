// 财务统计，按月，按周，按季度，按年

class Report {
    Project project
    float income //收 入
    float expenses  //支出
    float profit // 盈利
    Date start
    Date deadline
    static constraints = {
    	project()
		income(blank: false)
		expenses(blank: false)
		profit(blank: false)
 		start()
		deadline(validator:{val, obj->
			  return val.after(obj.start)
			}) 
    }

    String toString (){ 
        "$project $income - $expenses = $profit"
    }
}
