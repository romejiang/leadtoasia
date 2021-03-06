dataSource {
	pooled = true
	driverClassName = "org.hsqldb.jdbcDriver"
	username = "sa"
	password = ""
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://127.0.0.1:3306/leadtoasia?useUnicode=true&characterEncoding=utf8"		 
			driverClassName = "org.gjt.mm.mysql.Driver"
			username = "root"
			password = "1qazxsw2"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://127.0.0.1:3306/leadtoasia?useUnicode=true&characterEncoding=utf8"		 
			driverClassName = "org.gjt.mm.mysql.Driver"
			username = "root"
			password = "!QAZXSW@leadtoasiaMYSQL"
            //password = "1qazxsw2"
		}
	}
}

