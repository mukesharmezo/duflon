package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.HOD;

@Repository
public interface HODRepository extends JpaRepository<HOD, Long> {
	
	public Optional<HOD> findByEmpCode(String empCode);
	public Optional<HOD> findByEmpCodeAndEmail(String empCode, String email);
public Optional<HOD> findByIdAndEmail(Long id,String email);
	
	public Optional<HOD> findByEmailAndPassword(String email,String password);
	
	public Optional<HOD> findByPassword(String password);
	
	public Optional<HOD> findById(int id);

	@Modifying
	@Query("UPDATE HOD l SET l.email = :email WHERE l.empCode = :empCode")
	public void addEmailAddressAfterLogin(String empCode, String email);
	
	@Modifying
	@Query("UPDATE HOD l SET l.password = :password WHERE l.empCode = :empCode")
	public void changePasswordByEmpCode(String empCode, String password);

	@Modifying
	@Query("UPDATE HOD l SET l.email = :email WHERE l.empCode = :empCode")
	public void changeEmail(String empCode, String email);
	
	@Modifying
	@Query("UPDATE HOD l SET l.email = :email WHERE l.id = :id")
	public void changeEmailById( Long id,String email);
	
	@Modifying
	@Query("UPDATE HOD l SET l.password = :password WHERE l.id = :id")
	public void updatePassword( Long id,String password);
	
	public Optional<HOD> findByEmail(String user);
	
	public Optional<HOD> findByEmpCodeAndPassword(String user, String password);
}
