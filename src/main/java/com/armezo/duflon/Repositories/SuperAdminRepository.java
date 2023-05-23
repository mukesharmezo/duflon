package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.AdminTable;


@Repository
public interface SuperAdminRepository extends JpaRepository<AdminTable,Integer>{
	
	
@Query("SELECT a FROM AdminTable a where   a.empCode=:empCode and password =:password")
public Optional<AdminTable>  findByEmpCodeAndPassword(String empCode,String password);

@Query("SELECT a FROM AdminTable a WHERE a.empCode=:empCode")
public Optional<AdminTable> findAdminByEmpCode(String empCode);

	
   //public Optional<User> findByMspin(String mspin);
}
