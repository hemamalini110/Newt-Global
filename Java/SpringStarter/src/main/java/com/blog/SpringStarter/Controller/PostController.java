package com.blog.SpringStarter.Controller;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.blog.SpringStarter.models.Post;
import com.blog.SpringStarter.services.PostService;

@Controller
public class PostController {

    @Autowired
    private PostService postService;


    @GetMapping("/post/{id}")
    public String getPost(@PathVariable Long id, Model model){
        Optional<Post> optionalPost = postService.getById(id);

        if(optionalPost.isPresent()){
            Post post = optionalPost.get();
            model.addAttribute("post", post);
            return "post";
        }else{
            return "404";
        }
    }
    
}
