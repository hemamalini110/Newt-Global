package com.sb.security.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.User;

import com.sb.security.entity.UserEntity;

public interface UserRepo extends JpaRepository<UserEntity, Integer>
{

	Optional<UserEntity> findByName(String name);
}
