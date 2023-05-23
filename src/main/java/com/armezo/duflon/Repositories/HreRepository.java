package com.armezo.duflon.Repositories;


import java.util.Date;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.armezo.duflon.Entities.HRE;

public interface HreRepository extends JpaRepository<HRE,Long>{


	public Optional<HRE> findByEmpCode(String empCode);
	public Optional<HRE> findByEmpCodeAndEmail(String empCode,String email);

	public Optional<HRE> findByPassword(String password);
	
	public Optional<HRE> findByEmpCodeAndPassword(String empCode,String password);
	
	public Optional<HRE> findById(long id);
	
	@Modifying
	@Query("UPDATE HRE h SET h.email = :email WHERE h.id = :id")
	public void addEmailAddress(Long id, String email);	

	@Modifying
	@Query("UPDATE HRE h SET h.password = :password WHERE h.empCode = :empCode")
	public void changePassword(String empCode, String password);

	@Modifying
	@Query("UPDATE HRE h SET h.email = :email WHERE h.empCode = :empCode")
	public void changeEmail(String empCode, String email);
	
	@Modifying
	@Query("UPDATE HRE h SET h.status = :status, deactivationDate =:deactivationDate WHERE h.id = :id")
	public void deactivateHRE(boolean status,Date deactivationDate, Long id);
	
	
	
	
	
	
	
	
	

}
