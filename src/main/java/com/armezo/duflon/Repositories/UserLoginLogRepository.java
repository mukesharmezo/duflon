package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.armezo.duflon.Entities.UserLoginLog;

public interface UserLoginLogRepository   extends JpaRepository<UserLoginLog,Long>{
	
	Optional<UserLoginLog> findByEmpCode(String empCode);

}
