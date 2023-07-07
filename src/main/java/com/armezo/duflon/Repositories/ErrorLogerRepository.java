package com.armezo.duflon.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.ErrorLogger;
@Repository
public interface ErrorLogerRepository extends JpaRepository<ErrorLogger, Long> {

}
