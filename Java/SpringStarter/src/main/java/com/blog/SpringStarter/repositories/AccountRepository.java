package com.blog.SpringStarter.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.blog.SpringStarter.models.Account;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long>{
    
}

