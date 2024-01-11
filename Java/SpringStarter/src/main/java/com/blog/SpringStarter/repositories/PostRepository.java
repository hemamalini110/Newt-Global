package com.blog.SpringStarter.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.blog.SpringStarter.models.Post;

@Repository
public interface PostRepository extends JpaRepository<Post, Long>{
    
}
