package com.hm.exam.repository.question;

import java.math.BigInteger;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;

public interface QuestionRepository extends PagingAndSortingRepository<QuestionEntity, Long> {
	
	Iterable<QuestionEntity> findByIdIn(List<Long> questionIdList);
	
	Integer countByLibrary(LibraryEntity library);
	
	Integer countByType(Integer type);
	
	List<QuestionEntity> findByLibraryOrderByUpdateTimeDesc(LibraryEntity library);
	
	List<QuestionEntity> findByTypeOrderByUpdateTimeDesc(Integer type);
	
	List<QuestionEntity> findByLibraryAndTypeOrderByUpdateTimeDesc(LibraryEntity library, Integer type);
	
	List<QuestionEntity> findByOrderByUpdateTimeDesc();
	
	Page<QuestionEntity> findByOrderByUpdateTimeDesc(Pageable pageable);
	
	@Query(value = "select id from question_question", nativeQuery = true)
	List<BigInteger> listId();
	
	@Query(value = "select id from question_question where library_id = :libraryId", nativeQuery = true)
	List<BigInteger> listIdByLibraryId(@Param("libraryId") Long libraryId);
	
	@Query(value = "select id from question_question where type = :type", nativeQuery = true)
	List<BigInteger> listIdByType(@Param("type") Integer type);

	/**
	 * 根据题库随机抽取指定数目的试题
	 */
	@Query(value = "select * from question_question where library_id = :libraryId order by RAND() limit :limit", nativeQuery = true)
	List<QuestionEntity> listByLibraryIdOrderByRand(@Param("libraryId") Long libraryId, @Param("limit") Integer limit);
	
}
