package com.sb.security.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sb.security.entity.UserEntity;
import com.sb.security.repo.UserRepo;

@Service
public class UserService implements UserDetailsService
{
	@Autowired
	private UserRepo userRepo ;
	
	@Autowired(required=false)
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Optional<UserEntity> userinfo = userRepo.findByName(username);
		return userinfo.map(UserInfoDetails::new)
				.orElseThrow(()->new UsernameNotFoundException("User not found"+username));
		
	}
	
	public String addUser(UserEntity userEntity)
	{
		userEntity.setPassword(passwordEncoder.encode(userEntity.getPassword()));
		userRepo.save(userEntity);
		return "User Added Successfully";
	}
	
	
	public List<UserEntity> getAllUser()
	{
		return userRepo.findAll();
	}
	
	public UserEntity getUser(Integer id)
	{
		return userRepo.findById(id).get();
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
