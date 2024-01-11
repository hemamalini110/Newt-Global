package com.blog.SpringStarter.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.blog.SpringStarter.models.Account;
import com.blog.SpringStarter.models.Post;
import com.blog.SpringStarter.services.AccountService;
import com.blog.SpringStarter.services.PostService;

@Component
public class SeedData implements CommandLineRunner{

    @Autowired
    private PostService postService;
    
    @Autowired
    private AccountService accountService;

    @Override
    public void run(String... args) throws Exception {
    	
       Account account01 = new Account();
       Account account02 = new Account();
       
       account01.setEmail("hema@gmail.com");
       account01.setPassword("12345");
       account01.setFirstname("Hema");
       
       account02.setEmail("dev@gmail.com");
       account02.setPassword("12345");
       account02.setFirstname("Dev");
       
       accountService.save(account01);
       accountService.save(account02);

       List<Post> posts = postService.getAll();
       if (posts.size() == 0){
            Post post01 = new Post();
            post01.setTitle("Post 01");
            post01.setBody("Good things will happen.....................");
            post01.setAccount(account01);
            postService.save(post01);
            

            Post post02 = new Post();
            post02.setTitle("Post 02");
            post02.setBody("Have a good day.....................");
            post02.setAccount(account02);
            postService.save(post02);

       }
        
    }
    
}
