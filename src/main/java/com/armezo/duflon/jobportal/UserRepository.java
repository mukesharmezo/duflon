package com.armezo.duflon.jobportal;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserRegistration, Long> {

	@Query("SELECT u FROM UserRegistration u WHERE u.jobId=:jobId")
	List<UserRegistration> findUserByJobId(Long jobId);

	@Query("SELECT u FROM UserRegistration u WHERE u.accesskey=:accesskey")
	Optional<UserRegistration> getUserByAccesskey(String accesskey);

}
