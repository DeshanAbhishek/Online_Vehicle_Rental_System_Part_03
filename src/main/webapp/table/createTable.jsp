<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<%
try{
	Connection con=ConnectionProvider.getCon();
	Statement st=con.createStatement();
	//String q1="create table users(name varchar(100) not null,email varchar(100)primary key,mobileNumber bigint not null,sequrityQuestion varchar(200) not null,answer varchar(200) not null,password varchar(100)not null)";
	//st.execute(q1);
	String q2="create table vehicle(id int primary key,model varchar(100) not null,vehicleType varchar(100) not null,year varchar(100) not null,rentalPricePerDay int not null,availability varchar(12) not null,insuranceExpiryDate date not null,fuelType varchar(12) not null)";
	st.execute(q2);
	System.out.print("Table created");
	con.close();
}catch(Exception e){
	System.out.print(e);
}

%>