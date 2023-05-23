package com.armezo.duflon.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.LineManager;

@Repository
public interface LineManagerRepository extends JpaRepository<LineManager, Long> {
	
	public Optional<LineManager> findByEmpCode(String empCode);
	public Optional<LineManager> findByEmpCodeAndEmail(String empCode, String email);
public Optional<LineManager> findByIdAndEmail(Long id,String email);
	
	public Optional<LineManager> findByEmailAndPassword(String email,String password);
	
	public Optional<LineManager> findByPassword(String password);
	
	public Optional<LineManager> findById(int id);

	@Modifying
	@Query("UPDATE LineManager l SET l.email = :email WHERE l.empCode = :empCode")
	public void addEmailAddressAfterLogin(String empCode, String email);
	
	@Modifying
	@Query("UPDATE LineManager l SET l.password = :password WHERE l.empCode = :empCode")
	public void changePasswordByEmpCode(String empCode, String password);

	@Modifying
	@Query("UPDATE LineManager l SET l.email = :email WHERE l.empCode = :empCode")
	public void changeEmail(String empCode, String email);
	
	@Modifying
	@Query("UPDATE LineManager l SET l.email = :email WHERE l.id = :id")
	public void changeEmailById( Long id,String email);
	
	@Modifying
	@Query("UPDATE LineManager l SET l.password = :password WHERE l.id = :id")
	public void updatePassword( Long id,String password);
	
	public Optional<LineManager> findByEmail(String user);
	
	public Optional<LineManager> findByEmpCodeAndPassword(String user, String password);
}
