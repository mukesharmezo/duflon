package com.armezo.duflon.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.EventLoger;

@Repository
public interface EventLogerRepository extends JpaRepository<EventLoger, Integer> {

}
