package com.illyum;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

@Configuration
@PropertySource("application.properties")
public class BankWsAppConfiguration {
	
	@Value("${sqlServer}")
	private String sqlServer;
	
	@Value("${sqlServerPort}")
	private int sqlServerPort;
	
	@Value("${sqlServerDatabase}")
	private String sqlServerDatabase;

	@Value("${sqlServerUser}")
	private String sqlServerUser;
	
	@Value("${sqlServerPassword}")
	private String sqlServerPassword;

	@Bean
	public DataSource getSqlServerDataSource() {
		SQLServerDataSource dataSource = new SQLServerDataSource();
		
		dataSource.setServerName(sqlServer);
		dataSource.setPortNumber(sqlServerPort);
		dataSource.setDatabaseName(sqlServerDatabase);
		dataSource.setUser(sqlServerUser);
		dataSource.setPassword(sqlServerPassword);
		dataSource.setApplicationName("Bank Web Services for Integration Testing");
		
		return dataSource;
	}

	@Bean
	public static PropertySourcesPlaceholderConfigurer getPropertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}
}
