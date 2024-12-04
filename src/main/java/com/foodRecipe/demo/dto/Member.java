package com.foodRecipe.demo.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int id;
    private String email;
    private String pw;
    private String name;
    private String phoneNumber;
    private int bir;
    private String nickName;
    private LocalDate regDate;
    private LocalDate updateDate;
    
    public Member(String email, String pw, String name, String phoneNumber, int bir, String nickName) {
    	this.email = email;
    	this.pw = pw;
    	this.name = name;
    	this.phoneNumber = phoneNumber;
    	this.bir = bir;
    	this.nickName = nickName;
    }
}
