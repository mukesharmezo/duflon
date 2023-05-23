package com.armezo.duflon.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.armezo.duflon.Entities.DataList;

@Repository
public interface DataListRepository extends JpaRepository<DataList, Long> {
	
	@Query("SELECT l FROM DataList l WHERE l.listCode=:listCode")
	Optional<DataList> findDataListByListCode(String listCode);
	
	@Query("SELECT listCode FROM DataList l WHERE l.listName=:listName")
	List<String> getBloodGroup(String listName);
	
	@Query("SELECT listCode FROM DataList l WHERE l.listName=:listName")
	List<String> getFa(String listName);
	
	@Query("SELECT l FROM DataList l WHERE l.listName=:listName ORDER BY listDesc ASC")
	List<DataList> findByListName(String listName);

}
